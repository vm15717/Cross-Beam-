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
for k=1:length(tR)
    allmodaldispl=[];
    allmodalforce=[];
    for i=1:length(forces)
        filename = strcat('force','_',num2str(k),'_',num2str(i),'.csv');
        disp1 = csvread(filename,1,0);
        disp1(1:5,:)=[];
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
thetaf4=[];
thetaf5=[];
thetaf6=[];
thetaf7=[];
thetaf8=[];
thetaf9=[];
for k=1:length(tR)
    q1=finalmodaldispl(1,:,k);
    fq1=finalmodalforce(1,:,k);
    q2=finalmodaldispl(2,:,k);
    fq2=finalmodalforce(2,:,k);
    F1=fq1.';%-Lam(1)*q1.';
    q1=q1.';
    %F2=fq2.';%-Lam(56,56)*q2.';
    %q2=q2.';
    A7=[q1 q1.^2 q1.^3 q1.^4 q1.^5 q1.^6 q1.^7 q1.^8 q1.^9];
    A1=[q1 q1.^2 q1.^3];
    A2=[q1 q1.^2 q1.^3 q1.^4];
    A3=[q1 q1.^2 q1.^3 q1.^4 q1.^5];
    A4=[q1 q1.^2 q1.^3 q1.^4 q1.^5 q1.^6];
    A5=[q1 q1.^2 q1.^3 q1.^4 q1.^5 q1.^6 q1.^7];
    A6=[q1 q1.^2 q1.^3 q1.^4 q1.^5 q1.^6 q1.^7 q1.^8];
    %B=[q2 q1.^2 q1.*q2 q2.^2 q1.^3 q1.^2.*q2 q1.*q2.^2 q2.^3];
    w=rms(A1);
    Bw=bsxfun(@rdivide,A1,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf3=horzcat(thetaf3,theta11);
    w=rms(A2);
    Bw=bsxfun(@rdivide,A2,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf4=horzcat(thetaf4,theta11);
    w=rms(A3);
    Bw=bsxfun(@rdivide,A3,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf5=horzcat(thetaf5,theta11);
    w=rms(A4);
    Bw=bsxfun(@rdivide,A4,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf6=horzcat(thetaf6,theta11);
    w=rms(A5);
    Bw=bsxfun(@rdivide,A5,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf7=horzcat(thetaf7,theta11);
    w=rms(A6);
    Bw=bsxfun(@rdivide,A6,w);
    bw=Bw\F1;
    theta11=bw./w';
    thetaf8=horzcat(thetaf8,theta11);
    w=rms(A7);
    Aw=bsxfun(@rdivide,A7,w);
    bw=Aw\F1;
    theta11=bw./w';
    thetaf9=horzcat(thetaf9,theta11);
    %A=[q1.^2 q1.^3];
end