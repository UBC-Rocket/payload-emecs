function [] = Pressure_ode(k,A_1,A_2,A_valve,A_tube,V_tube,V_air,B,rho,p_atm,p_air,p_fluid,n,l,x)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

g = 9.81; %acceleration due to gravity

syms p_A(t) p_B(t) p_C(t)

ode1 = diff(p_A) == (k/(A_1*(l-x)))*(B*A_valve*sqrt((2*(p_B - p_A))/(rho*exp((p_B-p_atm)/k)))+A_1*diff(x));

ode2 = diff(p_B) == (k/(A_2*(l+x)))*((B*(1/sqrt(rho*exp((p_B-p_atm)/k)))*(A_valve*sqrt(2*(p_B-p_A)-A_tube*sqrt(2*(p_B-p_C)))))-A_2*diff(x));

ode3 = diff(p_C) == exp((p_B-p_C)/k)*(k*n*p_C^(1+1/n))/(V_tube*n*p_C^(1+1/n)+k*V_air*p_air^(1/n));

odes = [ode1,ode2,ode3];

cond1 = p_A(0) == p_air;
cond2 = p_B(0) == p_air;
cond3 = p_C(0) == p_air;

conds = [cond1,cond2,cond3];

[p_ASol(t),p_BSol(t),p_CSol(t)] = dsolve(odes,conds);

end

