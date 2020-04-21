require 'csv'
local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
amp_table=CSV.parse(File.read(local_dir + "ex5.csv"), headers: false)
freq_table=CSV.parse(File.read(local_dir + "freq5.csv"), headers: false)

# filter value to cutoff frequences.
filter = 0.009;
puts "the script will cut off frequences with amplitude lower than #{filter}.";

sleep 1;

# get number of column in amp table
column_in_amp = amp_table.transpose[0].size - 1;
# gets number of frequences - we only have one row.
freq_array = freq_table[0];
number_of_freq = freq_array.size;

# def repeatedNote(freq, index)

#     return repetition
#  end


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
        if amp_table_array[n].to_f > filter;
            freq = freq_table[0][n].to_f;
            amp = amp_table_array[n].to_f;
            accordo.push([freq,amp]);
        end
    end
    if accordo.length > 0
        array.push(accordo);
    end
end

sleep 13;
puts "starting in 8 seconds"

sleep 8;

if array.length >0
    puts "arrives here"
    for i in 1500..array.length
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
                # if freq_to_play[z-1] != freq_to_play[z-2];
                # max amplitude
                max = 5;
                mid = filter + (max - filter) / 2;
                low = filter + (mid - filter) / 2;
                upper_mid = mid + (max - mid) / 2;
                # map between amplitude and sound to play
                # needed as sonic pi accepts only values between 0.01 and 1
                case amp_to_play[z-1]
                when upper_mid..max
                    adjustedAmp = 1
                when mid..upper_mid
                    adjustedAmp = 0.7
                when low..mid
                    adjustedAmp = 0.4
            when filter..low
              adjustedAmp = 0.1
            else
              adjustedAmp = amp_to_play[z-1]
            end
            
            # scrivere codice che evita che suonino piu di 10 note contemporaneamente.

            # quante volte viene ripetuta la frequenza
            # repeatedNote(freq_play[z], z);
            # guarda l'array successivo. se l'array include il valore interessato, incrementa una]
            # variabile chiamata repetition e esegui ancora la funzione per il valore successivo. Se non lo ottiene,
            # esci return.
            
            # salvare questo dato in una variablie called repetition
            # sustain = repetition * 3
            # creare una nuova variable, called sustain = 0.3 * repetition
            puts freq_to_play[z-1]
            # puts sustain;
            puts amp_to_play[z-1]
            puts adjustedAmp
            
            
            play freq_to_play[z-1], amp: adjustedAmp, release: 0.2;
          end
          sleep 0.35;
        end
      end
    end






# require 'csv'
# local_dir="/Users/matildealiffi/Coding/music_sonic_pi/modulation-instability-sonic-pi/"
# amp_table=CSV.parse(File.read(local_dir + "ex6.csv"), headers: false)
# freq_table=CSV.parse(File.read(local_dir + "freq6.csv"), headers: false)

# # number of column in amp table
# column_in_amp = amp_table.transpose[0].size - 1;
# # number of frequences - we only have one row.
# freq_array = freq_table[0];
# number_of_freq = freq_array.size;

# array = [];
# # every column_in_amp
# for c in 0..column_in_amp do
#     # get array with the amplitude data of the first accordo
#     amp_table_array = amp_table[c];
#     num_element_in_amp_array= amp_table_array.length;
#     # create a accordo array
#     accordo = [];
#     for n in 0..num_element_in_amp_array;
#       # puts amp_table_array[n].to_f.inspect;
#       if amp_table_array[n].to_f > 0.03;
#         freq = freq_table[0][n].to_f;
#         amp = amp_table_array[n].to_f;
#         accordo.push([freq,amp]);
#         puts accordo.inspect;
#       end
#     end
#     if accordo.length > 0
#       array.push(accordo);
#     end
#     puts accordo.inspect
#   end
  
#   sleep 10;
#   puts "starting in 5 seconds"
  
#   sleep 5;
  
#   if array.length >0
#     puts "arrives here"
#     for i in 0..array.length
#       accordo = array[i- 1];
#       freq_to_play=[];
#       amp_to_play=[];
#       if accordo.length > 0;
#         for y in 0..accordo.length
#           freq_p=accordo[y - 1][0];
#           amp_p=accordo[y - 1][1];
#           freq_to_play.push(freq_p);
#           amp_to_play.push(amp_p);
#         end
#         puts i;
#         for z in 1...freq_to_play.length do
#             play freq_to_play[z-1], amp: amp_to_play[z -1], release: 0.2;
#           end
#           sleep 0.15;
#         end
#       end
#     end