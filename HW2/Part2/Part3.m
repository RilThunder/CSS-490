% Creating the column that represent the tag of each flower
firstColumn = ones(50,1);
% Concatenate to the setosa
setosaAdded = horzcat(firstColumn, setosa);
% Change the match the other flower
firstColumn(:,1) = 2;
versicolorAdded = horzcat(firstColumn, versicolor);
firstColumn(:,1) = 3;
virginicaAdded = horzcat(firstColumn,virginica);

% Now get the combned data that has 150 rows and 5 columns 
totalFlower = vertcat(setosaAdded,versicolorAdded,virginicaAdded);

% Save the result of 3 trials
performance = transpose(zeros(3,1));
for loop = 1:3
    % Get 60 random index (without replacement) from 1 to 150
    % Note that this function is only available in the Statistics and Machine
    % Learning Toolbox
    indexToDraw = randsample(1:length(totalFlower),60);
    % Get a row vector
    output = transpose(zeros(60,1));

    for i=1:60
        % Result of running g three time
        result =  [0,0,0];
       for j= 1:3
           result(j) = g(totalFlower(indexToDraw(i),2:5),j) ;
       end 
       % Get the index of the column that has the greatest result
       [maxVal,index] = max(result);
       % Save it
       output(i) = index ;      
    end


    howManyCorrect = 0;

    for i=1:60
        % Compare the index of that result versus the actual class the flower
        % belong
        if (output(i) == totalFlower(indexToDraw(i),1))
            howManyCorrect = howManyCorrect +1;        
        end
    end
    % Save the result of each trial
    performance(loop) = howManyCorrect / 60;
	
end
performanceInThreeTrials = performance
averagePerformance = mean(performanceInThreeTrials)