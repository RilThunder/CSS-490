load iris;

% Get all the data into a variable after loading the iris data set
X = vertcat(setosa(:,:), versicolor(:,:),virginica(:,:));
% Generate possible combination
% 1 2, 1 3, 1 4, 2 3, 2 4 , 3 4
attributes = nchoosek(1:4,2);

% There are 6 possibles combinaion
for i = 1:6
    figure;
    tempData = X;
    % Get the index of the test observations
    indexToDrawSetosa = randsample(1:50,3);
    indexToDrawVersicolor = randsample(51:100,3);
    indexToDrawVirginica = randsample(101:150,3);
    % Get the list of index to exclude from the training set
    indexToExclude = horzcat(indexToDrawSetosa,indexToDrawVersicolor,indexToDrawVirginica);
    tempData(indexToExclude,:) = [];
    
    
    
    % This is the training set
    x_sepal = horzcat(tempData(:,attributes(i,1)),tempData(:,attributes(i,2)));
    % Getting the tag
    % 1 is setosa, 2 is versicolor, 3 is virginica
    species = ones(150,1);
    species(1:50,1) = 1;
    species(51:100,1) = 2;
    species(101:150) = 3;
    % Get the tag and exclude the test observations
    species(indexToExclude,:) = [];
    
    % Plot all the flowers by their attributes and group them together 
    % This only consists of 141 observations since 9 were excluded 
    gscatter(x_sepal(:,1), x_sepal(:,2), species); 

    legend('Location','best');
    
    % Get the original data to get the test observations
    tempData = X;
    % Only get the test observations and their corresponding features
    new_observation = tempData(indexToExclude,[attributes(i,1) attributes(i,2)]); 
    tag = ones(150,1);
    tag(1:50,1) = 1;
    tag(51:100,1) = 2;
    tag(101:150) = 3;
    % Get the tag of the test observation
    tag = tag(indexToExclude,1);
    
   
 
    
    
    % Plot each test observation. Circle them
    for j = 1:length(new_observation)
        % Use KNN to find 10 neighbors
        % Note that we only use 1 test observations at a time
        [n, d] = knnsearch(x_sepal, new_observation(j,:), 'k', 10, 'distance', 'euclidean');
        % Mark the test observation
        line(new_observation(j,1),new_observation(j,2),'marker','*','color','k','markersize',9,'linewidth',2);
        % Mark the surrounding training observations
        line(x_sepal(n,1), x_sepal(n,2),'color',[.5 .5 .5],'marker','o','linestyle','none','markersize',10); 

        
        x_sepal(n, :);
        value = species(n); 
        

        % Percentage that they belong to this species ?

        result = tabulate(transpose(value))
        [m,i] = max(result(:,3));
        
        if (i == tag(j,1))
            disp('Correct Classification with the highest percentage')
        else
            disp('Incorrect Classification compared to the actual tag of the test observation')
            calculate = result(i,1);
            actual = tag(j,1);
            display = strcat('Calculated Result ', num2str(calculate),' While the actual result ', num2str(actual))
            
           
        end

        ctr = new_observation(j,:) - d(end); 

        diameter = 2*d(end); 

        % Draw a circle around the 10 nearest neighbors. 

        h = rectangle('position',[ctr,diameter,diameter],'curvature',[1 1]); 

        h.LineStyle = ':'; 

        hold off;
    end
end
