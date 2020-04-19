require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "ex3.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq.csv"), headers: false)

# number of column in amp table
column_in_amp = amp_table.transpose[0].size - 1;
# number of frequences - we only have one row.
freq_array = freq_table[0];
number_of_freq = freq_array.size;

array = [];
# every column_in_amp
for c in 0..column_in_amp do
    # get array with the amplitude data of the first accordo
    amp_table_array = amp_table[c];
    num_element_in_amp_array= amp_table_array.length;
    # create a accordo array
    accordo = [];
    for n in 0..num_element_in_amp_array;
      if amp_table_array[n].to_f > 0.05;
        freq = freq_table[0][n].to_f;
        amp = amp_table_array[n].to_f;
        accordo.push([freq,amp]);
      end
    end
    if accordo.length > 1
      array.push(accordo);
    end
  end
  
  
  for i in 1..array.length
    accordo = array[i- 1];
    freq_to_play=[];
    amp_to_play=[];
    for y in 1..accordo.length
      freq_p=accordo[y - 1][0];
      amp_p=accordo[y - 1][0];
      freq_to_play.push(freq_p);
      amp_to_play.push(amp_p);
    end
    sleep 3;
    play freq_to_play;
    sleep 1;
  end
