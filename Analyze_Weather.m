% Harry Liu

%Task 0

%clear screen
clear;
clc;

%display problem
fprintf('Task 0\n\n');

%load .mat file
load weather.mat %database containing data

%display 
fprintf('"weather.mat" loaded.\n\n');

%Task 1 : How many unique states in database?

%display problem
fprintf('Task 1\n\n');

%count unique states
unique_states = length(unique(state, 'rows')); %no loop, using unique()

%display
fprintf('In total, %d unique states exist in the database.\n\n', unique_states);

%Task 2 : find and display city with longest name

%display problem
fprintf('Task 2\n\n');

%find longest city name
count = [];

%loop
for i = 1:length(city)-1,%length of city -1
    for k = 2:length(city),%length of city
        if(sum(city(i,:)~=' ')>sum(city(k,:)~=' '))%if sum of char without spaces is greater
            count(i) = (sum(city(i,:)~=' ')); %write to count vector
        end
    end
end

a = find(max(count)==count(:));%find the index of the max of count

%display
if(length(a)>1)
    for i = [1:length(a)-1],
        fprintf('%s, ',strtrim(city(a(i),:)));
    end
    fprintf('and %s has the longest name. It has %d characters.\n', strtrim(city(a(length(a)),:)), max(count));
else
    fprintf('%s has the longest name. It has %d characters.\n', strtrim(city(a(length(a),:))), max(count));
end
fprintf('\n');

%Task 3 : Which city experiences the most wind in July?

%display problem
fprintf('Task 3\n\n');

%find city with most wind
b = find(wind(:,7)==max(wind(:,7)));

%display
fprintf('%s experiences the most wind in July.\n\n', strtrim(city(b,:)));

%Task 4 : Which cities experience the most and least wind throughout
%12 months (avg yearly wind speed)

%display problem
fprintf('Task 4\n\n');

