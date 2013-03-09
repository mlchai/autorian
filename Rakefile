require 'rawr'
require 'rubygems'
require 'jdbc/sqlite3'
require 'java'
require './src/config.rb'

require './src/autorian.rb'

task :bundle do
  
end

task :setup_db do
  ar = AutoRian.new
  ar.setup_db
end

task :load_csv do
  ar = AutoRian.new
  ar.load_csv 'video_report_FullScreen_V_0.csv'
end

task :wipe_db do
  ar = AutoRian.new
  ar.wipe_db
  
  puts 'Videos cleared!'
end
