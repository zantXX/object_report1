function result = SVM_rbf(val_posDB,val_negDB,posDB,negDB)
    %学習ラベル生成
    training_label=[ones(size(posDB,1),1); ones(size(negDB,1),1)*(-1)];
    train_Bovw = [posDB; negDB];
    %学習
    model = fitcsvm(train_Bovw, training_label,'KernelFunction','rbf', 'KernelScale','auto');
    
    %評価ラベル生成
    val_label=[ones(size(val_posDB,1),1); ones(size(val_negDB,1),1)*(-1)];
    val_Bovw = [val_posDB; val_negDB];
    %評価(出力)
    [plabel,~]=predict(model,val_Bovw);
    result = numel(find(val_label==plabel));
end