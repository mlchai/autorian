require './autorian.rb'

ar = AutoRian.new
#ar.videos_from_db({:claimed_by_this_owner => "true", :claimed_by_another_owner => "false"})
f = File.new('batch1.txt', 'w')
f.write(ar.batch1)
f.close

f = File.new('batch2.txt', 'w')
f.write(ar.batch2)
f.close

f = File.new('batch3.txt', 'w')
f.write(ar.batch3)
f.close