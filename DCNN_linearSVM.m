function result = DCNN_linearSVM(val_posDB,val_negDB,posDB,negDB)
    train_imgs = [];
    val_imgs = [];
    net = alexnet;
    %学習画像読み込み
    for j=1:size(posDB,2)
        img = imread(posDB{j});
        reimg = imresize(img,net.Layers(1).InputSize(1:2));
        train_imgs=cat(4,train_imgs,reimg);
    end
    for j=1:size(negDB,2)
        img = imread(negDB{j});
        reimg = imresize(img,net.Layers(1).InputSize(1:2));
        train_imgs=cat(4,train_imgs,reimg);
    end
    
    %評価画像読み込み
    for j=1:size(val_posDB,2)
        img = imread(val_posDB{j});
        reimg = imresize(img,net.Layers(1).InputSize(1:2));
        val_imgs=cat(4,val_imgs,reimg);
    end
    for j=1:size(val_negDB,2)
        img = imread(val_negDB{j});
        reimg = imresize(img,net.Layers(1).InputSize(1:2));
        val_imgs=cat(4,val_imgs,reimg);
    end
    
    %ラベル作成
    training_label=[ones(size(posDB,2),1); ones(size(negDB,2),1)*(-1)];
    val_label=[ones(size(val_posDB,2),1); ones(size(val_negDB,2),1)*(-1)];
    
    %DNN準備
    train_dcnnf = activations(net,train_imgs,'fc7');  
    train_dcnnf = squeeze(train_dcnnf);
    train_dcnnf = train_dcnnf/norm(train_dcnnf);
    train_dcnnf =train_dcnnf';
    
    val_dcnnf = activations(net,val_imgs,'fc7');  
    val_dcnnf = squeeze(val_dcnnf);
    val_dcnnf = val_dcnnf/norm(val_dcnnf);
    val_dcnnf =val_dcnnf';
    
    %SVM(linear)
    model = fitcsvm(train_dcnnf, training_label,'KernelFunction','linear','KernelScale','auto');
    [plabel,~]=predict(model,val_dcnnf);
    result = numel(find(val_label==plabel));
end