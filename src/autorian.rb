require 'rubygems'
require 'sqlite3'
require 'csv'
require './src/config.rb'
require 'pry'

class AutoRian
  POS = 'Yes'
  NEG = 'No'
  
  def connect
    @connection = SQLite3::Database.new "db/#{RianConfig::DATABASE[:name]}"
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
    
    @connection.execute query
  end
  
  def wipe_db
    connect
    
    query = 'drop table videos;'
  
    @connection.execute query
  end

  def load_csv(file)
    connect

    csv = CSV.read(file)
    headers = csv.slice!(0)

    csv.each do |row|
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
      
      @connection.execute(insert)
    end
  end 

  def videos_from_db(params, exclude, headers)
    connect

    videos = []
    select = select params, exclude.split(','), headers
    
    puts select

    @connection.execute(select) do |row|
      videos << row
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
