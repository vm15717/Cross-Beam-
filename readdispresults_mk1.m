%[Phi,Lam,Midx,diagKs,M]=Get_Modal_v2;
load('matrices2.mat');
Midx=N;
len1=1:1:Midx;
wlen1=~ismember(len1,diagKs);
finalmodaldispl=[];
finalmodalforce=[];
w1=Lam(1,1);
w2=Lam(2,2);
%tR=1e-1:1e-1:1e+0;
%C1=w1 * 0.1*0.65/abs(Phi(2,1));
%C2=w2 * 1e-9*0.65/abs(Phi(3,56));
af=linspace(-1,1,10);
forces=af;
excite=[1];
tR=(1e-1:1e-1:1e+0)*10;
for k=1%:length(tR)
    allmodaldispl=[];
    allmodalforce=[];
    for i=1:length(forces)
        filename = strcat('force','_',num2str(k),'_',num2str(i),'.csv');
        disp1 = csvread(filename,1,0);
        %disp1(1:3,:)=[];
        disp1=disp1.';
        disp1=disp1(:);
        disp1=disp1(wlen1);
        modaldispl=real(Phi\disp1);
        modalforce=zeros(length(modaldispl),1);
        modalforce(excite)=tR(k)*af(i);
        %modalforce(excite)=[tR(k)*forces(1,i);tR(k)*forces(2,i)];
        allmodaldispl=horzcat(allmodaldispl,modaldispl);
        allmodalforce=horzcat(allmodalforce,modalforce);
    end
    finalmodaldispl(:,:,k)=allmodaldispl;
    finalmodalforce(:,:,k)=allmodalforce;
end
thetaf3=[];
thetaf9=[];
for k=1%:length(tR)
    q1=finalmodaldispl(1,:,k);
    fq1=finalmodalforce(1,:,k);
    q2=finalmodaldispl(56,:,k);
    fq2=finalmodalforce(56,:,k);
    F1=fq1.';%-Lam(1)*q1.';
    q1=q1.';
    %F2=fq2.';%-Lam(56,56)*q2.';
    %q2=q2.';
    A=[q1 q1.^2 q1.^3 q1.^4 q1.^5 q1.^6 q1.^7 q1.^8 q1.^9];
    B=[q1 q1.^2 q1.^3];
    %B=[q2 q1.^2 q1.*q2 q2.^2 q1.^3 q1.^2.*q2 q1.*q2.^2 q2.^3];
    w=rms(A);
    Aw=bsxfun(@rdivide,A,w);
    bw=Aw\F1;
    theta11=bw./w';
    thetaf9=horzcat(thetaf9,theta11);
    %A=[q1.^2 q1.^3];
    w=rms(B);
    Bw=bsxfun(@rdivide,B,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf3=horzcat(thetaf3,theta11);
end