add(0,Y,Y).
add(s(X),Y,s(Z)) :- add(X,Y,Z).
times(0,Y,0).
times(s(X),Y,Z) :- times(X,Y,W), add(W,Y,Z).
