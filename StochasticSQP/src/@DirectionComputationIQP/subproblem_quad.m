function d = subproblem_quad(g,J,c, r, s,xl,xu)

[n_small,~] = size(xl);
[m,n] = size(J);

beq=r-s-c;

lb = zeros(n,1);
ub = Inf(n,1);

lb(1:n_small) = xl;
ub(1:n_small) = xu;

lb(1:n)=lb(1:n)-xk;
ub(1:n)=ub(1:n)-xk;


options = optimoptions('linprog','Algorithm','dual-simplex');
dd = linprog(ones(n,1),[],[],J,beq,lb,ub,options)
fprintf("linprog")
dd

d = quadprog(eye(n),g,[],[],J,beq,lb,ub,options);

end