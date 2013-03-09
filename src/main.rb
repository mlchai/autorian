require './src/autorian.rb'
require './src/config.rb'

ar = AutoRian.new

if ARGV[0]
  params = {}
  i = 1
  headers = RianConfig::HEADERS.split(',')
  while i < ARGV.length
    abort "no such column #{ARGV[i]}, maybe it's mistyped?" if headers.grep(ARGV[i]).empty?
    params[ARGV[i]] = ARGV[i+1]
    i = i + 2
  end

  ar.wipe_db
  ar.setup_db
  ar.load_csv ARGV[0]

  output = ''
  arr = ar.videos_from_db(params)
  arr.each { |i| output += i + "\n" }
  f = File.new('batch.txt', 'w')
  f.write(output)
  f.close
else
  puts 'Need a file to parse!'
end
