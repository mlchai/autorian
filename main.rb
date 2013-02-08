require './autorian.rb'

ar = AutoRian.new
#ar.videos_from_db({:claimed_by_this_owner => "true", :claimed_by_another_owner => "false"})
f = File.new('omg/hi.txt', 'w')
f.write(ar.batch3)
f.close