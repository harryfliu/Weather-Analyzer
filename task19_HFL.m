% Harry Liu

%Task 19 : Sorts given database and display the sorted results in the 
%form of a table. The user decides in the form of an input whether 
%in terms of avg yearly wind speed, solar radiation, or precipitation.
%Write the sorted table into a text file ("output_rank.txt").

%clear screen
clear;
clc;

%display problem
fprintf('Task 19\n\n');

%load weather.mat
load weather.mat;

%open the text file you want to write to
foo = fopen('output_rank_HFL.txt', 'w');

%loop variables
continue_var = 1;
select_var = 0;

while(continue_var==1)
    
    wind_dummy_vec = []; %empty arrays
    solar_dummy_vec = [];
    precip_dummy_vec = [];
    wind_dummy = mean(wind'); %avg of wind
    sort_wind = sort(wind_dummy,'descend');%sort by descending
    sort_wind_1 = sort(unique(sort_wind),'descend');%only include unique
    solar_dummy = mean(solar');%avg of solar
    sort_solar = sort(solar_dummy,'descend');
    sort_solar_1 = sort(unique(sort_solar),'descend');%unique solar
    precip_dummy = mean(precip');%avg of precip
    sort_precip = sort(precip_dummy,'descend');
    sort_precip_1 = sort(unique(sort_precip),'descend');%uniq precip
    
    select_var = input('Select the terms of sort by entering the corresponding number:\n- Average Yearly Wind Speed (1)\n- Solar Radiation (2)\n- Precipitation (3)\n\n');
    if(select_var==1)%sort by wind
        for i = [1:length(sort_wind_1)], %bounds
            sort_number = find(sort_wind_1(i)==wind_dummy); %index of wind
            wind_dummy_vec = cat(2,wind_dummy_vec,sort_number);%concat onto new vector
        end
        z = solar_dummy(wind_dummy_vec);%use indices to find solar
        for i = [1:length(z)],
            sort_number_1 = find(z(i)==sort_solar);%find idices of greatest to least solar
            solar_dummy_vec = cat(2,solar_dummy_vec,sort_number_1(1));%only include one at a time
            sort_solar(sort_number_1(1)) = 0;%set to 0 to disclude already scanned variables
        end
        y = precip_dummy(wind_dummy_vec); %same as above
        for i = [1:length(y)],
            sort_number_2 = find(y(i)==sort_precip);
            precip_dummy_vec = cat(2,precip_dummy_vec,sort_number_2(1));
            sort_precip(sort_number_2(1)) = 0;
        end
    end
    if(select_var==2)%sort by solar
        for i = [1:length(sort_solar_1)],
            sort_number = find(sort_solar_1(i)==solar_dummy);
            solar_dummy_vec = cat(2,solar_dummy_vec,sort_number);
        end
        z = wind_dummy(solar_dummy_vec);
        for i = [1:length(z)],
            sort_number_1 = find(z(i)==sort_wind);
            wind_dummy_vec = cat(2,wind_dummy_vec,sort_number_1(1));
            sort_wind(sort_number_1(1)) = 0;
        end
        y = precip_dummy(solar_dummy_vec);
        for i = [1:length(y)],
            sort_number_2 = find(y(i)==sort_precip);
            precip_dummy_vec = cat(2,precip_dummy_vec,sort_number_2(1));
            sort_precip(sort_number_2(1)) = 0;
        end
    end
    if(select_var==3)%sort by precip
        for i = [1:length(sort_precip_1)],
            sort_number = find(sort_precip_1(i)==precip_dummy);
            precip_dummy_vec = cat(2,precip_dummy_vec,sort_number);
        end
        z = wind_dummy(precip_dummy_vec);
        for i = [1:length(z)],
            sort_number_1 = find(z(i)==sort_wind);
            wind_dummy_vec = cat(2,wind_dummy_vec,sort_number_1(1));
            sort_wind(sort_number_1(1)) = 0;
        end
        y = solar_dummy(precip_dummy_vec);
        for i = [1:length(y)],
            sort_number_2 = find(y(i)==sort_solar);
            solar_dummy_vec = cat(2,solar_dummy_vec,sort_number_2(1));
            sort_solar(sort_number_2(1)) = 0;
        end
    end
  
    fprintf(foo,'-------------------------------------------------------------------------------\r\n');
    fprintf(foo,'|City          |    Solar Rank   |    Wind Rank     |    Precipitation Rank    |\r\n');
    fprintf(foo,'-------------------------------------------------------------------------------\r\n');
    if(select_var==1)%if wind print according to wind
        for i = [1:length(wind_dummy_vec)],
            fprintf(foo,'|%14s|     %12d|      %12d|      %20d|\r\n', strtrim(city(wind_dummy_vec(i),:)), solar_dummy_vec(i), i, precip_dummy_vec(i));
            fprintf(foo,'-------------------------------------------------------------------------------\r\n');
        end
    end
    if(select_var==2)%according to solar
        for i = [1:length(solar_dummy_vec)],
            fprintf(foo,'|%14s|     %12d|      %12d|      %20d|\r\n', strtrim(city(solar_dummy_vec(i),:)), i, wind_dummy_vec(i), precip_dummy_vec(i));
            fprintf(foo,'-------------------------------------------------------------------------------\r\n');
        end
    end
    if(select_var==3)%according to precip
        for i = [1:length(precip_dummy_vec)],
            fprintf(foo,'|%14s|     %12d|      %12d|      %20d|\r\n', strtrim(city(precip_dummy_vec(i),:)), solar_dummy_vec(i), wind_dummy_vec(i), i);
            fprintf(foo,'-------------------------------------------------------------------------------\r\n');
        end
    end
    continue_var = input('Enter (0) to exit. Enter (1) to continue. : ');%if 0 exit, if 1 continue
end

fprintf('Written to "output_rank_HFL.txt"\n\n'); %confirmation of file written

fclose(foo);%close the file
