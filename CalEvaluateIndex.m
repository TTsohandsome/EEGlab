function [Kappa,Sensitivity,Precision] = CalEvaluateIndex(data)
Kappa = [];
Sensitivity = [];
Precision = [];
for i = 1:length(data)
    confusion_matrix = data{i,1};
    % Calculating Kappa Index through Confusion Matrix
    fenleizhengque_yangben = diag(confusion_matrix);%������ȷ���������ǶԽ����ϵ�ֵ������һ��������
    yangbenzongshu = sum(confusion_matrix(:));
    p0 = sum(fenleizhengque_yangben)/yangbenzongshu;
    a = sum(confusion_matrix,1);%��2������Ϊ1�ǰ�����ֵ����ͬһ�е���������,����������
    b = sum(confusion_matrix,2);%��2������Ϊ2�ǰ�����ֵ����ͬһ�е���������,����������
    pe = 0.5;%(a*b)/(yangbenzongshu*yangbenzongshu); %������������������һ����
    kappa = (p0-pe)/(1-pe);
    
    % �û��ߵĽ����ּ��㣿
    % TP��������ȷ����ĸ�����TN��������ȷ����ĸ���
    % FN�����ִ������ĸ�����FP�����ִ������ĸ���
    % ����������
    Sens = confusion_matrix(1,1)/(confusion_matrix(1,1) + confusion_matrix(2,1))*100;
    
    % ���㾫��
    Prec = confusion_matrix(1,1)/(confusion_matrix(1,1) + confusion_matrix(1,2))*100;
    
    % �������㷨����������
    Kappa = [Kappa;kappa];
    Sensitivity = [Sensitivity;Sens];
    Precision = [Precision;Prec];
end
end