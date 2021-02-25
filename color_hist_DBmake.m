function color_DB = color_hist_DBmake(DB_list)
    %カラーヒストグラムに関するデータベースを作成
    color_DB=[];
    for i=1:length(DB_list)
        X=imread(DB_list{i});
        %色変換
        RED=X(:,:,1); GREEN=X(:,:,2); BLUE=X(:,:,3);
        X64=floor(double(RED)/64) *4*4 + floor(double(GREEN)/64) *4 + floor(double(BLUE)/64);
        X64_vec=reshape(X64,1,numel(X64));
        h = histc(X64_vec,[0:63]);
        %正規化
        h = h / sum(h);
        color_DB=[color_DB; h];
    end
end