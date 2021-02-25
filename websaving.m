function websaving(txtfile,OUTDIR)
    %webからのダウンロード
    fileID = fopen(txtfile);
    list=textscan(fileID,'%s');
    list = list{1};
    for i=1:size(list,1)
      fname=strcat(OUTDIR,'/',num2str(i,'%04d'),'.jpg')
      websave(fname,list{i});
    end
end