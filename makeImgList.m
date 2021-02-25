function list =makeImgList(DIR_img)
    n=0;
    list={};
    W_pos=dir(DIR_img);
    for j=1:size(W_pos,1)
        if (strfind(W_pos(j).name,'.jpg'))
            fn=strcat(DIR_img,'\',W_pos(j).name);
            n=n+1;
            fprintf('[%d] %s\n',n,fn);
            list={list{:} fn};
        end
    end
end