function foo = oldg(x,i )

% Load the text file and get the data for each flower 
file = load('iris.mat');


newFormat = struct2cell(file);

Setosa = newFormat(1);
Versicolor = newFormat(2);
Virginica = newFormat(3);


Setosa =cell2mat(Setosa);
Versicolor = cell2mat(Versicolor);
Virginica = cell2mat(Virginica) ;


% Get the covaraince matrix of all flowers combine 
totalFlower = vertcat(Setosa,Versicolor,Virginica);

% Compute the covarience matrix for this function. Assume the covarience
% matrix  represent all categories (150 observations)
covarianceMatrix = cov(totalFlower);

inverseCovariance = inv(covarianceMatrix);
% Default value
meanValue = 0;

% Depending on i, select the Mean
if  i == 1
    meanValue = transpose(mean(Setosa));
elseif i==2
    meanValue = transpose(mean(Versicolor));
elseif i==3
    meanValue = transpose(mean(Virginica));
end 

% The first part of the formula 
% This will create a 4x1 matrix
% This formula was created by working backward (More details in the
% document)
w = inverseCovariance * meanValue;

% Second part of the formula
distanceFromOrigin = (-1/2) * transpose(meanValue)*inverseCovariance*meanValue + log(1/3);

% The result
foo = transpose(w)*transpose(x)+ distanceFromOrigin;
end

