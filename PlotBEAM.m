function PlotBEAM(MIEEGData,label,Fs,LowFreq,HighFreq)
    channel = 1:30;
    trigger = find(MIEEGData(:,33)==2);
    left_MI = zeros(2000,30);
    left_MI_cell = cell(20,1);
    right_MI = zeros(2000,30);
    right_MI_cell = cell(20,1);
    
    k1 = 1;
    k2 = 1;
    for i = 1:length(trigger)
        bp_data = BandpassFilter(MIEEGData(trigger(i)-800:trigger(i)-800+2799,channel)',Fs,LowFreq,HighFreq)';
        if label(i)==1
            left_MI = left_MI +  bp_data(801:2800,:);
            left_MI_cell{k1,1} = bp_data(801:2800,:);
            k1 = k1 + 1;
        else
            right_MI = right_MI +  bp_data(801:2800,:);
            right_MI_cell{k2,1} = bp_data(801:2800,:);
            k2 = k2 + 1;
        end
    end
    left_MI = left_MI/20;
    left_MI = left_MI';
    right_MI = right_MI/20;
    right_MI = right_MI';
    
    left_MI(18,:) = zeros(1,2000);
    right_MI(18,:) = zeros(1,2000);
    
    % 绘制地形图
    h = figure;
    set(h, 'position', [100 100 250 300]);
    minmax = [];
    minmax(1) = min([mean(left_MI,2);mean(right_MI,2)]);
    minmax(2) = max([mean(left_MI,2);mean(right_MI,2)]);
    
    Sub1 = subplot(2,1,1);    % mean(left_MI,2)*100
    topoplot(mean(left_MI,2)*100, 'ZhenTec-10-20-Cap32.locs','electrodes','on','style','both','shading','interp','conv','off');
    
    Position_Sub1 = get(Sub1, 'Position');  % 获取第一个子图的位置[x,y,width,height]
                                           % 四个值分别是用百分比表示的该子图的左下角的x、y的坐标、宽、高所占的比例
    Position_Sub1 = Position_Sub1 + [-0.2  0  0  0 ];     % 设定第一个子图向左移动                               
    set(Sub1, 'Position',Position_Sub1);    % 重置第一个子图的位置
    title('MI with Left Hand', 'FontSize', 12)
    
    
    Sub2 = subplot(2,1,2);
    topoplot(mean(right_MI,2)*100, 'ZhenTec-10-20-Cap32.locs','electrodes','on','style','both','shading','interp','conv','off');
    title('MI with Right Hand', 'FontSize', 12)
    
    Position_Sub2 = get(Sub2, 'Position');  % 获取第一个子图的位置[x,y,width,height]
                                           % 四个值分别是用百分比表示的该子图的左下角的x、y的坐标、宽、高所占的比例
    Position_Sub2 = Position_Sub2 + [-0.2  0  0  0 ];     % 设定第一个子图向左移动                               
    set(Sub2, 'Position',Position_Sub2);    % 重置第一个子图的位置
    
    colorbar('eastoutside');
    hBar = colorbar;
    hBar.Label.String = 'Power/Frequency(dB/Hz)';
    Position_Bar = get(hBar, 'Position');    % 获取colorbar位置[x,y,width,height],其中，x表示colorbar的左下角与figure左边界的距离占figure宽度的百分比；
                                            % y表示colorbar的左下角与figure下边界的距离占figure高度的百分比；width表示colorbar的宽度占figure宽度的百分比；
                                            % height表示colorbar的高度占figure高度的百分比。
    Position_Bar = Position_Bar + [0.25  0  0  0.5 ];     % 设定colorbar向右移动                                   
    set(hBar, 'Position',Position_Bar, 'FontSize', 12) % 重置colorbar的位置 
    end