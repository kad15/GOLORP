%river([f,x],[b,g])
safeState(E) -: \+ (member(f,E),member(g,E),\+ member(x,E) ; member(g,E),member(b,E),\+ member(x,E)).