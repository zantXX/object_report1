function report1__5_fold(pos_list,neg_list,pos_Bovw,neg_Bovw)

    %結果格納
    result1 = 0;
    result2 = 0;
    result3 = 0;
    
    cv = 5;
    idx=[1:size(pos_list,2)];
    for i=1:cv
        %5-fold
        train_pos=pos_list(:,find(mod(idx,cv)~=(i-1)));
        eval_pos =pos_list(:,find(mod(idx,cv)==(i-1)));
        train_neg=neg_list(:,find(mod(idx,cv)~=(i-1)));
        eval_neg =neg_list(:,find(mod(idx,cv)==(i-1)));
        
        train_pos_Bovm=pos_Bovw(find(mod(idx,cv)~=(i-1)),:);
        eval_pos_Bovm =pos_Bovw(find(mod(idx,cv)==(i-1)),:);
        train_neg_Bovm=neg_Bovw(find(mod(idx,cv)~=(i-1)),:);
        eval_neg_Bovm =neg_Bovw(find(mod(idx,cv)==(i-1)),:);
        
        %1-カラーヒストグラムと最近傍分類
        posDB = color_hist_DBmake(train_pos);
        negDB = color_hist_DBmake(train_neg);
        val_posDB = color_hist_DBmake(eval_pos);
        val_negDB = color_hist_DBmake(eval_neg);
        result1 = result1 + color_hist_match(val_posDB,val_negDB,posDB,negDB);
        
        %2-BoFと非線形SVMによる分類
        result2 = result2 + SVM_rbf(eval_pos_Bovm,eval_neg_Bovm,train_pos_Bovm,train_neg_Bovm);
        
        %3-AlexNetと線形SVMによる分類
        result3 = result3 + DCNN_linearSVM(eval_pos,eval_neg,train_pos,train_neg);

    end
    fprintf('colorhist+NN: %f\n',result1/(size(pos_list,2)+size(neg_list,2)))
    fprintf('BoF+rbfSVM: %f\n',result2/(size(pos_list,2)+size(neg_list,2)))
    fprintf('Alex+linearSVM: %f\n',result3/(size(pos_list,2)+size(neg_list,2)))
	
end