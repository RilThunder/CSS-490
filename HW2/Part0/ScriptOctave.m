file = load('iris.mat')

#Seperate the file to a matrix to seperate the flower
newFormat = struct2cell(file)

# Get the individual flower
Setosa = newFormat(1)
Versicolor = newFormat(2)
Virginica = newFormat(3)

# Get the Matrix Representation
Setosa =cell2mat(Setosa)
Versicolor = cell2mat(Versicolor)
Virginica = cell2mat(Virginica) 

# The index of the subplot 
index = {1,4,5,7,8,9}

# The index of the attributes in each sub plot
firstPart = {1,1,1,2,2,3}
secondPart={2,3,4,3,4,4}

# A counter variable to loop through all the matrix above and below
count = 1

# The axis label of each subplot
xAxisName = {'Sepal Width' , 'Sepal Width', 'Sepal Length','Sepal Width','Sepal Length', 'Petal Width'}
yAxisName = {'Sepal Length','Petal Width','Petal Width','Petal Length','Petal Length','Petal Length'}

for i = index
          # Specify which subplot to get
         subplot(3,3,cell2mat(i))
         
         # Get the index of the data we want to plot in this subplot
         firstIndex = cell2mat(firstPart(count))
         secondIndex = cell2mat(secondPart(count))      
         
         # Plot 3 scatter plot in a single figure
         scatter(Setosa(:,firstIndex),Setosa(:,secondIndex),'r')
        hold on 
         scatter(Versicolor(:,firstIndex),Versicolor(:,secondIndex),'g')
        hold on
         scatter(Virginica(:,firstIndex),Virginica(:,secondIndex),'b')
         
         # Create a legend
         names = {'Setosa','Versicolor','Virginica'}
         legend(names,'location','northeastoutside')
         
         # Label x and y axis and the title
         xlabel(xAxisName(count))
         ylabel(yAxisName(count))  
         title('Distribution of 3 types of flower based on their attributes' )
        
        
        # Prepare for next attribute
        count = count +1
        
endfor
