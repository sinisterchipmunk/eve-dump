class Eve::Dump::Prerelease
  attr_reader :raw_sql

  def initialize(sql)
    @raw_sql = sql
  end

  def table_count
    tables.length
  end

  def to_rails_insertions
    r = ''
    insertions.collect do |table, insertions|
      r.concat table.model_name
      r.concat ".create(#{insertions.inspect})\n"
    end
    r
  end

  def insertions
    tables.inject({}) do |hash, table|
      hash[table] = table.insertions
      hash
    end
  end

  def tables
    return @tables if @tables
    @tables = {}
    
    logging = false
    sql = ''
    table_name = nil
    raw_sql.each do |line|
      if line =~ /CREATE TABLE `([^`]+)`/
        logging = true
        table_name = $~[1]
        puts "Found table declaration: #{table_name}"
      end

      sql << line if logging

      if line =~ /\) ENGINE=MyISAM/
        puts "Mapping insertions for table #{table_name}"
        @tables[table_name] ||= Eve::Dump::Prerelease::Table.new(sql)
        sql = ''
        logging = false
      end

      if line =~ /INSERT INTO `([^`]+)` VALUES \((.*?)\);/
        insertion = $~[0]
        table_name, values = $~[1], $~[2]
        raise "Expected insertion to include table name: #{insertion}" unless table_name
        raise "Didn't expect an insertion within table declaration: #{insertion}" if logging
        raise "Didn't expect an insertion into a table that hasn't been declared: #{insertion}" unless @tables[table_name]

        @tables[table_name].add_insertion values
      end
    end

    puts "SQL has been converted and Prerelease object is ready for use."
    @tables = @tables.values
  end
end
