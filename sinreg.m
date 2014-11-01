function [err,model,errT] = sinreg(x,y,k,xT,yT)
%
% Finds a D-1 order sinusoidal fit to the data
%
% function [err,model,errT] = sinreg(x,y,D,xT,yT)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% D = the order plus one of the polynomial being fit
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% model = vector of polynomial parameter coefficients
% errT = average squared loss on testing
%



D=2*k+1;
sin_xx = zeros(length(x),k);
cos_xx = zeros(length(x),k);
ones_matrix=ones(length(x),1);
% Making a sin(x) matrix for training  based on the value of k
for i=1:k
  sin_xx(:,i) = sin(i*x);
end
% Making a cos(x) matrix for training based on the value of k
for i=1:k
  cos_xx(:,i) = cos(i*x);
end
% Concatinating the ones matrix, sin matrix and cos matrix to achive the
% training model as given in the question
xx=horzcat(ones_matrix,sin_xx,cos_xx);
model = pinv(xx)*y;
% Calculating least-squared error for training
err   = (1/(2*length(x)))*sum((y-xx*model).^2);

if (nargin==5)
  sin_xxT = zeros(length(xT),k);
  cos_xxT = zeros(length(xT),k);
  ones_arrayT=ones(length(xT),1);
  % Making a sin(x) matrix for testing based on the value of k
  for i=1:k
    sin_xxT(:,i) = sin(i*xT);
  end
  % Making a cos(x) matrix for testing based on the value of k
  for i=1:k
    cos_xxT(:,i) = cos(i*xT);
  end
  % Concatinating the ones matrix, sin matrix and cos matrix to achive the
  % testing model as given in the question
  xxT=horzcat(ones_arrayT,sin_xxT,cos_xxT);
  % Calculating least-squared error for testing
  errT   = (1/(2*length(xT)))*sum((yT-xxT*model).^2);
end
q  = (min(x):(max(x)/300):max(x))';
sin_xxq = zeros(length(q),k);
cos_xxq = zeros(length(q),k);
ones_arrayq=ones(length(q),1);
% Making a sin(x) matrix for plotting  based on the value of k
for i=1:k
  sin_xxq(:,i) = sin(i*q);
end
% Making a cos(x) matrix for plotting  based on the value of k
for i=1:k
  cos_xxq(:,i) = cos(i*q);
end
% Concatinating the ones matrix, sin matrix and cos matrix to achive the
% plotting model as given in the question
qq=horzcat(ones_arrayq,sin_xxq,cos_xxq);
str=sprintf('err = %f, errT = %f',err,errT);
plot(x,y,'X');
hold on
if (nargin==5)
plot(xT,yT,'cO');
end
plot(q,qq*model,'r')
title(str);
