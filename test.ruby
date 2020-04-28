# array = [["A", 0.9], ["g", 0.08], ["e", 0.7], ["ab", 0.75], ["CC", 6], [4, 0.3], [2, 0.6]];
# sorted_array=array.sort {|a, b| b[1] <=> a[1]}
# puts sorted_array.inspect
# limited_array = sorted_array.first(3)
# puts limited_array.inspect


# arr = [[:z,1], [:d,3], [:e,2]]
# sortedArr = arr.sort {|a,b| a[1] <=> b[1]}
# puts sortedArr.inspect

# i = 1
# array_of_array = [[["A", 0.9], ["g", 0.08], ["e", 0.7]], [["ab", 0.75], ["CC", 6]],[ [4, 0.3], [2, 0.6]]];
# accordo_freq=array_of_array[i- 1].collect {|ind| ind[0]};
# puts accordo_freq.inspect
# i = 2
# array_of_array = [[["A", 0.9], ["g", 0.08], ["e", 0.7]], [["ab", 0.75], ["CC", 6]],[ [4, 0.3], [2, 0.6]]];
# accordo_freq=array_of_array[i- 1].collect {|ind| ind[0]};
# puts accordo_freq.inspect
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
    # scales amplitudes to an audible range
    sigma=100; 
    n=1;
    adjustedAmp=Math.exp(-(1/master_chords_array[y].collect {|ind| ind[1]}[z])**(2*n)/(sigma**(2*n)));
    # keeps track of how many times the note is repeated in subsequent chords
    r=0
    r += 1 while (not master_chords_array[y+r].nil? and master_chords_array[y+r].collect{|ind| ind[0]}.include?(master_chords_array[y][z][0])) or master_chords_array[y].nil?
    master_chords_array[y][z].push(adjustedAmp, r);
  end
end

puts master_chords_array[1441][0].inspect
puts master_chords_array[1441][1].inspect
puts master_chords_array[1441][2].inspect
puts master_chords_array[1441][3].inspect

puts master_chords_array[1441].length