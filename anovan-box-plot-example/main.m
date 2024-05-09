clear
clc
close all

%% plot params
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')

barwidth = 0.5;
capsize = 10;
fontsize = 15;

% g = fullfact([3 3 3]); % generate full factorial design table
% y = rand(27, 1);

%% Load data
load data.mat
mass = [0.2, 0.3, 0.4];
fri = [0.4, 0.7, 1];
dim = [0.06, 0.08, 0.1];

colors = colormap(lines(numel(mass)));

%% One-sample Kolmogorov-Smirnov test
% Robustness
x = (data.rob-mean(data.rob))/std(data.rob); 
figure; cdfplot(x);
hold on
x_values = linspace(min(x),max(x));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
h = kstest(x)

% Tracking
x = (data.tra-mean(data.tra))/std(data.tra); 
figure; cdfplot(x);
hold on
x_values = linspace(min(x),max(x));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
h = kstest(x)

% Smoothness
x = (data.smo-mean(data.smo))/std(data.smo); 
figure; cdfplot(x);
hold on
x_values = linspace(min(x),max(x));
plot(x_values,normcdf(x_values,0,1),'r-')
legend('Empirical CDF','Standard Normal CDF','Location','best')
h = kstest(x)

%% Anova 
% Robustness
[p, t, stats, terms] = anovan(data.rob, {data.mas, data.fri, data.dim}, ...
    'model','interaction', 'varnames',{'mas','fri','dim'})

figure
subplot(1,3,1)
labels = {'$m=0.2$', '$m=0.3$', '$m=0.4$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.rob(data.mas == mass(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(1,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)
ylabel('$\mathcal{R}$')

subplot(1,3,2)
labels = {'$\mu=0.4$', '$\mu=0.7$', '$\mu=1$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.rob(data.fri == fri(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(1,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)
ylabel('$\mathcal{R}$')

subplot(1,3,3)
labels = {'$d=0.06$', '$d=0.08$', '$d=0.1$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.rob(data.dim == dim(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(1,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)
ylabel('$\mathcal{R}$')

set(gcf,'Position',[10 10 1920/2 1080/4]); set(gcf,'color','w');
exportgraphics(gcf, 'robustness.pdf', 'ContentType', 'vector');

figure 
[h,ax,bigax] = interactionplot(data.rob,{data.fri, data.dim},'varnames',{'$\mu$','$d$'})

multcompare(stats, 'Dimension', [2 3], 'CType','bonferroni')
figure
[h,ax,bigax] = myinteractionplots(data.rob,{data.fri, data.dim},'varnames',{'$\mu$','$d$'})
set(gcf,'Position',[10 10 1920/2 1080/4]); set(gcf,'color','w');
set(gca, 'FontSize', fontsize)
subplot(1,2,1)
ylabel('$\mathcal{R}$')
subplot(1,2,2)
ylabel('$\mathcal{R}$')
exportgraphics(gcf, 'robustness_interaction.pdf', 'ContentType', 'vector');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%figure
%results = multcompare(stats, 'Dimension',[1,3]);
%[c, m, h, gnames] = multcompare(stats)
%multcompare(stats, 'Dimension', [2, 3])

% Tracking
[p, t, stats, terms] = anovan(data.tra, {data.mas, data.fri, data.dim}, ...
    'model','interaction', 'varnames',{'mas','fri','dim'})

figure
subplot(1,3,1)
labels = {'$m=0.2$', '$m=0.3$', '$m=0.4$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.tra(data.mas == mass(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(2,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)

ylabel('$\mathcal{T}$')

subplot(1,3,2)
labels = {'$\mu=0.4$', '$\mu=0.7$', '$\mu=1$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.tra(data.fri == fri(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(2,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)

ylabel('$\mathcal{T}$')

subplot(1,3,3)
labels = {'$d=0.06$', '$d=0.08$', '$d=0.1$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.tra(data.dim == dim(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(2,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)

ylabel('$\mathcal{T}$')

set(gcf,'Position',[10 10 1920/2 1080/4]); set(gcf,'color','w');
exportgraphics(gcf, 'tracking.pdf', 'ContentType', 'vector');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Smoothness
[p, t, stats, terms] = anovan(data.smo, {data.mas, data.fri, data.dim}, ...
    'model','interaction', 'varnames',{'mas','fri','dim'})

figure
subplot(1,3,1)
labels = {'$m=0.2$', '$m=0.3$', '$m=0.4$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.smo(data.mas == mass(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(3,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)

ylabel('$\mathcal{S}$')
ytickformat('%.2f')

subplot(1,3,2)
labels = {'$\mu=0.4$', '$\mu=0.7$', '$\mu=1$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.smo(data.fri == fri(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(3,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)

ylabel('$\mathcal{S}$')
ytickformat('%.2f')

subplot(1,3,3)
labels = {'$d=0.06$', '$d=0.08$', '$d=0.1$'};
X = categorical(labels);
j = 1;
for i = 1:3
    x = data.smo(data.dim == dim(i));
    Y(j) = mean(x);
    Ystd(j) = std(x);
    j = j + 1;
end
b = bar(X, Y, 'facecolor', 'flat', 'BarWidth', barwidth);
for k = 1 : size(colors,1)
    b.CData(k,:) = colors(3,:);
end
hold on
errorbar(X, Y, Ystd, 'LineStyle','none', ...
'CapSize', capsize, 'Color', 'black');
set(gca, 'xtick', X)
set(gca, 'xticklabels', labels)
set(gca, 'FontSize', fontsize)

ylabel('$\mathcal{S}$')
ytickformat('%.2f')

set(gcf,'Position',[10 10 1920/2 1080/4]); set(gcf,'color','w');
exportgraphics(gcf, 'smoothness.pdf', 'ContentType', 'vector');

figure 
[h,ax,bigax] = interactionplot(data.smo,{data.fri, data.dim},'varnames',{'$\mu$','$d$'})


multcompare(stats, 'Dimension', [2 3], 'CType','bonferroni')
figure
[h,ax,bigax] = myinteractionplots(data.smo,{data.fri, data.dim},'varnames',{'$\mu$','$d$'})
set(gcf,'Position',[10 10 1920/2 1080/4]); set(gcf,'color','w');
set(gca, 'FontSize', fontsize)
subplot(1,2,1)
ylabel('$\mathcal{S}$')
subplot(1,2,2)
ylabel('$\mathcal{S}$')
exportgraphics(gcf, 'smoothness_interaction.pdf', 'ContentType', 'vector');
