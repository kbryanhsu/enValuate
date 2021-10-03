function functest = EnergyLevelModel(sen, act, source, lightIn)

senser = append('C:\Users\Bryan\Downloads\2021 AFRL\lanthanide data\', sen, '3+.csv');
fileID = fopen(senser);
sense = textscan(fileID,'%s %d %d %d','Delimiter',',','EmptyValue',-Inf);

activer = append('C:\Users\Bryan\Downloads\2021 AFRL\lanthanide data\', act, '3+.csv');
fileID = fopen(activer);
active = textscan(fileID,'%s %d %d %d','Delimiter',',','EmptyValue',-Inf);

% sensitizer = input('What is your sensitizer? Enter proper elemental symbol: ', 's');
% senser = append('C:\Users\Bryan\Downloads\2021 AFRL\lanthanide data\', sensitizer, '3+.csv');
% 
% if isfile(senser)
%     fileID = fopen(senser);
%     sense = textscan(fileID,'%s %d %d %d','Delimiter',',','EmptyValue',-Inf);
%     fclose(fileID);
% else
%     disp('Element not found. Check your spelling(i.e. "Sm") and format?');
%     return;
% end
% 
% activator = input('What is your activator? Enter proper elemental symbol: ', 's');
% activer = append('C:\Users\Bryan\Downloads\2021 AFRL\lanthanide data\', activator, '3+.csv');
% 
% if isfile(activer)
%     fileID = fopen(activer);
%     active = textscan(fileID,'%s %d %d %d','Delimiter',',','EmptyValue',-Inf);
%     fclose(fileID);
% else
%     disp('Element not found. Check your spelling(i.e. "Sm") and format?');
%     return;
% end
    
%TODO: add option to select from data sources, or average them
% choice = input('What data source would you like to select from? 0 for sum average(recommended), 1 for Carnall, 2 for Freidzon: ', 's');
if source == 0
    columnChoice = 4;
elseif source == 1
    columnChoice = 2;
elseif source == 2
    columnChoice = 3;
end

%process the average for the two data sources
for n = 1:size(sense{1})
    if (sense{2}(n) ~= intmin && sense{3}(n) ~= intmin)
        sense{4}(n) = (sense{3}(n) + sense{2}(n))/2;
    elseif (sense{2}(n) == intmin && sense{3}(n) ~= intmin)
        sense{4}(n) = sense{3}(n);
    elseif (sense{2}(n) ~= intmin && sense{3}(n) == intmin)
        sense{4}(n) = sense{2}(n);
    end
end
for n = 1:size(active{1})
    if (active{2}(n) ~= intmin && active{3}(n) ~= intmin)
        active{4}(n) = (active{3}(n) + active{2}(n))/2;
    elseif (active{2}(n) == intmin && active{3}(n) ~= intmin)
        active{4}(n) = active{3}(n);
    elseif (active{2}(n) ~= intmin && active{3}(n) == intmin)
        active{4}(n) = active{2}(n);
    end
end


%our two cell arrays are now "sense" and "active"

%current structure is as follows:
%C{1} is the e-level column, "cells" of strings of text
%C{columnchoice} is the reciprocal wavelength, cm-1, in strings of integers

% convert cm-1 units into nm-equivalents.
for n = 1:size(sense{1})
    if sense{columnChoice}(n) ~= intmin
        dub = double(sense{columnChoice}(n));
        temp = double(1/dub);
        sense{columnChoice}(n) = temp * 10^(7);
    end
end

for n = 1:size(active{1})
    if active{columnChoice}(n) ~= intmin
        dub = double(active{columnChoice}(n));
        temp = double(1/dub);
        active{columnChoice}(n) = temp * 10^(7);
    end
end

% graph width determining variables
graphWidthInNm = 800;

% simple energy level matching
for n=1:size(sense{1})
    probabilityModifier = lightIn; %this should calculate how likely it is to
    %have multiple transitions to get to this one place
    if (sense{columnChoice}(n) >= 800 && sense{columnChoice}(n) <= 2500) %absorbing infrared light
        finalArray = zeros(graphWidthInNm, 2);
        for j = 1:size(active{1})
            if (distance(active{columnChoice}(j), sense{columnChoice}(n), 500, 0, 1) > 0.5)
                if (active{columnChoice}(j) > graphWidthInNm)
                    continue
                end
                %normpdf(single(active{columnChoice}(j)), single(sense{columnChoice}(n)), 20)
                finalArray(active{columnChoice}(j),1) = sqrt(distance(active{columnChoice}(j), sense{columnChoice}(n), 500, 0, 1)*probabilityModifier);
            elseif (distance(active{columnChoice}(j), sense{columnChoice}(n)*2, 500, 0, 1) > 0.5)
                probabilityModifier = sqrt(lightIn);
                if (active{columnChoice}(j) > graphWidthInNm)
                    continue
                end 
                %normpdf(single(active{columnChoice}(j)), single(sense{columnChoice}(n))*2, 20)
                finalArray(active{columnChoice}(j),1) = sqrt(distance(active{columnChoice}(j), sense{columnChoice}(n)*2, 500, 0, 1)*probabilityModifier);
            elseif (distance(active{columnChoice}(j), sense{columnChoice}(n)*3, 500, 0, 1) > 0.5)
                probabilityModifier = nthroot(lightIn, 3);
                if (active{columnChoice}(j) > graphWidthInNm)
                    continue
                end
                %normpdf(single(active{columnChoice}(j)), single(sense{columnChoice}(n))*3, 20)
                finalArray(active{columnChoice}(j),1) = sqrt(distance(active{columnChoice}(j), sense{columnChoice}(n)*3, 500, 0, 1)*probabilityModifier);
            else
                continue
            end
        end
%             x1 = 1:graphWidthInNm;
%             figure
%             bar(x1, finalArray, 10)
%             ylim([0 1.25])
%             xlabel('Wavelength in nm')
%             ylabel('Relative radiance')
%             title(append('Predicted emission wavelengths for ', int2str(sense{columnChoice}(n)), 'nm light'))
%               disp(int2str(sense{columnChoice}(n)))
%               enlev = int2str(sense{columnChoice}(n));
    end
end



if (sen == act)
    finalArray = zeros(graphWidthInNm);
end

if exist('finalArray')
    functest = finalArray;
else
    functest = zeros(graphWidthInNm);
end


% x1 = 1:graphWidthInNm;
% figure
% bar(x1, finalArray)
% ylim([0 1.5])
% xlabel('Wavelength in nm')
% ylabel('Relative radiance')
% title('Predicted emission wavelengths')

% lambda = 50;
% % x1 = 0:100;
% % y1 = poisspdf(x1,lambda);
% mu = lambda;
% sigma = sqrt(lambda);
% x2 = 300:0.1:100;
% y2 = normpdf(x2,mu,sigma);
% figure
% % bar(x1,y1,1)
% % hold on
% plot(x2,y2,'LineWidth',2)
% xlabel('Observation')
% ylabel('Probability')
% title('Poisson and Normal pdfs')
% legend('Poisson Distribution','Normal Distribution','location','northwest')
% hold off


%returns a ratio of a given number is within a maximum distance from a
%predefined center. plus and minus are available for adjustment whether
%we are interested in the number lying below it.
function dis = distance(testnumber, center, maxdis, plus, minus)
    if (testnumber - center < maxdis && testnumber >= center && plus == 1)
        dis = double(testnumber - center)/double(maxdis);
    elseif (center - testnumber < maxdis && testnumber <= center && minus == 1)
        dis = double(center - testnumber)/double(maxdis);
    else
        dis = 0.0;
    end
end

    function normality = normdis(testnumber, center, probMod, stdDev)
        
    end

%unused
% fileID = fopen('C:\Users\Bryan\Downloads\2021 AFRL\lanthanide data\Sm3+.csv');
% C = textscan(fileID,'%s %d','Delimiter',',','EmptyValue',-Inf);
% fclose(fileID);

end

        
    