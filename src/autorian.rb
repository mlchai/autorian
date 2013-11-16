require 'rubygems'
require 'jdbc/sqlite3'
require 'java'
require 'csv'
require './src/config.rb'
require 'pry'

class AutoRian
  POS = 'Yes'
  NEG = 'No'
  
  def connect
    org.sqlite.JDBC
    java.sql.DriverManager.registerDriver Java::JavaClass.for_name("org.sqlite.JDBC")
    @connection = java.sql.DriverManager.getConnection 'jdbc:sqlite:db/' + RianConfig::DATABASE[:name]
  end
  
  def setup_db
    connect
    
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
      statement = @connection.createStatement
      statement.executeUpdate(query)
    ensure
      statement.close
      @connection.close
    end
  end
  
  def wipe_db
    connect
    
    query = 'drop table videos;'
  
    begin
      statement = @connection.createStatement
      statement.executeUpdate(query)
    ensure
      statement.close
      @connection.close
    end
  end

  def load_csv(file)
    connect

    csv = CSV.read(file)
    headers = csv.slice!(0)

    begin
      csv.each do |row|
        statement = @connection.createStatement
        begin
          insert = 'insert into videos values ('
          row.each do |r|
            if r.nil?
              r = ''
            else
              r.gsub!(/'/, "")
            end

            insert += "'" + r + "', " 
          end
          insert = insert[0..-3]
          insert += ')'
          puts insert
          statement.executeUpdate(insert)
        ensure
          statement.close
        end
      end
    ensure
      @connection.close
    end
  end 

  def videos_from_db(params, exclude, headers)
    connect

    videos = []
    begin
      statement = @connection.createStatement
      select = select params, exclude.split(','), headers

      query = statement.executeQuery(select)
      
      while query.next
        #binding.pry
        row = ''
        headers.split(',').each { |header| row += "'#{query.getString(header)}',"  }
        videos << row
      end

    ensure
      statement.close
      @connection.close
    end

    puts videos
    videos
  end

  def select(params, exclude=nil, headers=nil)
    columns = headers || '*'

    select = "select #{columns} from videos"
    
    unless params.nil?
      select += ' where ' if params.length > 0
      params.each_with_index { |(key, value), index| select += key.to_s + '="' + value + '" AND ' }
      if exclude
        #select
        exclude.each { |username| select += "username != '#{username}' AND " }
        
      end
      
      select = select[0..-6] + ';'
    end
    
    select
  end
end
