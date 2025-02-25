% 运行plotAccuracies.m之前，需要运行这个脚本，以添加Covariance toolbox的路径

% Installer for the Covariance toolbox

HOME = pwd;
disp(HOME);
disp(path);

if isunix
    paths = {
        [HOME,'/lib'],
        [HOME,'/lib/distance'],
        [HOME,'/lib/geodesic'],
        [HOME,'/lib/riemann'],
        [HOME,'/lib/visu'],
        [HOME,'/lib/estimation'],
        [HOME,'/lib/mean'],
        [HOME,'/lib/simulation'],
        [HOME,'/lib/jointdiag'],
        [HOME,'/lib/classification'],
        [HOME,'/lib/potato']
    };
else
    paths = {
        [HOME,'\lib'],
        [HOME,'\lib\distance'],
        [HOME,'\lib\geodesic'],
        [HOME,'\lib\riemann'],
        [HOME,'\lib\visu'],
        [HOME,'\lib\estimation'],
        [HOME,'\lib\mean'],
        [HOME,'\lib\simulation'],
        [HOME,'\lib\jointdiag'],
        [HOME,'\lib\classification'],
        [HOME,'\lib\potato']
    };
end    

% 添加路径并检查是否存在
for i = 1:length(paths)
    if exist(paths{i}, 'dir')
        addpath(paths{i});
        disp(['Added path: ', paths{i}]);
    else
        warning(['Path does not exist: ', paths{i}]);
    end
end

% 调试信息
disp('Paths added:');
disp(path);

disp('Covariance toolbox activated');