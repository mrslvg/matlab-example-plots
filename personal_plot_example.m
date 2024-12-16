function h = personal_plot_example(x, y1, y2, x_label_latex, y_label_latex, y1_legend_latex, y2_legend_latex, legend_position, pdf_name)
%This function receives as input the x array (in general time array) and two signals y1 y2 array, the x label and y label as strings in \LaTeX, the name of y1 and y2 as strings for the legend in \LaTeX, the legend location ('north', 'south', ...) and the name as string of the pdf to be exported (remember to write the extension .pdf).
%Default settings
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
lw = 2;

%Figure generation
h = figure('Renderer', 'painters', 'Position', [10 10 900 350]);

%Plot
plot(x, y1, 'k-', 'Linewidth', lw ,'Color', [0.2, 0.2, 0.2]);
hold on
plot(x, y2, 'k--', 'Linewidth', lw ,'Color', [0.5, 0.5, 0.5]);

%Legend
legend(y1_legend_latex, y2_legend_latex);
legend('Location',legend_position,'Orientation','horizontal','AutoUpdate','off')

%Labels 
xlabel(x_label_latex)
ylabel(y_label_latex)
set(gca, 'FontSize',22);

%Grid
grid on
box on

%Options
set(gcf,'color','w');
set(h, 'MenuBar', 'none');
set(h, 'ToolBar', 'none');

%Limits
xlim([x(1) x(end)])
ylim_lb = min([y1,y2]);
ylim_ub = max([y1,y2]);
ylim([ylim_lb ylim_ub]);

%Fix inner position of the plot inside the figure
set(gca, 'InnerPosition', [0.1400 0.32 0.82 0.55])
annotation('rectangle',[0 0 1 1],'Color','w');

exportgraphics(h, pdf_name);

end