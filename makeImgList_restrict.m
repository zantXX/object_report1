function list =makeImgList_restrict(DIR_img,max_num)
    %画像の場所を示すリスト生成
    n=0;
    list={};
    W_pos=dir(DIR_img);
    for j=1:size(W_pos,1)
        if (strfind(W_pos(j).name,'.jpg'))
            fn=strcat(DIR_img,'\',W_pos(j).name);
            n=n+1;
            fprintf('[%d] %s\n',n,fn);
            list={list{:} fn};
            %出力制限
            if size(list,2) >= max_num
                break;
            end
        end
    end
end