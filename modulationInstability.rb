require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "ex5.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq5.csv"), headers: false)

filter = 0.009;
puts "the script will cut off frequences with amplitude lower than #{filter}.";

column_in_amp = amp_table.transpose[0].size - 1;
array = [];

column_in_amp.times do |i|
    accordo = [];
    amp_table[i].length.times do |n|;
      if amp_table[i][n].to_f > filter;
            accordo.push([freq_table[0][n].to_f,amp_table[i][n].to_f]); # [[freq, amp], [freq, amp] ...]
      end
    end
    if accordo.length > 10;
        sorted_array=accordo.sort {|a, b| b[1] <=> a[1]} # [[79.6, 0.99], [60.8, 0.98 ], [90,0.97],[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
        cutted_array = sorted_array.first(10)
        array.push(cutted_array) # [[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
    else array.push(accordo) if accordo.length > 0
             # accordo: [[79.6, 0.8], [60.8, 0.9 ], [90,0.77]]
    end
end


# unless 
# play if somenthing and something else
# no use for loops. preference to times /each
#or :#