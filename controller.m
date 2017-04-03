filename='accelData.csv';
data=csvread(filename,1,0);
t=data(1:70,1);
y=data(1:70,2);

% separate the data piecewise
% if not, curve fit toolbox doesn't find accurate function for data 
t1=data(1:2,1);
y1=data(1:2,2);

t2=data(3:4,1);
y2=data(3:4,2);

t3=data(5:64,1);
y3=data(5:64,2);

t4=data(65:70,1);
y4=data(65:70,2);

% the following coefficients generated using matlab curve fitting toolbox

% f1, polynomial fit f1(x)=p1*x+p2 
% goodness of fit: SSE 0, R-square 1
f1=[937.1,0];

% f2, polynomial fit f2(x)=p1*x+p2
% goodness of fit: SSE 2.524e-28, R-square 1
f2=[-46.82,65.2];

% f3, polynomial fit f3(x)=p1*xe9 + p2*xe8 + p3*xe7 + ...
% goodness of fit: SSE 1.835, R-square 0.9989
% polynomial fit gives better fit than sum of sines (R-square 0.9945)
% alternative: smoothing spline (R-square 1) -- treats as piecewise
% TODO: discuss spline vs. polynomial trade-offs 
f3=[-0.4047,0.1123,2.989,-0.5246,-6.858,1.005,4.837,-7.022,-0.1174,74.48];
% 95% confidence bounds
f3_cb_low=[-0.569,-0.02743,1.963,-1.297,-9.026,-0.3567,3.069,-7.845,-0.5728,74.36];
f3_cb_hi= [-0.2404,0.2521,4.016,0.2479,-4.689,2.366,6.604,-6.198,0.338,74.61];

% f4, polynomial fit (degree 5 b/c 6 data points)
% goodness of fit: SSE 1.32e-27, R-square 1
f4=[-8.944,5.907,29.49,-16.55,-47.91,36.9];

generateFcn(f1)

function fcn = generateFcn(f)
% generates a polynomial function f(x) given [p_1...p_n] coefficients
    [m,n]=size(f); % m rows, n columns
    syms x 
    for i = 1:m
        f(i,1)=f(i,1)*power(x,i);
    end
    fcn=sum(f);
end

function prd = plotRawData(t1,t2,t3,t4,y1,y2,y3,y4,f1,f2,f3,f4)
% this function plots the raw data from the rocket motor.
% the data has been fit, piecewise, w/ higher order polynomials 
end


