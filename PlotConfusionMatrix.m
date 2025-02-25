function PlotConfusionMatrix(data)
title1 = {'CSP+LDA','FBCSP+SVM','TSLDA+DGFMDM','TWFB+DGFMDM'};
for fig =1:4
    Sub1 = subplot(2,2,fig);    % ��ͼ����1��3������
    mat = data{fig,1};
    
    % ��ǩ
    label = {'Right Hand','Left Hand'};
    
    % ��������������ɫ
    maxcolor = [50,114,189]; % ���ֵ��ɫ
    mincolor = [217,83,25]; % ��Сֵ��ɫ
    
    % ����������
    m = length(mat);
    imagesc(1:m,1:m,mat)
    
    % ����ͼ��λ��
    Position_Sub1 = get(Sub1, 'Position');  % ��ȡ��һ����ͼ��λ��[x,y,width,height]
    if (fig == 1) ||  (fig == 3)
        Position_Sub1 = Position_Sub1 + [-0.084  0  0.15  0 ];     % �趨��һ����ͼ�����ƶ�
    else
        Position_Sub1 = Position_Sub1 + [-0.04  0  0.15  0 ];
    end
    set(Sub1, 'Position',Position_Sub1);    % ���õ�һ����ͼ��λ��
    
    % ���콥��ɫ
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
        set(cb,'tickdir','out')  % ����
        set(cb,'YTick',120:20:280); %ɫ��ֵ��Χ����ʾ���
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %����̶ȸ�ֵ
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
        set(cb,'tickdir','out')  % ����
        set(cb,'YTick',180:20:220); %ɫ��ֵ��Χ����ʾ���
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %����̶ȸ�ֵ
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
        set(cb,'tickdir','out')  % ����
        set(cb,'YTick',100:100:300); %ɫ��ֵ��Χ����ʾ���
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %����̶ȸ�ֵ
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
        set(cb,'tickdir','out')  % ����
        set(cb,'YTick',160:40:240); %ɫ��ֵ��Χ����ʾ���
        %         set(cb,'Yticklabel',bel);
        set(cb,'FontSize',15) %����̶ȸ�ֵ
    end
    
    
    % ɫ���������
    for i = 1:m
        for j = 1:m
            text(i,j,num2str(mat(j,i)),...
                'horizontalAlignment','center',...
                'verticalAlignment','middle',...
                'fontname','Times New Roman',...
                'fontsize',25);
        end
    end
    
    % ͼ��������ȿ�
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