function [Kappa,Sensitivity,Precision] = CalEvaluateIndex(data)
Kappa = [];
Sensitivity = [];
Precision = [];
for i = 1:length(data)
    confusion_matrix = data{i,1};
    % Calculating Kappa Index through Confusion Matrix
    fenleizhengque_yangben = diag(confusion_matrix);%分类正确的样本就是对角线上的值，这是一个列向量
    yangbenzongshu = sum(confusion_matrix(:));
    p0 = sum(fenleizhengque_yangben)/yangbenzongshu;
    a = sum(confusion_matrix,1);%第2个参数为1是按列求值，把同一列的数加起来,这是行向量
    b = sum(confusion_matrix,2);%第2个参数为2是按行求值，把同一行的数加起来,这是列向量
    pe = 0.5;%(a*b)/(yangbenzongshu*yangbenzongshu); %行向量乘以列向量是一个数
    kappa = (p0-pe)/(1-pe);
    
    % 用患者的健侧手计算？
    % TP：左手正确分类的个数；TN：右手正确分类的个数
    % FN：左手错误分类的个数；FP：右手错误分类的个数
    % 计算灵敏度
    Sens = confusion_matrix(1,1)/(confusion_matrix(1,1) + confusion_matrix(2,1))*100;
    
    % 计算精度
    Prec = confusion_matrix(1,1)/(confusion_matrix(1,1) + confusion_matrix(1,2))*100;
    
    % 将所有算法的特征存下
    Kappa = [Kappa;kappa];
    Sensitivity = [Sensitivity;Sens];
    Precision = [Precision;Prec];
end
end