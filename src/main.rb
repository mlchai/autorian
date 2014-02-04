require './src/autorian.rb'
require './src/config.rb'

ar = AutoRian.new

if ARGV[0]
  params = {}
  i = 3
  headers = RianConfig::HEADERS.split(',')
  while i < ARGV.length
    abort "no such column #{ARGV[i]}, maybe it's mistyped?" if headers.grep(ARGV[i]).empty?
    params[ARGV[i]] = ARGV[i+1]
    i = i + 2
  end

  ar.wipe_db
  ar.setup_db
  ar.load_csv ARGV[0]

  filename="batch-#{Time.now}.txt"
  output = ''
  arr = ar.videos_from_db(params, ARGV[1], ARGV[2])
  puts 'Preparing output...'
  #arr.each { |i| output += i + "\n" }
  f = File.new(filename, 'a')
  puts "Writing to #{filename}..."
  arr.each do |i|
    f.write("#{i}\n")
  end
  f.close

  puts 'Done!'
else
  puts 'Need a file to parse!'
end
