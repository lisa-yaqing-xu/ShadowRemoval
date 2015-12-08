function[esm] = e_sm(c1,t11,t12,c2,t21,t22)
gamma = 0.9
esm = gamma*(c1-c2)^2 + (1-gamma)*((t11-t21)^2+(t21-t22)^2)