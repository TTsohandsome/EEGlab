function PlotAccBar(Acc)
data = Acc';
a = cell(1,50);
for i = 1:50
    a{1,i}=num2str(i);
end
p = bar(data);
set(gca,'YLim', [0,100], 'XTickLabel',a, 'FontSize', 10);
set(gca, 'Xtick', [1:50],'Ytick', [0:10:100], 'ygrid','on','GridLineStyle','-');
axis([0 51 0 100]);

legend(p(1),'FBCSP+SVM');
ah=axes('position',get(gca,'position'),'visible','off');
legend(ah,p(2),'TSLDA+DGFMDM','location','west');
ah=axes('position',get(gca,'position'),'visible','off');
legend(ah,p(3),'TWFB+DGFMDM','location','east');

end