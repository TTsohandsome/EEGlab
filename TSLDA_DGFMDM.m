function [acc,left_num,right_num] = TSLDA_DGFMDM(MIEEGData,label,Fs,LowFreq,UpFreq)
%  Input:
%  MIEEGData:The raw motor imagery data
%  label: motor imagery data label, 1 and 2
%  Fs: the sampling frequency (in Hz)
%  LowFreq: High pass filtering parameter settings
%  UpFreq:Low pass filtering parameter settings
%  Output:
%  acc:Accuracy Rate
%  left_num:
%  right_num:

% Obtaining effective channel EEG data
channel = [1:17 19:30];
NumChannel = length(channel);
trigger = find(MIEEGData(:,33)==2);
eeg = zeros(2000,29,40);

% Divide data into three dimensions based on Trigger
for i = 1:length(trigger)
    R = MIEEGData(trigger(i)-800:trigger(i)-800+2799,channel)';
    NotchData = NotchFilter(R,Fs,50);  
    BandpassData = BandpassFilter(NotchData,Fs,LowFreq,UpFreq)'; 
    eeg(:,:,i) = BandpassData(801:2800,:);
end

acc = [];
left_num = [];
right_num = [];

% Cross validation partitioning dataset
for h = 1:10
    % Partition Dataset
    num = 1:40;
    num = num(randperm(length(num)));   
    train_num = num(1:24);
    test_num = num(25:40);
    eeg_train = eeg(:,:,train_num);
    eeg_test = eeg(:,:,test_num);
    label_train = label(train_num);
    label_test = label(test_num);
    
    % Calculate the covariance matrix of the training set
    COVtrain = zeros(NumChannel,NumChannel,length(train_num));
    for i = 1:size(eeg_train,3)
        SS = squeeze(eeg_train(:,:,i));
        if ~isempty(SS)
            COVtrain(:,:,i) = SS'*SS;
        end
    end
    Ytrain = label_train;
    
    % Calculate the covariance matrix of the test set
    COVtest = zeros(NumChannel,NumChannel,length(test_num));
    for i = 1:size(eeg_test,3)
        SS = squeeze(eeg_test(:,:,i));
        if ~isempty(SS)
            COVtest(:,:,i) = SS'*SS;
        end
    end
    trueYtest = label_test;
    
    % classification method
    NumClass = 2;    % Number of categories
    
    % Method1£ºTangent Space LDA Classification - Binary case
    % the riemannian metric
    metric_mean = 'riemann';
    % update tangent space for the test data - necessary if test data corresponds to
    % another session. by default 0.
    update = 0;
    acc1 = diag(nan(NumClass,1));
    
    for i=1:NumClass
        for j=i+1:NumClass
            % Select the trials
            ixtrain = (Ytrain==i)|(Ytrain==j);
            ixtest = (trueYtest==i)|(trueYtest==j);
            % Classification
            Ytest1 = tslda(COVtest(:,:,ixtest),COVtrain(:,:,ixtrain),Ytrain(ixtrain),metric_mean,update);
            % Accuracy
            acc1(i,j) = 100*mean(Ytest1==trueYtest(ixtest));
        end
    end
    
    % Method2£ºDiscriminant geodesic filtering + MDM Classification - Binary case
    metric_mean = 'riemann';
    metric_dist = 'riemann';
    acc2 = diag(nan(NumClass,1));
    
    for i=1:NumClass
        for j=1+i:NumClass
            % Select the trials
            ixtrain = (Ytrain==i)|(Ytrain==j);
            ixtest = (trueYtest==i)|(trueYtest==j);
            % Classification
            Ytest2 = fgmdm(COVtest(:,:,ixtest),COVtrain(:,:,ixtrain),Ytrain(ixtrain),metric_mean,metric_dist);
            % Accuracy
            acc2(i,j) = 100*mean(Ytest2==trueYtest(ixtest));
        end
    end
    
    % Calculate accuracy
    if acc1(1,2)>acc2(1,2)
        test_label = Ytest1;
        acc0 = acc1(1,2);
    else
        test_label = Ytest2;
        acc0 = acc2(1,2);
    end
    acc = [acc,acc0];
    
    L = 0;
    R = 0;
    for k = 1:length(label_test)
        if test_label(k)==label_test(k)
            if test_label(k)==1
                L = L + 1;
            end
            if test_label(k)==2
                R = R +1;
            end
        end
        left = length(find(label_test==1));
        right = length(find(label_test==2));
    end
    left_num = [left_num;left,L];
    right_num = [right_num;right,R];
    
end
end