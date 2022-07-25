function g_cl = cltf(ts,k)
g_cl = feedback((1e-5)*tf([4.711,4.644],[1,-2.875,2.753,-0.8781],ts),k);
end