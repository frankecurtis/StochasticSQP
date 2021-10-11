function [r,s] = subproblem_lin(J,c,xk,xl,xu)

[n_small,~] = size(xl);
[m,n] = size(J);
f=[zeros(n,1);ones(2*m,1)];
Aeq = [J,-speye(m),speye(m)];

lb = zeros(n+2*m,1);
ub = Inf(n+2*m,1);

lb(1:n_small) = xl;
ub(1:n_small) = xu;

lb(1:n)=lb(1:n)-xk;
ub(1:n)=ub(1:n)-xk;

x = linprog(f,[],[],Aeq,-c,lb,ub);

r = x(n+1:n+m);
s = x(n+m+1:n+2*m);

end
