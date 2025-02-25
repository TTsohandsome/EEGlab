function fbcspfiltedeeg = FBCSPFilter(eeg,fbcspw,bands,fs,filterorder)

Filter = fbcspw;
m = size(fbcspw,1)/2;

fbcspfiltedeeg = [];
for i=1:size(fbcspw,3)
    udfilter=designfilt('bandpassiir','FilterOrder',filterorder, ...
    'HalfPowerFrequency1',bands(i,1),'HalfPowerFrequency2',bands(i,2), ...
    'SampleRate',fs);
    filtedeeg = zeros(size(eeg));
    for trial = 1:size(eeg,3)
        for ch = 1:size(eeg,2)
            filtedeeg(:,ch,trial)=filter(udfilter,eeg(:,ch,trial));
        end
    end

    features_train = zeros(size(filtedeeg,3), 2*m+1);
    %extracting the CSP features from each trial
    for t=1:size(filtedeeg,3)
        % projecting the data onto the CSP filters
        projectedTrial_train = Filter(:,:,i) * filtedeeg(:,:,t)';

        % generating the features as the log variance of the projected signals
        variances_train = var(projectedTrial_train,0,2);

        for f=1:length(variances_train)
            features_train(t,f) = log(variances_train(f));
            % features_train(t,f) = log(variances_train(f)/sum(variances_train));   %修改后对应公式
        end

    end
    cspfiltedeeg = features_train(:,1:2*m);
    fbcspfiltedeeg = cat(2,fbcspfiltedeeg,cspfiltedeeg);
end
end
