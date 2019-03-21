function forcecalc(Phi,Lam,Midx,diagKs,appforce,excite)
if length(excite)==1
    %% 
    f=zeros(length(Lam),1);
    f(excite)=appforce;
    realf=real(Phi.'\f);
    fbigfinal=zeros(Midx,1);
    len1=1:1:Midx;
    w1=~ismember(len1,diagKs);
    fbigfinal(w1)=realf;
    fbigfinalfinal=reshape(fbigfinal,[3 length(fbigfinal)/3]).';
    q1=(fbigfinalfinal==0);
    fbigfinalfinal(q1)=1e-36;
    %filepath=str('C:\Users\vm15717\OneDrive - University of Bristol\Documents\Downloads');
    %write_to_csv('myFile2.csv',fbigfinalfinal)
%     fbigfinalfinal(1:8,:)=[];
%     fbigfinalfinal(end-3:end,:)=[];
    fbigfinalpart1=fbigfinalfinal(1:3073,:);
    fbigfinalpart2=fbigfinalfinal(3074:end,:);
%     csvwrite('myFile1.csv',fbigfinalpart1);
%     csvwrite('myFile3.csv',fbigfinalpart2);
    csvwrite('myFile2.csv',fbigfinalfinal);
else
    f=zeros(length(Lam),1);
    for i=1:length(excite)
        f(excite(i))=appforce(i);
    end
    realf=real(Phi.'\f);
    fbigfinal=zeros(Midx,1);
    len1=1:1:Midx;
    w1=~ismember(len1,diagKs);
    fbigfinal(w1)=realf;
    fbigfinalfinal=reshape(fbigfinal,[3 length(fbigfinal)/3]).';
    q1=(fbigfinalfinal==0);
    fbigfinalfinal(q1)=1e-36;
    %filepath=str('C:\Users\vm15717\OneDrive - University of Bristol\Documents\Downloads');
    %write_to_csv('myFile2.csv',fbigfinalfinal)
    csvwrite('myFile2.csv',fbigfinalfinal);
end
end