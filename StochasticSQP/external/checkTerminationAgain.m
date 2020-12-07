function [TTnum] = checkTerminationAgain(TTnum, x, residual, size_primal, tau, sigma, obj_grad, kappa_u, c_norm1, ...
                    kappa, CIM, PIM, mu_1, mu_2, c_norm2, theta_1, b, Jacobian, theta_2, A)

                
% if norm(residual) <= 1e-8 * kappa*min(CIM,PIM)                
                
    % Set updates
    primal_update = x(1:size_primal);
    dual_update = x(size_primal+1:end);
    primal_residual = residual(1:size_primal);
    dual_residual = residual(size_primal+1:end);

    % Check whether model reduction condition holds...
    Delta_q = -tau*(obj_grad'*primal_update + 0.5*max(primal_update'*primal_update,kappa_u*norm(primal_update)^2)) + c_norm1 - norm(dual_residual,1);

    if Delta_q >= 0.5*tau*sigma*max(primal_update'*primal_update,kappa_u*norm(primal_update)^2) + sigma*max(c_norm1 , norm(dual_residual,1) - c_norm1)
        if norm(residual) <= kappa*min(CIM,PIM)
            TTnum = 1;
            return;
        end
    end
    
    if norm(dual_residual,1) <= mu_1 * c_norm1 && norm(primal_residual,1) <= mu_2 * c_norm1
        TTnum = 2;
        return;
    end
    
    if c_norm2 <= theta_1 * norm(-b(1:size_primal) + Jacobian'*dual_update)
        if norm(-b(1:size_primal) + Jacobian'*dual_update) <= min(theta_2*norm(b(1:size_primal)) , kappa*PIM)
            TTnum = 3;
            x(1:size_primal) = zeros(size_primal,1);
            residual = A*x - b;
            return;
        end
    end
    
% end


end