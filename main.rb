require './autorian.rb'

ar = AutoRian.new

if ARGV[0]
  ar.wipe_db
  ar.setup_db
  ar.load_csv ARGV[0]

  f = File.new('batch1.txt', 'w')
  f.write(ar.batch1)
  f.close

  f = File.new('batch2.txt', 'w')
  f.write(ar.batch2)
  f.close

  f = File.new('batch3.txt', 'w')
  f.write(ar.batch3)
  f.close
else
  puts 'Need a file to parse!'
end