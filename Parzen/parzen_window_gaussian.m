function foo = parzen_window_gaussian()
load iris;

hs = [1 0.6 0.15]; % this parameter controls the window width h_n 
n = [1 10 100 1e4]; % total number of samples 
% Indicate which subplot to plot
count = 1;


% Combination of each n versus each hs
for indexOfN = 1:length(n)
	for indexOfHs = 1:length(hs)
        x = [-2:0.1:2]; % this is your vector of observations x 
        len_x = length(x);
        samples = random('normal',0,1,n(indexOfN),1);
        for i = 1: len_x       
                % Utilized matlab syntax to substrach each point in the
                % sample from a single x 
                u= (x(i) - samples)/hs(indexOfHs);
                phi = (1/sqrt(2*pi))*exp(-(u.^2)/2);
                
                Function = (1/hs(indexOfHs)) * phi;
                % No need to use symsum function. Just use sum should be
                % fine Since it act the same way
                parzen = (1/n(indexOfN)) *sum(Function);
                % Does not have the /n because parzen variable already did
                % that
                p_estimate(i) = parzen;
        end
        % Specify how many row, columns and which index to plot
        subplot(length(n),length(hs),count)
        count = count +1;
        plot(x,p_estimate)
      
        if(indexOfN == 1 && indexOfHs == 1)
            ylabel('n = 1');
            title('hs = 1');
        elseif(indexOfN == 2 && indexOfHs == 1)
            ylabel('n = 10');
        elseif(indexOfHs == 2 && indexOfN == 1)
            title('hs = 0.6');
        elseif(indexOfN == 3 && indexOfHs == 1)
            ylabel('n = 100');
        elseif(indexOfHs == 3 && indexOfN == 1)
            title('hs = 0.15');
        elseif(indexOfN == 4 && indexOfHs == 1)
            ylabel('n = 1e4');
        end

    end
end




% This part utilized the KNN. This is just 1 part of the lab. There is
% another .m file that also used this but with the combinations of
% different features



figure;
% Get all the data into a variable after loading the iris data set
X = vertcat(setosa(:,:), versicolor(:,:),virginica(:,:));

% Selecting the 3rd and 4th features
x_sepal = X(:,3:4);
% Getting the tag
% 1 is setosa, 2 is versicolor, 3 is virginica
species = ones(150,1);
species(1:50,1) = 1;
species(51:100,1) = 2;
species(101:150) = 3;

% Plot all the flowers by their attributes and group them together 
gscatter(x_sepal(:,1), x_sepal(:,2), species); 
title('Flowers by Attribute');
xlabel('Sepal Length mm');
ylabel('Sepal Width mm');
legend('Setosa','Versicolor','Virginica','Location','southeast');



% Plot new observation
new_observation = [5 1.45]; 


line(new_observation(1),new_observation(2),'marker','*','color','k','markersize',9,'linewidth',2);
   
% Use KNN to find 10 neighbors
[n, d] = knnsearch(x_sepal, new_observation, 'k', 10, 'distance', 'euclidean');
line(x_sepal(n,1), x_sepal(n,2),'color',[.5 .5 .5],'marker','o','linestyle','none','markersize',10); 

x_sepal(n, :);
species(n); 

% Percentage that they belong to this species ?

tabulate(species(n))


ctr = new_observation - d(end); 

diameter = 2*d(end); 

% Draw a circle around the 10 nearest neighbors. 

h = rectangle('position',[ctr,diameter,diameter],'curvature',[1 1]); 

h.LineStyle = ':'; 

hold off;


% Default value 
foo = 0









 
		


    