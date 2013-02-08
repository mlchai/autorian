require 'rubygems'
require 'jdbc/sqlite3'
require 'java'
require './config.rb'

require 'autorian'

task :bundle do
  
end

task :setup_db do
  org.sqlite.JDBC

  connection = java.sql.DriverManager.getConnection 'jdbc:sqlite:' + RianConfig::DATABASE[:name]
  query = 'create table videos ('
  headers = RianConfig::HEADERS.split(',')
  types = RianConfig::DATA_TYPES.split(',')
  (0..headers.length - 1).each do |i|
    query += headers[i] + ' ' + types[i]
    query += ', ' unless i == headers.length - 1
  end

  query += ');'

  puts query
  begin
    statement = connection.createStatement
    statement.executeUpdate(query)
  ensure
    statement.close
    connection.close
  end
end

task :load_csv do
  ar = AutoRian.new
  ar.load_csv 'video_report_FullScreen_V_0.csv'
end

task :wipe_db do
  org.sqlite.JDBC

  connection = java.sql.DriverManager.getConnection 'jdbc:sqlite:' + RianConfig::DATABASE[:name]
  query = 'drop table videos;'
  
  begin
    statement = connection.createStatement
    statement.executeUpdate(query)
  ensure
    statement.close
    connection.close
  end
  
  puts 'Videos cleared!'
end