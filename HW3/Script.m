dataset = winebeerdataset(:,2:6);
means = mean(dataset)
stdv = std(dataset)
covarianceMatrix  = cov(dataset)
xName = {'Liquor Consumption' , 'Wine consumption' , 'Beer Consumption' 'Life Expectancy (years)', 'Heart Disea Rate'};
x = [0,1,2,3,4,5,6,7,8,9];
RGBtab = [0 0 1; 0 1 0; 0 0 0; 1 0 0; 1 1 0; 0 1 1; 1 0 1; 192/255 192/255 192/255; 0 0 128/255 ; 0 128/255 128/255] ;

gplotmatrix(dataset(:,:),dataset(:,:),x,RGBtab,{},18,'on','none',xName, xName );
h = findobj('Tag','legend');
set(h, 'String',{'France' ,'Italy', 'Switzerland' ,'Austrilia', 'Great Britain' ,'United States' ,'Russia' ,'Czech Rebpublic' ,'Japan', 'Mexico'});

title('Alcohol Consumption in various countrie');

transformed = dataset;

% Normalize the data
for i=1:5 

    for j=1:10 

        transformed(j,i) = ( means(:,i) - dataset(j,i))/stdv(:,i); 

    end 

end 

newStandard = std(transformed)
newMean = mean(transformed)
ratioOfStdAndMean = newStandard ./ newMean 

%Looking at the standard deviation equal to 1 => No useless feature
[U S V] = svd(transformed(:,:),0);
% Dataset in the new space

nfeatures = 5;

Ur = U * S;

S2 = S^2; 

weights2 = zeros(nfeatures,1); 

sumS2 = sum(sum(S2)); 

weightsum2 = 0; 

 

for i=1:nfeatures 

    weights2(i) = S2(i,i)/sumS2; 

    weightsum2 = weightsum2 + weights2(i); 

    weight_c2(i) = weightsum2; 

end 


%Plotting Scree Plots 

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
for i =1:5

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
newName = {'First Attribute' 'Second Attribute' 'Third Attribute' 'Fourth Attribute' 'Fifth Attribute'};
gplotmatrix(Ur(:,:),Ur(:,:),x,RGBtab,{},18,'on','none',newName, newName );
h = findobj('Tag','legend');
set(h, 'String',{'France' ,'Italy', 'Switzerland' ,'Austrilia', 'Great Britain' ,'United States' ,'Russia' ,'Czech Rebpublic' ,'Japan', 'Mexico'});

title('New transformed dataset');

