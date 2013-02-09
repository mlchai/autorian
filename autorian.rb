require 'rubygems'
require 'jdbc/sqlite3'
require 'java'
require 'csv'
require './config.rb'

class AutoRian
  POS = 'Yes'
  NEG = 'No'
  
  def connect
    org.sqlite.JDBC
    @connection = java.sql.DriverManager.getConnection 'jdbc:sqlite:' + RianConfig::DATABASE[:name]
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
  
  def batch1
    videos_from_db({claimed_by_this_owner: POS, claimed_by_another_owner: NEG, status: 'Public', afv_overlay_enabled: NEG})
  end
  
  def batch2
    videos_from_db({claimed_by_this_owner: POS, claimed_by_another_owner: NEG, status: 'Public', instream_ads_enabled: NEG})
  end
  
  def batch3
    videos_from_db({claimed_by_this_owner: POS, claimed_by_another_owner: NEG, status: 'Public', trueview_instream_enabled: NEG})
  end
  
  def batch4
    #videos_from_db({claimed_by_this_owner: POS, claimed_by_another_owner: NEG, status: 'Public', })
  end
  
  def batch5
    #videos_from_db({claimed_by_this_owner: POS, claimed_by_another_owner: NEG, status: 'Public', })
  end
  
  def prebatch
    
  end

  def videos_from_db(params)
    connect

    videos = []
    begin
      statement = @connection.createStatement
      select = select params

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
    select = 'select * from videos'
      
    unless params.nil?
      select += ' where ' if params.length > 0
      params.each_with_index { |(key, value), index| select += key.to_s + '="' + value + '" AND ' }
      select = select[0..-6] + ';'
    end
    
    select
  end
end