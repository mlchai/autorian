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

    csv.each do |row|
      begin
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
      ensure
        @connection.close
      end

      #puts insert
    end
  end

  def videos_from_db(params)
    connect

    videos = []
    begin
      statement = @connection.createStatement
      query = statement.executeQuery("select * from videos")
      
      while query.next
        videos << query.getString(1)
      end
    ensure
      statement.close
      query.close
    end

    videos
  end

  def select(params)
    query = 'select * from videos where'
    params.each_with_index { |(key, value), index| query += ' ' + key + "='" + value + "'" }

    query + ';'
  end
end

ar = AutoRian.new
ar.connect
ar.load_csv 'video_report_FullScreen_V_0.csv'
