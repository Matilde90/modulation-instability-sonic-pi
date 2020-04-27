require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "ex5.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq5.csv"), headers: false)

filter = 0.009;
puts "the script will cut off frequences with amplitude lower than #{filter}.";

##
# Function that gets how many times the notes are repeated
# @param count [integer] to be incremented and keep track of count
# @param thisarray [60, 71.8, 88, 67]
# @param array [[[2,4],[3,4],...],[[1,2],[6,7],...,.]
# @param freq 88.8
# @param y freq in accordo index
# @param i accordo index
##
# def getCount(count, thisarray, accordo, freq, y)
#   if thisarray.include?(freq);
#         count = count + 1;
#             if array[y - 1 + count];
#             getCount(count, accordo[y - 1 + count][0], accordo, freq, y);
#             else
#             return count;
#             end
#     else
#     return count;
#     end
# end
# def getCount (ripetizione, freq, this_chord, master_array, i)
#     if this_chord.include?(freq);
#         ripetizione= ripetizione + 1;                
#         if master_array[i-1+ripetizione];
#             array_freq= master_array[i-1+ripetizione].collect {|ind| ind[0]}
#             getCount(ripetizione, freq, array_freq, master_array, i);
#         else
#             return ripetizione;
#         end
#     end
#     return ripetizione;
# end

def prepare_data(amp_to_play, array_to_play, freq_to_play, z, r );
    sigma=100; 
    n=1;
    adjustedAmp=Math.exp(-(1/amp_to_play[z-1])**(2*n)/(sigma**(2*n)));  
    sustain_count=r * 0.3;
    array_to_play.push([r, adjustedAmp, freq_to_play]);
    play freq_to_play[z-1], amp: adjustedAmp, sustain: sustain_count;
    sleep 0.3
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
            accordo.push([freq,amp]); # [[freq, amp], [freq, amp] ...]
      end
    end
    if accordo.length > 10;
        sorted_array=accordo.sort {|a, b| b[1] <=> a[1]} # [[79.6, 0.99], [60.8, 0.98 ], [90,0.97],[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
        cutted_array = sorted_array.first(10)
        array.push(cutted_array) # [[79.6, 0.9], [60.8, 0.8 ], [90,0.77]]
       # difference in order may alter the result
       # however, the notes will be played at the same time so
       # change in order won't matter
    else 
        if accordo.length > 0
            array.push(accordo);
        end # accordo: [[79.6, 0.8], [60.8, 0.9 ], [90,0.77]]
    end
end
  
puts "needs a break as this is high workload. Starting in 5 seconds"
  
sleep 5;

array_to_play=[];
if array.length >0 # [[[2,4],[3,4],...],[[1,2],[6,7],...,.]
    for i in 1555..array.length; # ciclo sul numero di accordi
      accordo = array[i-1];
        if accordo.length > 0;
            freq_to_play=accordo.collect {|ind| ind[0]};
            amp_to_play=accordo.collect {|ind| ind[1]};
            ripetizione=0
            for z in 0..freq_to_play.length do
                # gets count of how many times the note is repeated
                
                ripetizione=0
                for r in 0..array.length;
                    
                    # if freq to play is not included, go ahead with playing the music
                    if (array[i-1+r]) == nil;
                        prepare_data(amp_to_play, array_to_play, freq_to_play[z], z, r );
                    else
                        curent_chord=array[i-1+r].collect{|ind| ind[0]};
                        if !curent_chord.include?(freq_to_play[z]);
                            if previous_accordo_freq=array[i-2].collect {|ind| ind[0]};
                            prepare_data(amp_to_play, array_to_play, freq_to_play[z-1], z, r );
                        
                            # sees if the frequence was played before and if so, it ends the loop
                            # as the note is still playing

                            # amplitude gaussian filtering to adjust amp to play
                            # now 0 < amp < 1;
                            # degree of uniformity of notes played.
                            # The greater sigma is, the more uniform will be the amplitudes
                            # sigma=100; 
                            # n=1;
                            # adjustedAmp=Math.exp(-(1/amp_to_play[z-1])**(2*n)/(sigma**(2*n)));  

                            # sustain_count=r * 0.3;
                
                            # array_to_play.push(sustain_count, adjustedAmp, freq_to_play);
                            #  play freq_to_play[z-1], amp: adjustedAmp, sustain: sustain_count;
                            end
                        end
                    end 
                end 
            end
        end
    end
end

puts array_to_play.inspect