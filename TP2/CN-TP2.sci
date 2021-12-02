// Ex 6)
// 1.
x = [1, 4 ,8, 16]
// 2.
y = [8; 19; 2; 1]
// 3.
z = x' + y
s = x * y
// 4.
size(x)
size(y)
// 5.
norm(x)
// 6.
A = [1,9,8 ; 7,4,1 ; 2,6,8 ; 1,7,0]
// 7.
A'
// 8.
A = rand(4,4)
B = rand(4,4)
A+B
A'*B
A*B

// 9.
A = [1,9,8 ; 7,4,1 ; 2,6,8 ; 1,7,0]
cond(A)

// Ex 7)
// 1.
A = rand(3,3)
// 2.
xex = rand(3,1) // vecteur colonne
// 3.
b = A*xex
// 4.
x = A\b
// 5.
err_av = norm(xex-x)/(norm(xex))
err_ar = norm(b-A*x)/(norm(A) * norm(x))
disp("Erreur avant : " + string(err_av))
disp("Erreur arrière : " + string(err_ar))
// 6.
 function [] = fn_ex7(n)
	tic()
    A = rand(n,n)
    xex = rand(n,1)
    b = A*xex
    x = A\b
    err_av = norm(xex-x)/(norm(xex))
    err_ar = norm(b-A*x)/(norm(A) * norm(x))
	time = toc()
	disp("n = " + string(n) + "   time = " + string(time))
    disp("Erreur avant : " + string(err_av))
    disp("Erreur arrière : " + string(err_ar))
endfunction

fn_ex7(10)

