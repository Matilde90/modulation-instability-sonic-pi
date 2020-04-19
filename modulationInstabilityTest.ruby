require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "/ampiezzeModulation.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq.csv"), headers: false)

##
# Raw index is the time-index of the chord.
# The values is the amplitude of the frequency
##
amp_row= 0
amp_col= 0
freq_col= 0

first_chord_amp = amp_table[amp_row];
first_note_amp=first_chord_amp[amp_col];
freq_array = freq_table[amp_row];
# crea accordo


# crea array of notes to play
array = []
for i in 1..freq_array.size do
    if first_chord_amp[i].to_f > 0.1
      array.push(freq_array[i].to_f);
    end
  end
  
  sleep 2;
  play array.ring[i];