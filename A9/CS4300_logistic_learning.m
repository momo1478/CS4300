function [w,per_cor,Se] = ...
  CS4300_logistic_learning(X,y,alpha,max_iter,rate)
% CS4300_logistic_learning - find linear separating hyperplane
%  Eqn 18.8, p. 727 Russell and Norvig
% On input:
%     X (nxm array): n independent variable samples each of length m
%     y (nx1 vector): dependent variable samples
%     alpha (float): learning rate
%     max_iter (int): max number of iterations
%     rate (Boolean): 1 use alpha = 1000/(1000+iter) else constant
%     alpha
% On output:
%     w ((m+1)x1 vector): weights for linear function
%     per_cor (kx1 array): trace of percentage correct with weight
%     Se (kx1 array): trace of squared error
% Call:
%     [w,pc,Se] = CS4300_logistic_learning(X,y,0.1,10000,1);
% Author:
%     Eric Waugh and Monish Gupta
%     U0947296 and U1008121
%     Fall 2017
%

y = transpose(y);

n = size(X,1);
m = size(X,2);

X = [ones(n,1), X];
x = [];
iter = 0;
done = 0;
pcorrect = 0;
sqerror = 0;
hw = [];
w = -0.1 + 0.2 * rand(1,m + 1);
per_cor = [];
Se = [];
while ~done
   if rate
       alpha = 1000/(1000+iter);
   end
   for j = 1 : n
        hw(j) = 1 / (1 + exp(-dot(w,X(j,:)))) ;
        %pcorrect = pcorrect + ( dot(w,X(j,:) >= 0) == y(j) );
   end
   
   %pcorrect = pcorrect / size(y,1);
   pcorrect = sum((w*X'>=0)==y)/n;
   per_cor = [per_cor,pcorrect];
   
   sqerror = (sum(hw - y).^2)/size(y,1);
   Se = [Se,sqerror];
   
   if (sqerror == 0 || iter >= max_iter)
        done = 1;
        w = w';
        break;
   end
   
   randrow = ceil(rand * size(X,1));
   x = X(randrow,:);
   
   for i = 1 : length(w)
      w(i) = w(i) + alpha * (y(randrow) - hw(randrow))...
                          * (hw(randrow) * (1 - hw(randrow)))...
                          * x(i); 
   end
   
   iter = iter + 1;
end