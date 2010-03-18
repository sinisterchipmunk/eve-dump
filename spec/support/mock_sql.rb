module MockSQL
  def mock_sql(filename)
    File.read(File.join(File.dirname(__FILE__), 'sql', "#{filename}.sql"))
  end
end

Spec::Runner.configure do |config|
  config.include MockSQL
end
