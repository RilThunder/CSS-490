file = load('iris.mat');


newFormat = struct2cell(file);

Setosa = newFormat(1);
Versicolor = newFormat(2);
Virginica = newFormat(3);


Setosa =cell2mat(Setosa);
Versicolor = cell2mat(Versicolor);
Virginica = cell2mat(Virginica) ;
[SetosaMean,SetosaStd] = normfit(Setosa(:,1))
[VirginicaMean,VirginicaStd] = normfit(Virginica(:,1))
[VersicolorMean,VersicolorStd]= normfit(Versicolor(:,1))
SetosaVar = var(Setosa(:,1))
VirginicaVar = var(Virginica(:,1))
VersicolorVar = var(Versicolor(:,1))
figure()
hold on;
x= linspace(SetosaMean-3*SetosaStd,SetosaMean+3*SetosaStd,100);
plot(x,normpdf(x,SetosaMean,SetosaStd),'red');
x= linspace(VirginicaMean-3*VirginicaStd,VirginicaMean+3*VirginicaStd,100);
plot(x,normpdf(x,VirginicaMean,VirginicaStd),'green');
x= linspace(VersicolorMean-3*VersicolorStd,VersicolorMean+3*VersicolorStd,100);
plot(x,normpdf(x,VersicolorMean,VersicolorStd),'blue');
legend('Setosa','Virginica', 'Versicolor')
title('The PDF of 3 types of flower based on Petal Width')
xlabel('The length (cm)')
ylabel('Probability Density of the flower given the length')
hold off;

figure()
[SetosaMean,SetosaStd] = normfit(Setosa(:,2));
[VirginicaMean,VirginicaStd] = normfit(Virginica(:,2));
[VersicolorMean,VersicolorStd]= normfit(Versicolor(:,2));
hold on;
x= linspace(SetosaMean-3*SetosaStd,SetosaMean+3*SetosaStd,100);
plot(x,normpdf(x,SetosaMean,SetosaStd),'red');
x= linspace(VirginicaMean-3*VirginicaStd,VirginicaMean+3*VirginicaStd,100);
plot(x,normpdf(x,VirginicaMean,VirginicaStd),'green');
x= linspace(VersicolorMean-3*VersicolorStd,VersicolorMean+3*VersicolorStd,100);
plot(x,normpdf(x,VersicolorMean,VersicolorStd),'blue');
legend('Setosa','Virginica', 'Versicolor')
title('The PDF of 3 types of flower based on Petal Length')
xlabel('The length (cm)')
ylabel('Probability Density of the flower given the length')
hold off;
