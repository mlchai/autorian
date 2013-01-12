require 'rubygems'
require 'jdbc/sqlite3'
require 'java'
require 'csv'
require './config.rb'

class AutoRian
  def connect
    org.sqlite.JDBC
    @connection = java.sql.DriverManager.getConnection 'jdbc:sqlite:' + RianConfig::DATABASE[:name]
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
            if r == 'Yes'
              r = 'true'.to_s
            elsif r == 'No'
              r = 'false'.to_s
            elsif r.nil?
              r = '0'
            else
              #r = "'" + r + "'"
              r.gsub!(/'/, "")
            end

            insert += "'" + r + "', " 
          end
          insert = insert[0..-3]
          insert += ')'
          puts insert
          puts 'help' if insert.nil?
          statement.executeUpdate(insert)
        ensure
          statement.close
        end
      end
    ensure
      @connection.close
    end
  end

  def videos_from_db(params)
    connect

    videos = []
    begin
      statement = @connection.createStatement
      select = 'select * from videos'
      
      unless params.nil?
        select += ' where ' if params.length > 0
        params.each_with_index { |(key, value), index| select += key.to_s + "=true" }
        puts "HI GUISE"
      end

      query = statement.executeQuery(select)
      while query.next
        videos << query.getString(1)
        #puts query.getString(19)
      end

      puts select
    ensure
      statement.close
      @connection.close
    end

    videos
    "hello"
  end

  def select(params)
    query = 'select * from videos where'
    params.each_with_index { |(key, value), index| query += ' ' + key + "='" + value + "'" }

    query + ';'
  end
end

#ar = AutoRian.new
#ar.load_csv 'video_report_FullScreen_V_0.csv'
#puts ar.videos_from_db nil
