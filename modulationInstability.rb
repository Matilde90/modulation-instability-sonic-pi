require 'csv'
LOCAL_DIR="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
AMP_TABLE=CSV.parse(File.read(LOCAL_DIR + "ex5.csv"), headers: false)
FREQ_TABLE=CSV.parse(File.read(LOCAL_DIR + "freq5.csv"), headers: false)
FILTER = 0.00005
SLEEP_TIME=0.3
MAX_NOTES_IN_CHORDS=10

puts "the script will cut off frequences with amplitude lower than #{FILTER}."

column_in_amp = AMP_TABLE.transpose[0].size - 1
master_chords_array = []

# prepares chords to play in master array
column_in_amp.times do |i|
  accordo = []
  AMP_TABLE[i].length.times do |y|
    # filters out frequences with amplitude lower than filter
    if AMP_TABLE[i][y].to_f > FILTER
      accordo.push([FREQ_TABLE[0][y].to_f,AMP_TABLE[i][y].to_f]) # [[freq, amp], [freq, amp] ...]
    end
  end
  # ensures chords have no more than 20 frequences
  if accordo.length > MAX_NOTES_IN_CHORDS # accordo [[79.6, 0.99], [60.8, 0.98 ], [90,0.97],[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
    cutted_master_chords_array = accordo.sort {|a, b| b[1] <=> a[1]}.first(10)
    master_chords_array.push(cutted_master_chords_array) # cutted array: [[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
  else master_chords_array.push(accordo) if accordo.length > 0 # if accordo: [[79.6, 0.8], [60.8, 0.9 ], [90,0.77]]
  end
end

puts "understanding note length"
sleep 7

# adding info about how many times a certain note is repeated in master array
master_chords_array.length.times do |i|
  master_chords_array[i].length.times do |y|
    # scales amplitudes to an audible range
    sigma=100;
    n=2;
    scaledAmp=Math.exp(-(1/master_chords_array[i].collect {|ind| ind[1]}[y])**(2*n)/(sigma**(2*n)));
    # keeps track of how many times the note is repeated in subsequent chords
    r=0
    r += 1 while (not master_chords_array[i+r].nil? and master_chords_array[i+r].collect{|ind| ind[0]}.include?(master_chords_array[i][y][0])) or master_chords_array[i].nil?
    master_chords_array[i][y].push(scaledAmp, r);
  end
end

p "understanding note length"
sleep 15

# add whether the note needs to be played
master_chords_array.length.times do |i|
  master_chords_array[i].length.times do |y|
    # if s is different from 0 and the frequence is contained in the previous array, remove it.
    if (i!=0 and master_chords_array[i-1])
      #  "s: #{s} t: #{t}, acc: #{master_chords_array[i][y][0]}, master_chords_array: #{master_chords_array[s-1].collect{|ind| ind[0]}}"
      if master_chords_array[i-1].collect{|ind| ind[0]}.include?(master_chords_array[i][y][0])
        master_chords_array[i][y].push("silent")
      else
        master_chords_array[i][y].push("play")
      end
    else
      master_chords_array[i][y].push("play")
    end
  end
end

sleep 3
puts "starting in 3 seconds"
sleep 3

# new data array structure
# [[[freq, amp, scaledAmp, r, play|silent][freq, amp, scaledAmp, r, play|silent]],[[freq, amp, scaledAmp, r, play|silent][freq, amp, scaledAmp, r, play|silent]] ]

use_synth :hollow
master_chords_array.length.times do |i|
puts i
  master_chords_array[i].length.times do |y|
    if master_chords_array[i][y][4] == "play"
      ##| p  master_chords_array[i][y][0] + master_chords_array[i][y][2] +  master_chords_array[i][y][3] * SLEEP_TIME
      if i < 18 and i > 3 
        play master_chords_array[i][y][0], amp: master_chords_array[i][y][2], sustain: (master_chords_array[i][y][3] * SLEEP_TIME) + 0.2, attack: 0
      elsif i <= 8 
        play master_chords_array[i][y][0], amp: master_chords_array[i][y][2], sustain: (master_chords_array[i][y][3] * SLEEP_TIME) + 0.4, attack: 0
      elsif i >= 18
        play  master_chords_array[i][y][0], amp: master_chords_array[i][y][2], sustain: master_chords_array[i][y][3] * SLEEP_TIME, attack: 0
      end
    else
    end
  end
  if i < 18 && i > 3 
    sleep SLEEP_TIME + 0.2 
  elsif i <= 8 
    sleep SLEEP_TIME + 0.4 
  else 
  sleep SLEEP_TIME 
end
end