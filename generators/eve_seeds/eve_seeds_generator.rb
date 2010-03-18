require File.join(File.dirname(__FILE__), '../../lib/eve-dump')

class EveSeedsGenerator < RubiGen::Base

  default_options :author => nil

  attr_reader :name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @dbfile = args.shift
    extract_options
  end

  def manifest
    puts "Note: DB file takes some time to load. Please wait..."
    sql = File.read(File.expand_path File.join(File.dirname(__FILE__), '../../data', @dbfile))
    puts "SQL file has been loaded and is now being processed."
    
    pre = Eve::Dump::Prerelease.new(sql)
    #puts "SQL file has been converted to something usable, and is now generating seeds."
    
    record do |m|
      m.directory 'db/seeds'
      pre.tables.sort { |a,b| a.name <=> b.name }.each do |table|
        fi = "db/seeds/#{table.model_name.underscore}_seeds.rb"
        puts "Generating seeds for #{table.name} in '#{fi}'..."
        $stdout.flush
        m.template fi, 'seed.erb', :locals => { :table => table, :insertions => table.insertions }
      end
    end
  end

  protected
    def banner
      <<-EOS
Creates a ...

USAGE: #{$0} #{spec.name} name
EOS
    end

    def add_options!(opts)
      # opts.separator ''
      # opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |o| options[:author] = o }
      # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end
end