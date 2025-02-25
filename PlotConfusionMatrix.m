function PlotConfusionMatrix(data)
title1 = {'CSP+LDA','FBCSP+SVM','TSLDA+DGFMDM','TWFB+DGFMDM'};
for fig =1:4
    Sub1 = subplot(2,2,fig);    % 绘图，按1行3列排列
    mat = data{fig,1};
    
    % 标签
    label = {'Right Hand','Left Hand'};
    
    % 混淆矩阵主题颜色
    maxcolor = [50,114,189]; % 最大值颜色
    mincolor = [217,83,25]; % 最小值颜色
    
    % 绘制坐标轴
    m = length(mat);
    imagesc(1:m,1:m,mat)
    
    % 设置图的位置
    Position_Sub1 = get(Sub1, 'Position');  % 获取第一个子图的位置[x,y,width,height]
    if (fig == 1) ||  (fig == 3)
        Position_Sub1 = Position_Sub1 + [-0.084  0  0.15  0 ];     % 设定第一个子图向左移动
    else
        Position_Sub1 = Position_Sub1 + [-0.04  0  0.15  0 ];
    end
    set(Sub1, 'Position',Position_Sub1);    % 重置第一个子图的位置
    
    % 构造渐变色
    mymap = [linspace(mincolor(1)/255,maxcolor(1)/255,33)',linspace(mincolor(2)/255,maxcolor(2)/255,33)',linspace(mincolor(3)/255,maxcolor(3)/255,33)'];
    
    if (fig == 1)
        
        bel = cell(1,10);
        k = 120;
        for i = 1:10
            bel{1,i} = num2str(k);
            k = k + 40;
        end
        
        colormap(mymap)
        cb=colorbar;
        set(cb,'tickdir','out')  % 朝外
        set(cb,'YTick',120:20:280); %色标值范围及显示间隔
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %具体刻度赋值
    end
    if (fig == 2)
        bel = cell(1,5);
        k = 120;
        for i = 1:5
            bel{1,i} = num2str(k);
            k = k + 40;
        end
        
        colormap(mymap)
        cb=colorbar;
        set(cb,'tickdir','out')  % 朝外
        set(cb,'YTick',180:20:220); %色标值范围及显示间隔
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %具体刻度赋值
    end
    
     if (fig == 4)
        bel = cell(1,5);
        k = 120;
        for i = 1:5
            bel{1,i} = num2str(k);
            k = k + 40;
        end
        
        colormap(mymap)
        cb=colorbar;
        set(cb,'tickdir','out')  % 朝外
        set(cb,'YTick',100:100:300); %色标值范围及显示间隔
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %具体刻度赋值
    end
    
    if (fig == 3)
        bel = cell(1,5);
        k = 120;
        for i = 1:5
            bel{1,i} = num2str(k);
            k = k + 40;
        end
        
        colormap(mymap)
        cb=colorbar;
        set(cb,'tickdir','out')  % 朝外
        set(cb,'YTick',160:40:240); %色标值范围及显示间隔
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %具体刻度赋值
    end
    
    
    % 色块填充数字
    for i = 1:m
        for j = 1:m
            text(i,j,num2str(mat(j,i)),...
                'horizontalAlignment','center',...
                'verticalAlignment','middle',...
                'fontname','Times New Roman',...
                'fontsize',25);
        end
    end
    
    % 图像坐标轴等宽
    ax = gca;
    ax.FontName = 'Times New Roman';
    set(gca,'box','on','xlim',[0.5,m+0.5],'ylim',[0.5,m+0.5]);
    axis square
    
    set(gca, 'Xtick', [1:2],'Ytick', [1:2], 'ygrid','on','GridLineStyle','-');
    
    xlabel('Predict class','fontsize',20,'FontWeight','bold')
    set(gca,'Xticklabel',label,'FontSize',15);
    
    ylabel('Actual class','fontsize',20,'FontWeight','bold')
    set(gca,'Yticklabel',label,'FontSize',15,'YTickLabelRotation',90);
    title(title1{1,fig},'FontWeight','bold');
end

end