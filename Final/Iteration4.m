% To load the data set, click import the data on Matlab, choose the form of
% Numeric Array


% Ignore the last 2 columns that has the data of the old dataset
theDataSet = HRcommasep(:,1:10);

% Randomly shuffle the rows in the new data set

ctotal = theDataSet(randperm(size(theDataSet,1)),:);

% Mean of all attributes
means = mean(ctotal);    

% Standard deviation of all attributes. Also like above
stdv = std(ctotal); 

% X will be the normalized data
 X = ctotal;

 for i=1:9 

    for j=1:length(X) 

        X(j,i) = ( means(:,i) - ctotal(j,i))/stdv(:,i); 

    end 

 end 

 % Ignore the tag at the end
 [U S V] = svd(X(:,1:9),0); 
 
 Ur = U * S;

 Ur = horzcat(Ur, ctotal(:,10));
 
[values, order] = sort(Ur(:,10));
Ur = Ur(order,:);

meanOfFirstClass = mean(Ur(1:11428,1:9));
meanOfSecondClass = mean(Ur(11429:14999,1:9));

coVarOfFirstClass = cov(Ur(1:11428,1:9));
coVarOfSecondClass = cov(Ur(11429:14999,1:9));

nfeatures = 9;
S2 = S^2; 
weights2 = zeros(nfeatures,1); 
% Get the sum of all the diagonal value
sumS2 = sum(sum(S2)); 
weightsum2 = 0; 
for i=1:nfeatures 
    weights2(i) = S2(i,i)/sumS2; 
    weightsum2 = weightsum2 + weights2(i); 
    weight_c2(i) = weightsum2; 
end 


figure; 

plot(weights2,'x:b'); 
grid; 
title('Scree Plot'); 
xlabel('Index of Features')
ylabel('Value of the diagonal')

 

figure; 
plot(weight_c2,'x:r'); 
grid; 
title('Scree Plot Cummulative');
xlabel('Index of Features')
ylabel('Cumulative Value of the diagonal')


% Squaring the loading vector to generate the bar plot later on
for i=1:nfeatures 

    for j=1:nfeatures 

        Vsquare(i,j) = V(i,j)^2; 

        if V(i,j)<0 

            Vsquare(i,j) = Vsquare(i,j)*-1; 

        else  

            Vsquare(i,j) = Vsquare(i,j)*1; 

        end 

    end 

end

