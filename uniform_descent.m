function [v] = uniform_descent(x0,x1,k)
% Takes the initial value x0 and the final value x1 and returns a vector v
% of length k+1 with v(1) = x0, v(k) = 1 (if the value v(k) = 0, the 
% optimization algorithm fails) and |v(i)-v(i+1)| = (x1-x0)/k
d = (x1-x0)/k;
v = ones(1,k+1);
for i=1:k
    v(i) = x0 + d*(i-1);
end
end