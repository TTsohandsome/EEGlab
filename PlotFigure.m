
% 添加 EEGLAB 工具箱路径
addpath('D:\code\strokeEEG\code\eeglab');
eeglab; % 启动 EEGLAB
close; % 关闭 EEGLAB 图形界面

% 获取当前文件的路径
fullpath = mfilename('fullpath');
[path,name]=fileparts(fullpath);
Acc = [];
Left = [];
Right = [];
AllLeft = [];
AllRight = [];
% 循环读取文件夹
for i = 50:50 %这里可以改的注意（为了防止弹出太多东西这里就只能先读取两个文件夹）
    if i<10
        SubFolderFiles = [path,'\sourcedata\sub-0' num2str(i) '\'];
    else
        SubFolderFiles = [path,'\sourcedata\sub-' num2str(i) '\'];
    end
    MatFiles = dir(fullfile([SubFolderFiles '*.mat'])); % 读取文件夹内的mat格式的文件
    
    for j = 1:length(MatFiles)
        % 文件名
        FileName = MatFiles(j).name;
        
        % 根据文件名下载数据
        load([SubFolderFiles FileName]);  % 下载后的数据是一个结构体，data.EEG为脑电数据
        eeg0 = eeg.rawdata;   % 脑电数据
        label = eeg.label;   % 标签
        eeg0 = permute(eeg0,[1 3 2]);  
        data = [];
        for t = 1:size(eeg0,1)
            data = [data;squeeze(eeg0(t,:,:))];
        end
        
        % 绘图参数
        sampleRate = 500;  % 采样率
        lower = 8;   % 频带下界
        higher = 30;  % 频带上界
        butterOrder = 2;  %吧滤波阶数
        smoothPara = 200;   % 光滑系数

        % 确保 Figure_png 文件夹存在
        if ~exist('Figure_png', 'dir')
            mkdir('Figure_png');
        end

        % 确保 Figure_eps 文件夹存在
        if ~exist('Figure_eps', 'dir')
            mkdir('Figure_eps');
        end
        
        % 绘制ERP图
        PlotERP(data,label,lower,higher,sampleRate,butterOrder,smoothPara);
        saveas(gcf, ['Figure_png\ERP', num2str(i)], 'png')
        saveas(gcf, ['Figure_eps\ERP', num2str(i)], 'eps')
        
        % 绘制时频图
        PlotTimeFrequency(data,label,sampleRate,lower,higher);
        saveas(gcf, ['Figure_png\TF', num2str(i)], 'png');
        saveas(gcf, ['Figure_eps\TF', num2str(i)], 'eps');
        
        % 绘制脑地形图
        PlotBEAM(data,label,sampleRate,lower,higher);
        saveas(gcf, ['Figure_png\Topo', num2str(i)], 'png')
        saveas(gcf, ['Figure_eps\Topo', num2str(i)], 'eps')
    end
end