% Generate loading vectors of 9 class
for i =1:nfeatures

    figure;
    
    bar(Vsquare(:,i),0.5); 

    grid; 

    ymin = min(Vsquare(:,i)) + min(Vsquare(:,i))/10; 

    ymax = max(Vsquare(:,i)) + max(Vsquare(:,i))/10; 

    axis([0 nfeatures ymin ymax]); 

    xlabel('Feature index'); 

    ylabel('Importance of feature'); 

    [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 

    title(chart_title);    
end





 
sortedData = sortrows(theDataSet,10);

class1 = sortedData(1:11428,1:9);
class2 = sortedData(11429:14999,1:9);
 
UrClass1 = Ur(1:11428,1:9);
UrClass2 = Ur(11429:14999,1:9);

x = 1;
y = 3;
z = 4;

%3d scatter plot for the original space X.
figure; 
scatter3(class1(:,x), class1(:,y), class1(:,z), 'r'); 
hold on; 
scatter3(class2(:,x), class2(:,y), class2(:,z), 'g'); 
ylabel('Feature 2: Number of Projects');
xlabel('Feature 1: Satisfaction');
zlabel('Feature 3: Average Monthly Hours');
lgd = legend('Left', 'Stayed');
[chart_title, ERRMSG] = sprintf('3D Scatter Plot of Original Space'); 
title(chart_title);

x = 1;
y = 3;
z = 5;

%3d scatter plot for the new space Ur.
figure; 
scatter3(UrClass1(:,x), UrClass1(:,y), UrClass1(:,z), 'r'); 
hold on; 
scatter3(UrClass2(:,x), UrClass2(:,y), UrClass2(:,z), 'g'); 
ylabel('Principal Component 3');
xlabel('Principal Component 1');
zlabel('Principal Component 5');
lgd = legend('Left', 'Stayed');
[chart_title, ERRMSG] = sprintf('3D Scatter Plot of new (Ur) Space'); 
title(chart_title);

x = 1;
y = 2;
z = 3;

%3d scatter plot for the new space Ur.




figure; 
scatter3(UrClass1(:,x), UrClass1(:,y), UrClass1(:,z), 'r'); 
hold on; 
scatter3(UrClass2(:,x), UrClass2(:,y), UrClass2(:,z), 'g'); 
ylabel('Principal Component 2');
xlabel('Principal Component 1');
zlabel('Principal Component 3');
lgd = legend('Left', 'Stayed');
[chart_title, ERRMSG] = sprintf('3D Scatter Plot of new (Ur) Space'); 
title(chart_title);





% Calculate the performace of KNN using UR matrix after the
% removal of 2 low score 

KNNResult = zeros(10,3);

for iteration=1:10
    indexToDraw = randsample(1:14999,round(length(Ur)*0.3));
     testUr = Ur(indexToDraw,1:7);
    testUrTag = Ur(indexToDraw,10);
     tempUr = Ur(:,1:7);
     % Get rid of the testing example from Ur 
     tempUr(indexToDraw,:) = [];
     data = Ur;
     data(indexToDraw,:) = [];
    performance = 0;
     tempUrTag = data(:,10);
     % Only use 150 neighbors around
     k = 150;
     performance = 0;
     [n, d] = knnsearch(tempUr, testUr, 'k', k, 'distance', 'euclidean');
        value = tempUrTag(n); 
        % Loop through all test observations and check if correct
        % classification
     for i= 1: round(length(Ur)*0.3)
           result = tabulate(transpose(value(i,:)));
         [m,index] = max(result(:,3));
         if result(index,1) == testUrTag(i)
             performance = performance +1;
         end
       end
 
       performance = performance / (length(Ur) * 0.3);
       KNNResult(iteration,3) = performance ;
end











% Now is the KNN for the original data set, after removal of redundant
% feature









% % Get the new data set after get rid of last evaluation
% % Eleminating the second column which is the last evaluation
% 10 run 



for iteration=1:10
newCTotal = horzcat(ctotal(:,1), ctotal(:,3:10));
% 
% % Note that we still assume that we will only use 30%
indexToDraw = randsample(1:14999,round(length(newCTotal)*0.3));
newtestCTotal = newCTotal(indexToDraw,1:8);
newtestCTotalTag = newCTotal(indexToDraw,9);
newtempCTotal = newCTotal(:,1:8);
% Get rid of the testing example from newCTotal 
newtempCTotal(indexToDraw,:) = [];
data = newCTotal;
% Invalid all test rows in the origina 
data(indexToDraw,:) = [];

% Get the tag of the training data
newtempCTotalTag = data(:,9);
% Increment 5% each time
%   k = int16((15000 ) * ( numberOfK* 0.01*5));
 k = 150;
performanceOfMod = 0;
[n, d] = knnsearch(newtempCTotal, newtestCTotal, 'k', k, 'distance', 'euclidean');
value = newtempCTotalTag(n); 
for i= 1: round(length(Ur)*0.3)
        % Get the tag of corresponding neightbor and display frequency
        result = tabulate(transpose(value(i,:)));
        [m,index] = max(result(:,3));
        if result(index,1) == newtestCTotalTag(i)
            performanceOfMod = performanceOfMod +1;
        end
end
performanceOfMod = performanceOfMod / (length(Ur) * 0.3);
KNNResult(iteration,2) = performanceOfMod;

%      
%             
% % Original 
end

% xVal value is the performance for each run in 10 runs








for iteration = 1:10
newCTotal = ctotal;    
indexToDraw = randsample(1:14999,round(length(newCTotal)*0.3));
testCTotal = newCTotal(indexToDraw,1:9);
testCTotalTag = Ur(indexToDraw,10);
tempCTotal = newCTotal(:,1:9);
% Get rid of the testing example from the original data set 
tempCTotal(indexToDraw,:) = [];
data = newCTotal;
% Only remain the tag of the training observation
data(indexToDraw,:) = [];

tempCTotalTag = data(:,10);
k = 150;
OriginalPerformance = 0;
[n, d] = knnsearch(tempCTotal, testCTotal, 'k', k, 'distance', 'euclidean');
value = tempCTotalTag(n); 
for i= 1: round(length(Ur)*0.3)
      result = tabulate(transpose(value(i,:)));
       [m,index] = max(result(:,3));
       if result(index,1) == testCTotalTag(i)
           OriginalPerformance  = OriginalPerformance  +1;
       end
end
OriginalPerformance  = OriginalPerformance  / (length(ctotal) * 0.3);
KNNResult(iteration,1) = OriginalPerformance;
end

















% Toying section Basically, checking for differnet
% K and their performance




















bestIncrement = 0;
bestKToUse = 0;
bestPerFormance = 0;
count = 1;

for increment = 1:5
    for numberOfK = 1:10
         format long g;
     % Get rid of the last 2 components
      indexToDraw = randsample(1:14999,round(length(Ur)*0.3));
     testUr = Ur(indexToDraw,1:7);
    testUrTag = Ur(indexToDraw,10);
     tempUr = Ur(:,1:7);
     % Get rid of the testing example from Ur 
     tempUr(indexToDraw,:) = [];
     data = Ur;
     data(indexToDraw,:) = [];
    performance = 0;
     tempUrTag = data(:,10);
     % Increment 5% each time
     k = int16((15000 ) * ( numberOfK* 0.01*increment));
   
     performance = 0;
       
     [n, d] = knnsearch(tempUr, testUr, 'k', k, 'distance', 'euclidean');
        value = tempUrTag(n); 
     for i= 1: round(length(Ur)*0.3)
      
 
           result = tabulate(transpose(value(i,:)));
         [m,index] = max(result(:,3));
         if result(index,1) == testUrTag(i)
             performance = performance +1;
         end
       end
 
       performance = performance / (length(Ur) * 0.3);
       if performance > bestPerFormance
           bestPerFormance = performance;
           bestKToUse = k;
           bestIncrement = increment;
       end
                 
    listOfK(count) = k;
    listOfPerformance(count) = performance;
    count = count +1;
    end
    
     
end

scatter(listOfK,listOfPerformance);
title('Performance comparison between differnt K for KNN');
xlabel('K Value');
ylabel('Performance');

%Best K: 150



% End of Toying Section.
% Now is the Naive Bayes Section






% Naive Bayes Classifier
%This first one is for the transformed data space (Ur).
mdl = fitcnb(tempUr,tempUrTag);
label = predict(mdl, testUr);
Bayesperformance = 0;
for i = 1: length(Ur)*0.3
    if label(i) == testUrTag(i)
        Bayesperformance = Bayesperformance +1;
    end
end
%%We ended up with a classification rating of 85.0% after taking the average of 10 runs for classifying the transformed (Ur) dataset out of random sample of 4500.


%This one is for the original data space.
mdl = fitcnb(tempCTotal,tempCTotalTag);
label = predict(mdl, testCTotal);
Bayesperformance1 = 0;
for i = 1: length(Ur)*0.3
    if label(i) == testCTotalTag(i)
        Bayesperformance1 = Bayesperformance1 +1;
    end
end
%%We ended up with a classification rating of 59.4% after taking the average of 10 runs for classifying the original dataset out of random sample of 4500.

% This one is the original data space minus the "Last Evaluation" column
%which we discovered to be a redundant feature in the loading vectors
%during PCA analysis.
mdl = fitcnb(newtempCTotal,newtempCTotalTag);
label = predict(mdl, newtestCTotal);
Bayesperformance2 = 0;
for i = 1: length(Ur)*0.3
    if label(i) == newtestCTotalTag(i)
        Bayesperformance2 = Bayesperformance2 +1;
    end
end
%%We ended up with a classification rating of 78.0% after taking the average of 10 runs for classifying the original dataset minus the redundant data of “Last Evaluation” out of random sample of 4500.
