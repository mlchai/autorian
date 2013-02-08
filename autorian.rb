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
  
  def batch1
    videos_from_db({claimed_by_this_owner: 'true', claimed_by_another_owner: 'false', status: 'Public', afv_overlay_enabled: 'false'})
  end
  
  def batch2
    videos_from_db({claimed_by_this_owner: 'true', claimed_by_another_owner: 'false', status: 'Public', instream_ads_enabled: 'false'})
  end
  
  def batch3
    videos_from_db({claimed_by_this_owner: 'true', claimed_by_another_owner: 'false', status: 'Public', trueview_instream_enabled: 'false'})
  end
  
  def batch4
    
  end
  
  def batch5
    
  end
  
  def prebatch
    
  end

  def videos_from_db(params)
    connect

    videos = []
    begin
      statement = @connection.createStatement
      select = 'select * from videos'
      
      unless params.nil?
        select += ' where ' if params.length > 0
        params.each_with_index { |(key, value), index| select += key.to_s + '="' + value + '" AND ' }
        select = select[0..-6] + ';'
        puts select
      end

      query = statement.executeQuery(select)
      while query.next
        videos << query.getString(1)
      end

    ensure
      statement.close
      @connection.close
    end

    puts videos
    videos
  end

  def select(params)
    query = 'select * from videos where'
    params.each_with_index { |(key, value), index| query += ' ' + key + "='" + value + "'" }

    query + ';'
  end
end