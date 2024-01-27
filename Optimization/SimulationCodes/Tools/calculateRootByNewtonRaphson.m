function [x, n] = calculateRootByNewtonRaphson(f, df, x0, tol, max_iter)
% calculateRootByNewtonRaphson Find a root of a function using the Newton-Raphson algorithm.
% Generated with Chat-gpd

    n = 0;          % Initialize iteration counter
    x = x0;         % Initialize estimate
    while abs(f(x)) > tol && n < max_iter
        x = x - f(x)/df(x);    % Update estimate using Newton-Raphson formula
        n = n + 1;              % Increment iteration counter
    end
    
    % Check for convergence
    if abs(f(x)) > tol
        warning('Failed to converge within %d iterations', max_iter);
        x = NaN;
    end
end