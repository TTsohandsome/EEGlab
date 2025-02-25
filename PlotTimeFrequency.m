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

% ��ͼ
h = figure;
set(h,'position',[300 300 550 300]);

% ����С���任ʱƵͼ
wavename = 'cmor3-3';     % С������
totalscal = 256;
Fc = centfrq(wavename); % С��������Ƶ��
c = 2 * Fc * totalscal;
scals = c./(1:totalscal);
f = scal2frq(scals,wavename,1/Fs); % ���߶�ת��ΪƵ��

% ����ʱƵͼ
subplot(2,2,1)
data = left_MI(:,14);  % ����
t = 0:1/Fs:length(data)/Fs;
coefs = cwt(data,scals,wavename); % ������С��ϵ��
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
coefs = cwt(data,scals,wavename);      % ������С��ϵ��
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
coefs=cwt(data,scals,wavename); % ������С��ϵ��
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
coefs = cwt(data,scals,wavename); % ������С��ϵ��
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
% Position_Bar = get(hBar, 'Position');    % ��ȡcolorbarλ��[x,y,width,height],���У�x��ʾcolorbar�����½���figure��߽�ľ���ռfigure��ȵİٷֱȣ�
%                                         % y��ʾcolorbar�����½���figure�±߽�ľ���ռfigure�߶ȵİٷֱȣ�width��ʾcolorbar�Ŀ��ռfigure��ȵİٷֱȣ�
%                                         % height��ʾcolorbar�ĸ߶�ռfigure�߶ȵİٷֱȡ�
% Position_Bar = Position_Bar + [0.12  0  0  0 ];     % �趨colorbar�����ƶ�
% set(hBar, 'Position',Position_Bar); % ����colorbar��λ��
% get(hBar, 'Position');
colorbar('eastoutside');
hBar = colorbar;
% hBar.Label.String = 'Power/Frequency(dB/Hz)';
Position_Bar = get(hBar, 'Position');    % ��ȡcolorbarλ��[x,y,width,height],���У�x��ʾcolorbar�����½���figure��߽�ľ���ռfigure��ȵİٷֱȣ�
% y��ʾcolorbar�����½���figure�±߽�ľ���ռfigure�߶ȵİٷֱȣ�width��ʾcolorbar�Ŀ��ռfigure��ȵİٷֱȣ�
% height��ʾcolorbar�ĸ߶�ռfigure�߶ȵİٷֱȡ�
Position_Bar = Position_Bar + [0.1  0  0  0.5 ];     % �趨colorbar�����ƶ�
set(hBar, 'Position',Position_Bar, 'FontSize', 12) % ����colorbar��λ��
get(hBar, 'Position')
end