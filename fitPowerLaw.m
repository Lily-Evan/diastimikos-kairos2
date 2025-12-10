function e = fitPowerLaw(T, E, I, time_range,energy_channels)
%fitPowerLaw Performs a power-law type fit on the input data
%
%   e = fitPowerLaw(X, Y)
%   Fits the input data, specified by the X and Y variables, according to a
%   power law fit of the form Y = e1 * X^(-e2). Output argument 'e' is a
%   vector of two elements, with e(1) = e1 and e(2) = e2.
%
%   e = fitPowerLaw(X, Y, init_vals)
%   As above, with an additional parameter of "init_vals", which should be
%   a vector of two elements, specifying the initial values for the fit
%   coefficients e(1) and e(2). If it is not given, the default parameters
%   of 5*10^9 and 3.262153178920480482 will be used.
%

    init_vals = [5*10^9; 3.262153178920480482];



% predicted = @(e1,X1) e1(1).*X1.^(-e1(2)); % Define Power Law Distribution
%    
% options = optimset('Display', 'off', 'Algorithm', 'levenberg-marquardt',...
%     'ScaleProblem', 'Jacobian', 'TolFun', 1e-12, 'TolX', 1e-10);

ind=find(T>time_range(1) & T<time_range(2));

meanflux = nanmean(I(ind,:), 1)';

E=E(energy_channels(1):energy_channels(2));
I=meanflux(energy_channels(1):energy_channels(2));

P = polyfit(log10(E), log10(I), 1);
e = [10.^P(2), -P(1)];
% e = lsqcurvefit(predicted, init_vals, E, I, [], [], options);

if energy_channels(1)==1
E1 = [30:1:230];
else
E1 = [570:1:2200];  % Min-Max Energy Fit
end

kappae1 = e(1).*E1.^(-e(2));
% kappae2 = e2(1).*E2.^(-e2(2));
plot(E1,kappae1,'-g');hold on;
% plot(E2,kappae2,'-r');hold off

end
