
clear space all 
load('iris.mat')

% Creating the column that represent the tag of each flower
firstColumn = ones(50,1);
% Concatenate the tag to the setosa
setosaAdded = horzcat(firstColumn, setosa);
% Concatenate the tag to other flowers
firstColumn(:,1) = 2;
versicolorAdded = horzcat(firstColumn, versicolor);
firstColumn(:,1) = 3;
virginicaAdded = horzcat(firstColumn,virginica);

% Now get the combned data that has 150 rows and 5 columns 
totalFlower = vertcat(setosaAdded,versicolorAdded,virginicaAdded);


% Shuffle the matrix
ctotal = totalFlower(randperm(size(totalFlower,1)),:);

% Means of all flower. Do not use it but just keep it around
means = mean(ctotal);    

% Standard deviation of all flowers. Also like above
stdv = std(ctotal); 

% X will be the normalized data
 X = ctotal;

 
% 

% Mean-center/scale each feature, X is NORMALIZED & MEAN CENTERED  dataset 

% Scale S by maximum value

% do not normalize the plot

for i=2:5 

    for j=1:150 

        X(j,i) = ( means(:,i) - ctotal(j,i))/stdv(:,i); 

    end 

end 


% Only take 4 columns that represent the data set

[U S V] = svd(X(:,2:5),0); 

            

% Get the matrix in the transformed space
Ur = U * S;

% Number of features to use 
f_to_use = 5;      

feature_vector = 1:f_to_use; 

% Mean of the new feature

% Var of the new feature

r = Ur; 


% Now concatenate the tag to the new transformed space 
Ur = horzcat(ctotal(:,1),Ur)

% Sort the rows by the tag. In the increasing order
% 1 is setosa, 2 is virginica, 3 is versicolor
[values, order] = sort(Ur(:,1));
Ur = Ur(order,:);

% Get the mean and covariance of each flower in the new 
meanOfFirstClass = mean(Ur(1:50,2:5))
meanOfSecondClass = mean(Ur(51:100,2:5))
meanOfThirdClass = mean(Ur(101:150,2:5))

coVarOfFirstClass = cov(Ur(1:50,2:5))
coVarOfSecondClass = cov(Ur(51:100,2:5))
coVarOfThirdClass = cov(Ur(101:150,2:5))


% 

% Obtain the necessary information for Scree Plots 

% Obtain S^2 (and can also use to normalize S)   

% 
% 

% Obtain the necessary information for Scree Plots 

% Obtain S^2 (and can also use to normalize S)   

% 
nfeatures = 4
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

 

%Plotting Scree Plots. The normal one and the cumulative Scree Plot

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

% Generate loading vectors of 4 class
for i =1:4

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

figure;
% Generate the matrix Scatter plot of the new transformed data set
xName = {'First Attribute' 'Second Attribute' 'Third Attribute' 'Fourth Attribute'} ;

gplotmatrix(Ur(:,2:5),Ur(:,2:5),Ur(:,1),'rgb','xo',3,'on','none',xName,xName);
h = findobj('Tag','legend');
xlabel('Value');
ylabel('Value');
set(h, 'String', {'Setosa', 'Versicolor', 'Virginica'});
title('Scatter plot of the new transformed space ','fontsize',16);








% Generate 3D Scatter plot for each class 
class1 = Ur(1:50,2:5);
class2 = Ur(51:100,2:5);
class3 = Ur(101:150,2:5);


figure; 
x = 1;
y= 2;
z = 3 ;
k =4
scatter3(class1(:,x), class1(:,y), class1(:,z), 'r.'); 
title('3D Scatter plot of the new Transformed Space')
xlabel('First Attribute')
ylabel('Second Attribute')
zlabel('Third Attribute')

hold on; 

scatter3(class2(:,x), class2(:,y), class2(:,z), 'b.'); 

scatter3(class3(:,x), class3(:,y), class3(:,z), 'g^');

legend('Setosa', 'Versicolor', 'Virginica');
hold off







% Generate 3D Scatter plot of the original dataset
figure;
scatter3(virginica(:,x),virginica(:,y),virginica(:,z),'g^');


hold on;
title('Original Dataset')
xlabel('Sepal Width')
ylabel('Sepal Length')
zlabel('Petal Width')
scatter3(setosa(:,1),setosa(:,2),setosa(:,3),'r.');
scatter3(versicolor(:,1),versicolor(:,2),versicolor(:,3),'b.');
legend('Virginica', 'Setosa', 'Versicolor');

% Scatter plot of using only U 
figure;
U = horzcat(ctotal(:,1),U);
[values, order] = sort(U(:,1));
U = U(order,:);
gplotmatrix(U(:,2:5),U(:,2:5),U(:,1),'rgb','xo',3,'on','none',xName,xName);
h = findobj('Tag','legend');
xlabel('Value');
ylabel('Value');
set(h, 'String', {'Setosa', 'Versicolor', 'Virginica'});
title('Scatter plot of the new transformed space that is only U','fontsize',16);

%3D Scatter Plot using only U 

class1 = U(1:50,2:5);
class2 = U(51:99,2:5);
class3 = U(100:150,2:5);
figure;
scatter3(class1(:,x), class1(:,y), class1(:,z), 'r.'); 
title('3D Scatter plot of the new Transformed Space of only using U')
xlabel('First Attribute')
ylabel('Second Attribute')
zlabel('Third Attribute')

hold on; 

scatter3(class2(:,x), class2(:,y), class2(:,z), 'b.'); 

scatter3(class3(:,x), class3(:,y), class3(:,z), 'g^');

legend('Setosa', 'Versicolor', 'Virginica');

hold off 

