function [Z,Obj] = RFGEC(X, alpha, beta, d, k)
%C: number of classes
V = size(X,2);
N = size(X{1},2); % number of data points

for i=1:V
    X{i} = X{i}./repmat(sqrt(sum(X{i}.^2,1)),size(X{i},1),1);  %normalized
end

for i=1:V
    D{i} = size(X{i},1); % dimension of each view
end
SD = 0;
M = [];
for i=1:V
    SD = SD + D{i};
    M = [M;X{i}]; %X
end

B = zeros(SD,d);
Y = rand(d,N);
Z = zeros(N);
S = constructW_PKN(M,10,1);
Ds = diag(sum(S));
L = Ds - S;
nL = (full(Ds)^(-.5))*L*(full(Ds)^(-.5));

maxIters = 30;
for it=1:maxIters
    tM = (eye(N)-nL/2)^k*M';
    M = tM';
    
    %------update W--------
    B = UpdateB(Y,M,B);
    
    %------update H--------
    Y = updateY(M,B,Z,alpha);
    
    %------update Z--------
    Z = (Y'*Y+(beta/alpha)*eye(N))\(Y'*Y);
    Z = max(Z,eps);

    %------update S and L--------
    S = constructW_PKN(Z,10,1);
    Ds = diag(sum(S));
    L = Ds - S;
    nL = (full(Ds)^(-.5))*L*(full(Ds)^(-.5));
    
    %------print OBJ-------
    Obj(it) = norm((M-B*Y),'fro')^2+alpha*norm((Y-Y*Z),'fro')^2+beta*norm(Z,'fro')^2;
    if (it>1 && (abs(Obj(it)-Obj(it-1))/Obj(it-1)) < 10^-2)
        break;
    end
end