%find avg wind speeds
c = mean(wind'); %mean of yearly wind speeds
max_wind = find(c==max(c));%find the max and mins of the wind
min_wind = find(c==min(c));

%display
fprintf('%s experiences the most wind while %s experiences the least wind.\n\n', strtrim(city(max_wind,:)), strtrim(city(min_wind,:)));

%Task 5 : What percentage of cities has yearly avg wind speed greater 
%than 8 miles per hour?

%display problem
fprintf('Task 5\n\n');

%find percentage of cities
greater_8 = length(find(mean(wind')>8));
percentage_cities_wind = (greater_8/length(city))*100;

%display
fprintf('%d percent of cities have yearly wind speed greater than 8 mph.\n\n', round(percentage_cities_wind));

%Task 6 : Which city has highest percentage of months that have wind speed
%greater than 8 miles per hour? What is that percentage?

%display problem
fprintf('Task 6\n\n');

%find city
above_8 = zeros(length(city),1);%empty array of zeros
for i = 1:length(city),%length of city
    for k = 1:length(wind(1,:)),
        if(wind(i,k)>8)
            above_8(i) = 1 + above_8(i);%if above 8 then add 1
        end
    end
end

city_percent_higher_8 = find(max(above_8)==above_8);%find the max of above 8
percent_higher_8 = (max(above_8)/length(wind(1,:)))*100;%divide by length of wind and then find percentage

%display
for i = [1:length(city_percent_higher_8)],
    fprintf('%s has the highest percentage of months with wind speed greater\nthan 8 miles per hour. %d percent.\n\n', strtrim(city(city_percent_higher_8(i),:)), percent_higher_8);
end

%Task 7 : Which city experiences the greatest total amount of sunlight
%in a year? Which city experiences the greatest amount of sunlight
%in August? (account for land area)

%display problem
fprintf('Task 7\n\n');

%find greatest total amount of sunlight
city_sun = sum(solar'); %avg sunlight
tot_sun = (city_sun(:)./1000).*area(:); %convert to kilo then multiply by area
city_greatest_tot_sun = find(max(tot_sun)==tot_sun);%find index of greatest tot

tot_sun_august = (solar(:,8)./1000).*area(:);%convert to kilo
city_greatest_aug_sun = find(max(tot_sun_august)==tot_sun_august);%find index of greatest aug

%display
for i = [1:length(city_greatest_tot_sun)],
    fprintf('%s experiences the greatest amount of sunlight in a year.\n', strtrim(city(city_greatest_tot_sun(i),:)));
end
for i = [1:length(city_greatest_aug_sun)],
fprintf('%s has the most sunlight in August.\n', strtrim(city(city_greatest_aug_sun(i),:)));
end
fprintf('\n')

%Task 8 : 40% of land area in city is 100% efficient solar panels
%Which city can produce the most solar energy in July?

%display problem
fprintf('Task 8\n\n');

%find city with most solar energy in july
july_energy = (solar(:,7)./1000);%convert to kilo
efficient_area = area(:).*0.4;%find area efficient
july_greatest_solar = july_energy(:).*efficient_area(:);%find greatest july solar energy
july_greatest_solar_energy = find(max(july_greatest_solar)==july_greatest_solar);% find index of greatest july solar energy

%display
for i = [1:length(july_greatest_solar_energy)],
    fprintf('%s can potentially produce the most solar energy in July.\n\n', strtrim(city(july_greatest_solar_energy(i),:)));
end

%Task 9 : 40% of the land is 100% efficient solar panels. Each
%solar panel is 60 m^2 and produces 1kW. Which city has the greatest
%solar power available in January?

%display problem
fprintf('Task 9\n\n');

%calculate greatest solar power available in january
efficient_land_area = (0.4*(60/1000)).*area(:); %efficient land area
jan_solar = solar(:,1);%jan solar energy
jan_efficient = jan_solar(:).*efficient_land_area(:);%solar gained in january
city_jan_eff = find(max(jan_efficient)==jan_efficient);%max solar gained in january

%display
for i = [1:length(city_jan_eff)],
    fprintf('%s can have the greatest solar power available in January.\n\n', strtrim(city(city_jan_eff(i),:)));
end

%Task 10: Strong wind (wind>3) damages solar panels. List top three
%cities where solar panels are likely to be damaged. Assume cities
%with average yearly solar insulation > 4 and land > 300 k^2 have
%solar panels

%display problem
fprintf('Task 10\n\n');

%find cities with >4 kW and > 300 k^2
solar_panel_cities = find(mean(solar')>4); %mean of solar above 4
final_cities = find(area(solar_panel_cities)>300);%use mean and find area above 300
final_cities = solar_panel_cities(final_cities); %plug area into mean to find final cities

%find likeliness using cities
strong_wind = mean(wind(final_cities,:)'); %use final cities to find strong wind
desc_strong_wind = sort(strong_wind,'descend'); %sort by descending
city_1 = find(desc_strong_wind(1)==strong_wind); %find top 3 indices
city_1 = final_cities(city_1);
city_2 = find(desc_strong_wind(2)==strong_wind);
city_2 = final_cities(city_2);
city_3 = find(desc_strong_wind(3)==strong_wind);
city_3 = final_cities(city_3);
city_final = [];
city_final = cat(2,city_final,city_1,city_2,city_3);

%display
fprintf('The top three in order of likeliness to damage solar panels: ');
for i = [1:length(city_final)-1],
    fprintf('%s, ', strtrim(city(city_final(i),:)));
end
fprintf('and %s.\n\n', strtrim(city(city_final(length(city_final)),:)));

%Task 11 : 5% of land area of each city is covered with rainwater
%collection system, which city collects the most rain in February?
%August?

%display problem
fprintf('Task 11\n\n');

%calculate rainwater area
rain_area = .05.*area(:); %area of collection
feb_rain = precip(:,2).*rain_area(:); %rain * area of collection
most_feb_rain = find(max(feb_rain)==feb_rain); %find index of most feb
aug_rain = precip(:,8).*rain_area(:); %aug rain collection
most_aug_rain = find(max(aug_rain)==aug_rain); %find index of most aug rain

%display
fprintf('%s collects the most rain in February while %s collects the\nmost rain in August.\n\n', strtrim(city(most_feb_rain(1),:)), strtrim(city(most_aug_rain(1),:)));

%Task 12 : Monthly wind speed below 3 mph reduces amount collected by
%5%, 3-5 mph reduces by 10%, wind>5 reduces by 40%. Which city collects
%the most in a year?

%display problem
fprintf('Task 12\n\n');

%calculate rainwater area
rain_area = .05.*area(:);

%calculate rain collected without wind
rain_no_wind = bsxfun(@times,precip,rain_area); %use bsxfun to multiply all rain with rain area

%calculate wind speeds
a = find(wind<3); %find below 3
b = find(wind>3&wind<5); %between 3 and 5
c = find(wind>5);%above 3

%subtract percentage from rain_no_wind
rain_no_wind(a) = rain_no_wind(a)*.95; %-5%
rain_no_wind(b) = rain_no_wind(b)*.9;%-10%
rain_no_wind(c) = rain_no_wind(c)*.6;%-40%

%find total rain
tot_rain = sum(rain_no_wind'); %sum of rain without wind
most_rain_city = find(max(tot_rain)==tot_rain);%max of most rain

%display
for i = [1:length(most_rain_city)],
    fprintf('Account for loss due to strong wind, %s collects the most rainwater in a year.\n\n', strtrim(city(most_rain_city(i),:)));
end

%Task 13 : Cities with monthly precip over 3 in are likely to have 
%damage to solar panels. (solar>4 kW only) List the top 3

%display problem
fprintf('Task 13\n\n');

%find cities with >4 kW and > 300 k^2
solar_panel_cities = find(mean(solar')>4); %above 4kw
final_cities = find(area(solar_panel_cities)>300); %above 300 area
final_cities = solar_panel_cities(final_cities); %final final cities

%create new vector and use logical indexing
vector = sum(precip(final_cities,:)>3,2);%1 if above 3, 0 if not
%find max
max_val = find(max(vector)==vector);%find max of months above 3

%display
fprintf('In order to likeliness to have solar panels damaged due to rain: '); 
for i = 1:length(max_val)-1,
    fprintf('%s, ', strtrim(city(max_val(i),:)));
end
fprintf('and %s.\n\n', strtrim(city(max_val(length(max_val)),:)));

%Task 14 : wind turbine can produce avg of 5000 kW of energy each month
%if avg wind speed is > 3. each wind turbine is 10,000 m^2 and 7% of
%a city is covered. assume cities with avg yearly solar > 3kW have 100%
%efficiency in 40% of land area. cities with wind power > solar power
%should install wind turbines. How many cities should install wind
%turbines? Solar panels?

%display problem
fprintf('Task 14\n\n');

%wind turbines
wind_turbines = sum(wind>3,2);%wind turbine criteria

%find number of turbines
land_area_turbines = floor((0.07*area)/(10000/1000));%find kilo

%find energy with turbines
energy_turbines = land_area_turbines * 5000;%multiply by energy per turbine

%find total wind energy produced
tot_wind_energy = wind_turbines.*energy_turbines;%multiply criteria and energy produced

%solar panels
solar_panels = mean(solar')>3;%avg solar over 3

%calculate area
solar_area = 0.4*area;%area of solar affected

%find total wind energy produced
tot_sol_energy = solar_panels.*solar_area'.*mean(solar'); %multiply criteria, avg and energy

%compare energy
i = [1:length(tot_sol_energy)];
wind_number = tot_wind_energy(i)>tot_sol_energy(i)'; %the wind number is how many are greater than solar

%number of wind turbine and solar 
count_wind_turbine = length(find(max(wind_number)==wind_number)); %how many wind turbines
count_solar_panels = length(tot_wind_energy)-count_wind_turbine; %how many solar panels

%display
fprintf('%d cities should install wind turbines while %d cities should install solar panels.\n\n', count_wind_turbine, count_solar_panels);

%Task 15 : If 50% of households (3 people) in all cities start using solar
%panels, how much total power relief can be achieved in August? (40 panels,
%each with 200 watts)

%display problem
fprintf('Task 15\n\n');

%find number of households
num_households = ceil(population/3); %3 per household
half_num_households = ceil(0.5*num_households); %50% of households

%power relief
pwr_relief = 40*200*half_num_households;%40*200 per solar panel
pwr_relief = sum(pwr_relief)/1000000;%convert to megawatts

%display
fprintf('In total, all cities together achieve a power relief of %d mega watts in August.\n\n', round(pwr_relief));

%Task 16 : Plot solar and precipitation data for 12 months for Miami,
%Seattle and Boston. 
%plot solar using dashdot style lines, precipitation using dotted style lines
%plot data for miami - red, seattle - blue, boston - magenta
%use line width 2.5 for all

%display problem
fprintf('Task 16\n\n');

%get solar and precip data for each city
miami_solar = solar(10,:); %get data for cities
miami_precip = precip(10,:);
seattle_solar = solar(51, :);
seattle_precip = precip(51, :);
boston_solar = solar(20, :);
boston_precip = precip(20, :);

%create figure
figure(1);

%plot figure
plot(miami_solar,'-.r', 'LineWidth', 2.5); %plot vector, color, line style, line size
hold on;
plot(seattle_solar,'-.b', 'LineWidth', 2.5);
hold on;
plot(boston_solar,'-.m', 'LineWidth', 2.5);
hold on;
plot(miami_precip,':r', 'LineWidth', 2.5);
hold on;
plot(seattle_precip,':b', 'LineWidth', 2.5);
hold on;
plot(boston_precip,':m', 'LineWidth', 2.5);
title('Months passed vs solar and precipitation');
xlabel('Months passed');
ylabel('Avg Solar in kW and Precipitation in inches');

%display
fprintf('Figure plotted!\n\n');

%Task 17 : create a function called 'sum_square'

%display problem
fprintf('Task 17\n\n');

%display
fprintf('Function already created!\n\n');

%Task 18 : find correlation between two datasets, write code to find 
%top three cities whose correlation between solar and precip data
% is closest to -1.

%display problem
fprintf('Task 18\n\n');

%loop cities
corr = [];%empty array

for i = [1:length(city)],%length of city
    corr(i) = (sum_square_HFL(solar(i,:),precip(i,:)))/(sqrt(sum_square_HFL(solar(i,:),solar(i,:)).*sum_square_HFL(precip(i,:),precip(i,:))));%use formula
end

corr_diff = corr + 1;%add 1 (abs value of -1)
sort_corr = sort(corr_diff,'descend');%sort by greates to least, find closest to 0
city_corr_1 = find(sort_corr(1)==corr_diff);%find top 3
city_corr_2 = find(sort_corr(2)==corr_diff);
city_corr_3 = find(sort_corr(3)==corr_diff);

%display
fprintf('The top three cities whose solar and precip correlation\nare closest to -1 are %s, %s, and %s.\n\n', strtrim(city(city_corr_1(1),:)), strtrim(city(city_corr_2(1),:)), strtrim(city(city_corr_3(1),:)));


