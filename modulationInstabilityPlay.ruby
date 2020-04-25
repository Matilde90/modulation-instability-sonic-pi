require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "ex5.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq5.csv"), headers: false)

filter = 0.009;
puts "the script will cut off frequences with amplitude lower than #{filter}.";

##
# Function that gets how many times the notes are repeated
# @param count [integer]
# @param thisarray
# @param array
# @param freq
# @param y
##
def getCount(count, thisarray, array, freq, y, i)
  if thisarray.include?(freq);
        count = count + 1;
            if array[i - 1 + count];
            getCount(count, array[i - 1 + count][0], array, freq, y, i);
            else
            return count;
            end
    else
    return count;
    end
end

# gets number of column in amp table
column_in_amp = amp_table.transpose[0].size - 1;

array = [];
# every column_in_amp
for c in 0..column_in_amp do
    # get array with the amplitude data of the first accordo
    amp_table_array = amp_table[c];
    num_element_in_amp_array= amp_table_array.length;
    # create a accordo array
    accordo = [];
    for n in 0..num_element_in_amp_array;
      if amp_table_array[n].to_f > filter;
        freq = freq_table[0][n].to_f;
        amp = amp_table_array[n].to_f;
        accordo.push([freq,amp]);
      end
    end
    if accordo.length > 10;
        sorted_array=accordo.sort {|a, b| b[1] <=> a[1]}
        cutted_array = sorted_array.first(10)
        array.push(cutted_array)
       # difference in order may alter the result
    elsif accordo.length > 0
      array.push(accordo);
    end
end
  
  puts "needs a break as this is high workload. Starting in 8 seconds"
  
  sleep 8;
  
  if array.length >0
    for i in 1441..array.length
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
        count=0
        for z in 1...freq_to_play.length do
            # there is an issue with this sustain
            # gets count of how many times the note is repeated
            count = getCount(count, array[i-1][0], array, freq_to_play[z-1], y, i);
            
            # sees if the frequence was played before and if so, it ends the loop
            # as the note is still playing
            if !array[i-2][0].include?(freq_to_play[z-1])
              
            # amplitude gaussian filtering to adjust amp to play
            # now 0 < amp < 1;
            # degree of uniformity of notes played.
            # The greater sigma is, the more uniform will be the amplitudes
            sigma=100; 
            n=1;
            adjustedAmp=Math.exp(-(1/amp_to_play[z-1])**(2*n)/(sigma**(2*n)));  

            sustain_count=count * 0.3;
            # resetting count
            count = 0
            puts "sustain: #{sustain_count}, amp: #{adjustedAmp}, freq: #{freq_to_play[z-1]}"
    #          play freq_to_play[z-1], amp: adjustedAmp, sustain: sustain_count;
            end
          end
          sleep 0.3;
        end
      end
    end
    