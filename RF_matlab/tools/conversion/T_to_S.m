function S=T_to_S(t_param);

t11=t_param(1,1);
t12=t_param(1,2);
t21=t_param(2,1);
t22=t_param(2,2);

S=[t21/t11,det(t_param)/t11;1/t11,-t12/t11];