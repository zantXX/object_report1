function match_num = color_hist_match(val_posDB,val_negDB,posDB,negDB) 
    %回答と一致している数
    match_num = 0;
    
    %ポジティブ画像の評価
    for i =1:size(val_posDB,1)
        query = val_posDB(i,:);
        pos_sim=[];
        neg_sim=[];
        %最近傍分類法でリスト作り
        for j = 1:size(posDB,1)
            pos_sim = [pos_sim; sum(min(posDB(j,:),query))];
        end
        for j = 1:size(negDB,1)
            neg_sim = [neg_sim; sum(min(negDB(j,:),query))];
        end
        [sorted_pos,~]=sort(pos_sim,'descend');
        [sorted_neg,~]=sort(neg_sim,'descend');
        %ポジティブのほうが、距離が長ければ正解
        if sorted_pos(1) > sorted_neg(1)
            match_num = match_num +1;
        end
    end
    
    %ネガティブ画像の評価
    for i =1:size(val_negDB,1)
        query = val_negDB(i,:);
        pos_sim=[];
        neg_sim=[];
        %最近傍分類法でリスト作り
        for j = 1:size(posDB,1)
            pos_sim = [pos_sim; sum(min(posDB(j,:),query))];
        end
        for j = 1:size(negDB,1)
            neg_sim = [neg_sim; sum(min(negDB(j,:),query))];
        end
        [sorted_pos,~]=sort(pos_sim,'descend');
        [sorted_neg,~]=sort(neg_sim,'descend');
        %ネガティブのほうが、距離が長ければ正解
        if sorted_pos(1) < sorted_neg(1)
            match_num = match_num +1;
        end
    end
end

