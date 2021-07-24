Using the iterative solver option in StochasticSQP requires "Matlab files (original)" of MINRES published by the Systems Optimization Laboratory at Stanford University.  As of July 2021, this code was available here:

https://web.stanford.edu/group/SOL/software/minres/

Specifically, the Matlab files should be downloaded through this link:

https://web.stanford.edu/group/SOL/software/minres/minres-matlab.zip

If this link is no longer active and/or the MINRES code has been updated, then the instructions below may no longer be valid.  In that case, we (the authors of StochasticSQP) would appreciate it if you could let us know.

Assuming the link is active and the MINRES code has not been updated since July 2021, then please do the following:

1) Download the link with the link above into the "external" directory containing this README file.

2) Unzip the software and move minres.m to this "external" directory (not a subdirectory).

3) Open minres.m in an editor and make the following modifications:

  a) Modify the function call to:

    [ x, istop, itn, rnorm, Arnorm, Anorm, Acond, ynorm, SS_out ] = ...
    minres( A, b, M, shift, show, check, itnlim, rtol, SS_in )

  b) Add the following call in line 279 (after the update of x):

    % Check for termination test or Hessian modification
    SS_out = SS_in.directionComputation.terminationTests(A,b,itn,x,SS_in.quantities);
    if SS_out.flag == 1, return; end

  We also recommend the following modifications:

  c) Comment-out the fprintf statements in lines 119, 120, 122, 125, 137, 138, 140, and 143.

  d) Comment-out the conditional break in line 364.