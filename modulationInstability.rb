require 'csv'
LOCAL_DIR="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
AMP_TABLE=CSV.parse(File.read(LOCAL_DIR + "ex5.csv"), headers: false)
FREQ_TABLE=CSV.parse(File.read(LOCAL_DIR + "freq5.csv"), headers: false)
FILTER = 0.000005
SLEEP_TIME=0.1
MAX_NOTES_IN_CHORDS=20

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
  # ensures chords have no more than 20 frequences
  if accordo.length > MAX_NOTES_IN_CHORDS # accordo [[79.6, 0.99], [60.8, 0.98 ], [90,0.97],[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
    cutted_master_chords_array = accordo.sort {|a, b| b[1] <=> a[1]}.first(10)
    master_chords_array.push(cutted_master_chords_array) # cutted array: [[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
  else master_chords_array.push(accordo) if accordo.length > 0 # if accordo: [[79.6, 0.8], [60.8, 0.9 ], [90,0.77]]
  end
end

sleep 5

# adding info about how many times a certain note is repeated in master array
master_chords_array.length.times do |y|
  master_chords_array[y].length.times do |z|
    # scales amplitudes to an audible range
    sigma=100;
    n=1;
    scaledAmp=Math.exp(-(1/master_chords_array[y].collect {|ind| ind[1]}[z])**(2*n)/(sigma**(2*n)));
    # keeps track of how many times the note is repeated in subsequent chords
    r=0
    r += 1 while (not master_chords_array[y+r].nil? and master_chords_array[y+r].collect{|ind| ind[0]}.include?(master_chords_array[y][z][0])) or master_chords_array[y].nil?
    master_chords_array[y][z].push(scaledAmp, r);
  end
end

sleep 3

# add whether the note needs to be played
master_chords_array.length.times do |s|
  master_chords_array[s].length.times do |t|
    # if s is different from 0 and the frequence is contained in the previous array, remove it.
    if (s!=0 and master_chords_array[s-1])
      puts "s: #{s} t: #{t}, acc: #{master_chords_array[s][t][0]}, master_chords_array: #{master_chords_array[s-1].collect{|ind| ind[0]}}"
      if master_chords_array[s-1].collect{|ind| ind[0]}.include?(master_chords_array[s][t][0])
        master_chords_array[s][t].push("silent")
      else
        master_chords_array[s][t].push("play")
      end
    else
      master_chords_array[s][t].push("play")
    end
  end
end

sleep 4
# new data array structure
# [[[freq, amp, scaledAmp, r, play|silent][freq, amp, scaledAmp, r, play|silent]],[[freq, amp, scaledAmp, r, play|silent][freq, amp, scaledAmp, r, play|silent]] ]
master_chords_array.length.times do |s|
puts s
  master_chords_array[s].length.times do |t|
    if master_chords_array[s][t][4] == "play"
      play  master_chords_array[s][t][0], amp: master_chords_array[s][t][2], sustain: master_chords_array[s][t][3] * SLEEP_TIME, attack: 0
    else
    end
  end
sleep SLEEP_TIME
end