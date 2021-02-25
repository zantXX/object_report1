function Bovw = makeCoodbook_Bovm(DB_list)
    %全ての画像でCoodbookを作る
    Features=[];
    for i=1:size(DB_list,2)
      I=rgb2gray(imread(DB_list{i}));
      %一画像3000点
      p=createRandomPoints(I,3000);
      [f,~]=extractFeatures(I,p);
      Features=[Features; f];
    end
    %コードブックサイズは1000
    [idx, Codebook] = kmeans(Features, 1000);
    dt = datetime('now');
    DateString = datestr(dt,'MMddHHmmssFFF');
    file_name = strcat(DateString,'_Codebook.mat');
    save(file_name,'Codebook','DB_list');
    
    %全ての画像でBag of visual wordsを作る
    Bovw=zeros(size(DB_list,2),size(Codebook,1));
    for j=1:size(DB_list,2)
        %各画像で特徴点抽出
        I = rgb2gray(imread(DB_list{j}));
        p = createRandomPoints(I,3000);
        [features,p2] = extractFeatures(I,p);
        %特徴点ごとに類似ベクトルを探し、投票
        for i=1:size(p2,1)
            x = repmat(features(i,:),size(Codebook,1),1);
            y = sqrt(sum((Codebook-x).^2,2));
            [~, index] = min(y);
            Bovw(j,index)=Bovw(j,index)+1;
        end
        %正規化
        all = sum(Bovw(j,:));
        for i=1:size(Bovw,2)
            Bovw(j,i) = Bovw(j,i) / all;
        end
    end
    dt = datetime('now');
    DateString = datestr(dt,'MMddHHmmssFFF');
    file_name = strcat(DateString,'_Bovw.mat');
    save(file_name,'Bovw','DB_list');

end