require 'csv'
LOCAL_DIR="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
AMP_TABLE=CSV.parse(File.read(LOCAL_DIR + "ex5.csv"), headers: false)
FREQ_TABLE=CSV.parse(File.read(LOCAL_DIR + "freq5.csv"), headers: false)
FILTER = 0.009

puts "the script will cut off frequences with amplitude lower than #{FILTER}."

column_in_amp = AMP_TABLE.transpose[0].size - 1
master_chords_array = []

# prepares chords to play in master array
column_in_amp.times do |i|
  puts i
    accordo = []
    AMP_TABLE[i].length.times do |n|
      # filters out frequences with amplitude lower than filter
      if AMP_TABLE[i][n].to_f > FILTER 
            accordo.push([FREQ_TABLE[0][n].to_f,AMP_TABLE[i][n].to_f]) # [[freq, amp], [freq, amp] ...]
      end
    end
    # ensures chords have no more than 10 frequences
    if accordo.length > 10 # [[79.6, 0.99], [60.8, 0.98 ], [90,0.97],[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
        cutted_master_chords_array = accordo.sort {|a, b| b[1] <=> a[1]}.first(10)
        master_chords_array.push(cutted_master_chords_array) # [[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
    else master_chords_array.push(accordo) if accordo.length > 0 # accordo: [[79.6, 0.8], [60.8, 0.9 ], [90,0.77]]
    end
end

# adding info about how many times a certain note is repeated in master array
master_chords_array.length.times do |y|
  master_chords_array[y].length.times do |z|
    
    sigma=100; 
    n=1;
    adjustedAmp=Math.exp(-(1/master_chords_array[y].collect {|ind| ind[1]}[z])**(2*n)/(sigma**(2*n))); 
    r=0
    r += 1 while (not master_chords_array[y+r].nil? and master_chords_array[y+r].collect{|ind| ind[0]}.include?(master_chords_array[y][z][0])) or master_chords_array[y].nil?
    master_chords_array[y][z].push(r, adjustedAmp);
  end
end

puts master_chords_array.inspect

# unless 
# play if somenthing and something else
# no use for loops. preference to times /each
# or :#