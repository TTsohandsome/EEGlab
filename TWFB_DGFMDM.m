function [acc,left_num,right_num] = TWFB_DGFMDM(MIEEGData,label,Fs,LowFreq,UpFreq)
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

acc = [];
left_num = [];
right_num = [];

% Divide data into three dimensions based on Trigger
for h = 1:10
    % Divide frequency bands
    freq_bands = {[8,12],[8,20],[8,30],[12,20],[15,20],[15,30],[20,30],[8,15]};
    
    acc_temp = [];
    left_num_temp = [];
    right_num_temp = [];
    
    for n = 1:length(freq_bands)
        Freq = freq_bands{1,n};
        % Divide data into three dimensions based on Trigger
        for i = 1:length(trigger)
            R = MIEEGData(trigger(i)-800:trigger(i)-800+2799,channel)';
            NotchData = NotchFilter(R,Fs,50);  
            BandpassData = BandpassFilter(NotchData,Fs,Freq(1),Freq(2))'; 
            eeg(:,:,i) = BandpassData(801:2800,:);
        end
        
        
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
        
        % Discriminant geodesic filtering + MDM Classification - Binary case
        NumClass = 2;
        metric_mean = 'riemann';
        metric_dist = 'riemann';
        acct = diag(nan(NumClass,1));
        
        for i=1:NumClass
            for j=1+i:NumClass
                % Select the trials
                ixtrain = (Ytrain==i)|(Ytrain==j);
                ixtest = (trueYtest==i)|(trueYtest==j);
                % Classification
                Ytest = fgmdm(COVtest(:,:,ixtest),COVtrain(:,:,ixtrain),Ytrain(ixtrain),metric_mean,metric_dist);
                % Accuracy
                acct(i,j) = 100*mean(Ytest==trueYtest(ixtest));
            end
        end
        
        c = 0;
        L = 0;
        R = 0;
        for k = 1:length(label_test)
            if Ytest(k)==label_test(k)
                c = c + 1;
                if Ytest(k)==1
                    L = L + 1;
                end
                if Ytest(k)==2
                    R = R +1;
                end
            end
            left = length(find(label_test==1));
            right = length(find(label_test==2));
        end
      
        acc_temp = [acc_temp,c/length(label_test)*100];
        left_num_temp = [left_num_temp;left,L];
        right_num_temp = [right_num_temp;right,R];
    end
    
    [acc0_value, acc0_index] = max(acc_temp);
    acc = [acc,acc0_value];
    left_num = [left_num;left_num_temp(acc0_index,:)];
    right_num = [right_num;right_num_temp(acc0_index,:)];
end
end