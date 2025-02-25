% 获取当前工作目录
currentFolder = pwd;

% 搜索 ZhenTec-10-20-Cap32.locs 文件
search_result = dir(fullfile(currentFolder, '**', 'ZhenTec-10-20-Cap32.locs'));

% 显示搜索结果
if isempty(search_result)
    disp('ZhenTec-10-20-Cap32.locs 文件未找到');
else
    disp('ZhenTec-10-20-Cap32.locs 文件路径:');
    for i = 1:length(search_result)
        disp(fullfile(search_result(i).folder, search_result(i).name));
    end
end