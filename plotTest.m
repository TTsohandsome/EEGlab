    loadedData = load('FeatureData1.mat');
    Acc = loadedData.data.Accuracy;

    % % 拆分数据
    % Acc1 = Acc(:, 1:25);
    % Acc2 = Acc(:, 26:50);

    % % 生成 X 轴标签
    % a1 = cell(1, 25);
    % a2 = cell(1, 25);
    % for i = 1:25
    %     a1{1, i} = num2str(i);
    %     a2{1, i} = num2str(i + 25);
    % end


    % p = bar(Acc1');
    % set(gca,'YLim', [0,100], 'XTickLabel',a1, 'FontSize', 10);
    % set(gca, 'Xtick', [1:25],'Ytick', [0:5:10], 'ygrid','on','GridLineStyle','-');
    % axis([0 51 0 100]);
    
    
    % legend(p(1),'FBCSP+SVM');
    % ah=axes('position',get(gca,'position'),'visible','off');
    % legend(ah,p(2),'TSLDA+DGFMDM','location','west');
    % ah=axes('position',get(gca,'position'),'visible','off');
    % legend(ah,p(3),'TWFB+DGFMDM','location','east');
    % ah=axes('position',get(gca,'position'),'visible','off');
    % legend(ah,p(4),'CSP+LDA','location','north');

    % figure;

    % p = bar(Acc2');
    % set(gca,'YLim', [0,100], 'XTickLabel',a, 'FontSize', 10);
    % set(gca, 'Xtick', [1:25],'Ytick', [0:5:100], 'ygrid','on','GridLineStyle','-');
    % axis([0 51 0 100]);
    
    
    % legend(p(1),'FBCSP+SVM');
    % ah=axes('position',get(gca,'position'),'visible','off');
    % legend(ah,p(2),'TSLDA+DGFMDM','location','west');
    % ah=axes('position',get(gca,'position'),'visible','off');
    % legend(ah,p(3),'TWFB+DGFMDM','location','east');
    % ah=axes('position',get(gca,'position'),'visible','off');
    % legend(ah,p(4),'CSP+LDA','location','north');

    % figure;


    a = cell(1,50);
    for i = 1:50
        a{1,i}=num2str(i);
    end

    p = bar(Acc');
    set(gca,'YLim', [0,100], 'XTickLabel',a, 'FontSize', 10);
    set(gca, 'Xtick', [1:50],'Ytick', [0:10:100], 'ygrid','on','GridLineStyle','-');
    axis([0 51 0 100]);
    
    
    legend(p(1),'FBCSP+SVM');
    ah=axes('position',get(gca,'position'),'visible','off');
    legend(ah,p(2),'TSLDA+DGFMDM','location','west');
    ah=axes('position',get(gca,'position'),'visible','off');
    legend(ah,p(3),'TWFB+DGFMDM','location','east');
    ah=axes('position',get(gca,'position'),'visible','off');
    legend(ah,p(4),'CSP+LDA','location','north');

    figure;