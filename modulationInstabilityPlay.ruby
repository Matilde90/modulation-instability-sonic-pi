require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "ex5.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq5.csv"), headers: false)

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
      # puts amp_table_array[n].to_f.inspect;
      if amp_table_array[n].to_f > 0.03;
        freq = freq_table[0][n].to_f;
        amp = amp_table_array[n].to_f;
        accordo.push([freq,amp]);
        puts accordo.inspect;
      end
    end
    if accordo.length > 0
      array.push(accordo);
    end
    puts accordo.inspect
  end
  
  sleep 10;
  puts "starting in 5 seconds"
  
  sleep 5;
  
  if array.length >0
    puts "arrives here"
    for i in 0..array.length
      accordo = array[i- 1];
      freq_to_play=[];
      amp_to_play=[];
      if accordo.length > 0;
        for y in 0..accordo.length
          freq_p=accordo[y - 1][0];
          amp_p=accordo[y - 1][1];
          freq_to_play.push(freq_p);
          amp_to_play.push(amp_p);
        end
        puts i;
        for z in 1...freq_to_play.length do
            play freq_to_play[z-1], amp: amp_to_play[z -1], release: 0.2;
          end
          sleep 0.15;
        end
      end
    end