require 'csv'
LOCAL_DIR="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
AMP_TABLE=CSV.parse(File.read(LOCAL_DIR + "ex5.csv"), headers: false)
FREQ_TABLE=CSV.parse(File.read(LOCAL_DIR + "freq5.csv"), headers: false)
FILTER = 0.009

puts "the script will cut off frequences with amplitude lower than #{FILTER}."

column_in_amp = AMP_TABLE.transpose[0].size - 1
master_chords_array = []

column_in_amp.times do |i|
    accordo = []
    AMP_TABLE[i-1].length.times do |n|
      if AMP_TABLE[i-1][n-1].to_f > FILTER 
            accordo.push([FREQ_TABLE[0][n-1].to_f,AMP_TABLE[i-1][n-1].to_f]) # [[freq, amp], [freq, amp] ...]
      end
    end
    if accordo.length > 10 # [[79.6, 0.99], [60.8, 0.98 ], [90,0.97],[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
        cutted_master_chords_array = accordo.sort {|a, b| b[1] <=> a[1]}.first(10)
        master_chords_array.push(cutted_master_chords_array) # [[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
    else master_chords_array.push(accordo) if accordo.length > 0 # accordo: [[79.6, 0.8], [60.8, 0.9 ], [90,0.77]]
    end
end

master_chords_array.length.times do |y|
  master_chords_array[y-1].length do |z|
    r=0
    r += 1 while (defined?master_chords_array[y-1 +r] and master_chords_array[y-1+r].collect {|ind| ind[0]}.include?(master_chords_array[y-1][z][0])) || !defined?master_chords_array[y]
    puts r
    master_chords_array[y][z].push(r);
  end
end


# unless 
# play if somenthing and something else
# no use for loops. preference to times /each
# or :#