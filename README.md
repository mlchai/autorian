#AUTORIAN!!!!

CSV parser for use by NetOps (Rian Bosak). Takes in large csvs, loads them into a SQLite database, and constructs queries to be run given paramters by Rian. Outputs results in a batch.txt file. Run from command line, using Jruby.

Typical command takes the following parameters, separated by spaces:

file.csv "channel1,channel2" 'video_id, username' status Public claimed_by_owner false

file.csv is the csv file

"channel1,channel2" is the list of channels to exclude (it's important to have no spaces between the commas)

'video_id,username' is a list of columns to return

all paramters after that follow a specific pattern: column value, so status Public claimed_by_owner false would be status='Public' AND claimed_by_owner=false in the query.
