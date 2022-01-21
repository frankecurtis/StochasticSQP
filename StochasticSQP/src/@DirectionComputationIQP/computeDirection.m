% Copyright (C) 2020 Albert S. Berahas, Frank E. Curtis, Daniel P. Robinson, Baoyu Zhou
%
% All Rights Reserved.

% DirectionComputationSubgradient: computeDirection
function err = computeDirection(D,options,quantities,reporter,strategies)

% Initialize error
err = false;

% Store quantities
cE = quantities.currentIterate.constraintFunctionEqualities(quantities);
JE = quantities.currentIterate.constraintJacobianEqualities(quantities);
cI = quantities.currentIterate.constraintFunctionInequalities(quantities);
JI = quantities.currentIterate.constraintJacobianInequalities(quantities);

% Determine constraint activities
cE_P = find(cE > 0);
cE_N = find(cE < 0);
cI_P = find(cI > 0);
cI_Z = find(cI == 0);

if sum(sum(isnan(JE))) > 0 || sum(sum(isnan(JI))) > 0 || sum(sum(isinf(JE)))>0 || sum(sum(isinf(JI)))>0
    err = true;
    quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),zeros(quantities.currentIterate.numberOfConstraintsInequalities,1),'stochastic');
    quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),zeros(quantities.currentIterate.numberOfConstraintsInequalities,1),'true');
    v = quantities.meritParameter * quantities.currentIterate.objectiveGradient(quantities,'stochastic');
   
    v1 = (ones(length(cE_P),1)'*JE(cE_P,:))' - (ones(length(cE_N),1)'*JE(cE_N,:))';
    v1(isnan(v1))=0;
    v = v+v1;
    quantities.setDirectionPrimal(v,'full');
    quantities.setDirectionPrimal(v,'normal');
else

% set null dual multipliers   
quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),zeros(quantities.currentIterate.numberOfConstraintsInequalities,1),'stochastic');
quantities.currentIterate.setMultipliers(zeros(quantities.currentIterate.numberOfConstraintsEqualities,1),zeros(quantities.currentIterate.numberOfConstraintsInequalities,1),'true');

g = quantities.currentIterate.objectiveGradient(quantities,'stochastic');
[xl,xu] = quantities.currentIterate.bounds;
[ixl,ixu] = quantities.currentIterate.indicesOfBounds;

trust_region_scale = norm(JE'*cE,'inf');

[normal_d,r,s,f] = subproblem_linprog(JE, cE, trust_region_scale, D.trust_region_feasibility_factor_, quantities.currentIterate.primalPoint, xl, xu, ixl, ixu);

[v,yE,yI] = subproblem_quadprog(g,JE,JI, cE, r, s,quantities.currentIterate.primalPoint,normal_d, xl,xu,ixl, ixu,trust_region_scale, D.trust_region_feasibility_factor_, D.trust_region_optimality_factor_);

% Set direction
quantities.setDirectionPrimal(v,'full');
quantities.setDirectionPrimal(normal_d,'normal');
quantities.setCurvature(quantities.directionPrimal('tangential')' * eye(quantities.currentIterate.numberOfVariables,quantities.currentIterate.numberOfVariables) * quantities.directionPrimal('tangential'),'tangential');

% Set curvature
quantities.setCurvature(v'*v,'full');

quantities.currentIterate.setMultipliers(yE,yI,'stochastic');

% Compute true direction?
if D.compute_true_
    
  
    g_true = quantities.currentIterate.objectiveGradient(quantities,'true');

    [v_true,yE_true,yI_true] = subproblem_quadprog(g_true,JE,JI, cE, r, s,quantities.currentIterate.primalPoint,normal_d, xl,xu,ixl, ixu,trust_region_scale, D.trust_region_feasibility_factor_, D.trust_region_optimality_factor_);


    % Set direction
    quantities.setDirectionPrimal(v_true,'true');
    quantities.currentIterate.setMultipliers(yE_true,yI_true,'true');

end

end


end % computeDirection

%quantities.currentIterate.setMultipliers(dy(quantities.currentIterate.numberOfVariables+1:end),[],'stochastic');
function [d,r,s,f,err] = subproblem_linprog(J,c,scale, factor, xk,xl,xu, ixl,ixu)
    err = false;
    [n_small,~] = size(xl);
    [m,n] = size(J);
if isempty(c)
    r = [];
    s = [];
    d = zeros(n,1);
    f = 0;
else
    f=[zeros(n,1);ones(2*m,1)];
    Aeq = [J,-speye(m),speye(m)];
    
    lb = -Inf(n+2*m,1);
    ub = Inf(n+2*m,1);

    lb(ixl) = xl(ixl);
    ub(ixu) = xu(ixu);

    lb(n_small+1:n+2*m)=0;

    lb(1:n)=lb(1:n)-xk;
    ub(1:n)=ub(1:n)-xk;
    
    
    lb(1:n) = max(lb(1:n), -scale*factor);
    ub(1:n) = min(ub(1:n), scale*factor);
    
    options = optimset('Display', 'off','TolCon',1e-8);
    [x,fval,exitflag,exit] = linprog(f,[],[],Aeq,-c,lb,ub,[],options); %'dual-simplex' (default)
    d = x(1:n);

    r = x(n+1:n+m);
    s = x(n+m+1:n+2*m);
    f = r'*ones(m,1)+s'*ones(m,1);
    

end

end



function [d,yE,yI] = subproblem_quadprog(g,JE,JI, c, r, s,xk, x0, xl,xu, ixl, ixu, scale, feasibility_factor, optimality_factor)

[n_small,~] = size(xl);
[m1,n] = size(JE);
[m2,n] = size(JI);

if m1 == 0
    Aeq = [];
    beq = [];
else
    beq = r-s-c;
    Aeq = JE;
end


if m2 ==0
    lb = [];
    ub = [];
else
    lb = -Inf(n,1);
    ub = Inf(n,1);

    lb(ixl) = xl(ixl);
    ub(ixu) = xu(ixu);

    lb(n_small+1:n)=0;

    lb(1:n)=lb(1:n)-xk;
    ub(1:n)=ub(1:n)-xk;
    
    lb(1:n) = max(lb(1:n), -scale*feasibility_factor - norm(g,'inf')*optimality_factor);
    ub(1:n) = min(ub(1:n), scale*feasibility_factor + norm(g,'inf')*optimality_factor);
end


options = optimset('Display', 'off','TolCon',1e-6,'TolFun',1e-6);
[d,fval,exitflag,output,lambda] = quadprog(eye(n),g,[],[],Aeq,beq,lb,ub,x0,options); %'interior-point-convex' (default)


yI = [lambda.lower(ixl);lambda.upper(ixu);lambda.lower(n_small+1:n)];
yE = lambda.eqlin;

end