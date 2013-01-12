require './autorian.rb'

ar = AutoRian.new
ar.videos_from_db({:claimed_by_this_owner => true})
