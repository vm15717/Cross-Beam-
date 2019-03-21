function [Phi,Lam,N,diagKs,M]=Get_Modal_v2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic
TorsionalFreq_MASS1=load('Torsion1_MASS1.mtx');
TorsionalFreq_STIF1=load('Torsion1_STIF1.mtx');
toc

%%%%%%%%%%%%%%%%%%%%

tic

N = max(TorsionalFreq_MASS1(:,1));
M = zeros(N);
K = zeros(N);

Midx = sub2ind([N,N],TorsionalFreq_MASS1(:,1),TorsionalFreq_MASS1(:,2));
Kidx = sub2ind([N,N],TorsionalFreq_STIF1(:,1),TorsionalFreq_STIF1(:,2));

M(Midx) = TorsionalFreq_MASS1(:,3);
K(Kidx) = TorsionalFreq_STIF1(:,3);
%Removing unnecessary nodes
% M(1:24,:)=[];
% M(:,1:24)=[];
% M(:,end-11:end)=[];
% M(end-11:end,:)=[];
% K(1:24,:)=[];
% K(:,1:24)=[];
% K(:,end-11:end)=[];
% K(end-11:end,:)=[];
% %
% N=N-36;
[idx,~] = find(K == 1e36);
diagKs=idx;
M(idx,:) = [];
M(:,idx) = [];
K(idx,:) = [];
K(:,idx) = [];

disp(max(K(:)))

[Phi,Lam] = eig(K,M);

Lam = diag(Lam);
[~,idx] = sort(abs(Lam));
Lam = diag(Lam(idx));
Phi = Phi(:,idx);

%Lam(1:10,1:10)
%Phi(1:10,1:10)

%max(max(abs( Phi.'*M*Phi - eye(size(M)) )))


%nonzeros(imag(Phi))

toc
