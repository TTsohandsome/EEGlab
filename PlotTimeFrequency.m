function PlotTimeFrequency(data,label,Fs,LowFreq,HighFreq)

channel = [1:17, 19:30];
MIEEGData = data;
trigger = find(MIEEGData(:,33)==2);

left_MI = zeros(2000,29);
right_MI = zeros(2000,29);
for i = 1:length(trigger)
    bp_data = BandpassFilter(MIEEGData(trigger(i)-800:trigger(i)-800+2799,channel)',Fs,LowFreq,HighFreq)';
    if label(i)==1
        left_MI = left_MI +  bp_data(801:2800,:);
    else
        right_MI = right_MI +  bp_data(801:2800,:);
    end
end
left_MI = left_MI/20;
right_MI = right_MI/20;

% 绘图
h = figure;
set(h,'position',[300 300 550 300]);

% 连续小波变换时频图
wavename = 'cmor3-3';     % 小波名称
totalscal = 256;
Fc = centfrq(wavename); % 小波的中心频率
c = 2 * Fc * totalscal;
scals = c./(1:totalscal);
f = scal2frq(scals,wavename,1/Fs); % 将尺度转换为频率

% 绘制时频图
subplot(2,2,1)
data = left_MI(:,14);  % 左手
t = 0:1/Fs:length(data)/Fs;
coefs = cwt(data,scals,wavename); % 求连续小波系数
imagesc(t,f,abs(coefs));axis xy, colormap(jet)
set(gca,'YDir','normal')
% h=colorbar;
% h.Label.String = 'Power/Frequency(dB/Hz)';
xlabel('Time(s)', 'FontSize', 12);
ylabel('Frequency(Hz)', 'FontSize', 12);
axis([0 4 0 30]);
title('MI with Left hand(C3)', 'FontSize', 12);

subplot(2,2,2)
data =left_MI(:,15);
coefs = cwt(data,scals,wavename);      % 求连续小波系数
imagesc(t,f,abs(coefs));axis xy, colormap(jet)
set(gca,'YDir','normal')
% h=colorbar;
% h.Label.String = 'Power/Frequency(dB/Hz)';
xlabel('Time(s)', 'FontSize', 12);
ylabel('Frequency(Hz)', 'FontSize', 12);
axis([0 4 0 30]);
title('MI with Left hand(C4)', 'FontSize', 12);

subplot(2,2,3)
data = right_MI(:,14);
coefs=cwt(data,scals,wavename); % 求连续小波系数
imagesc(t,f,abs(coefs));axis xy, colormap(jet)
set(gca,'YDir','normal')
% h=colorbar;
% h.Label.String = 'Power/Frequency(dB/Hz)';
xlabel('Time(s)', 'FontSize', 12);
ylabel('Frequency(Hz)', 'FontSize', 12);
axis([0 4 0 30]);
title('MI with Right hand(C3)', 'FontSize', 12);

subplot(2,2,4)
data = right_MI(:,15);
coefs = cwt(data,scals,wavename); % 求连续小波系数
imagesc(t,f,abs(coefs));axis xy, colormap(jet)
set(gca,'YDir','normal')
xlabel('Time(s)', 'FontSize', 12);
ylabel('Frequency(Hz)', 'FontSize', 12);
axis([0 4 0 30]);
title('MI with Right hand(C4)', 'FontSize', 12);

% h=colorbar;
% h.Label.String = 'Power/Frequency(dB/Hz)';

% subplot(2,3,6)
% colorbar('eastoutside');
% hBar = colorbar;
% % hBar.Label.String = 'Power/Frequency(dB/Hz)';
% Position_Bar = get(hBar, 'Position');    % 获取colorbar位置[x,y,width,height],其中，x表示colorbar的左下角与figure左边界的距离占figure宽度的百分比；
%                                         % y表示colorbar的左下角与figure下边界的距离占figure高度的百分比；width表示colorbar的宽度占figure宽度的百分比；
%                                         % height表示colorbar的高度占figure高度的百分比。
% Position_Bar = Position_Bar + [0.12  0  0  0 ];     % 设定colorbar向右移动
% set(hBar, 'Position',Position_Bar); % 重置colorbar的位置
% get(hBar, 'Position');
colorbar('eastoutside');
hBar = colorbar;
% hBar.Label.String = 'Power/Frequency(dB/Hz)';
Position_Bar = get(hBar, 'Position');    % 获取colorbar位置[x,y,width,height],其中，x表示colorbar的左下角与figure左边界的距离占figure宽度的百分比；
% y表示colorbar的左下角与figure下边界的距离占figure高度的百分比；width表示colorbar的宽度占figure宽度的百分比；
% height表示colorbar的高度占figure高度的百分比。
Position_Bar = Position_Bar + [0.1  0  0  0.5 ];     % 设定colorbar向右移动
set(hBar, 'Position',Position_Bar, 'FontSize', 12) % 重置colorbar的位置
get(hBar, 'Position')
end