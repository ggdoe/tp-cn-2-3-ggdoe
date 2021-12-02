exec lsolve.sci;
exec usolve.sci;
exec gausskij3b.sci;
exec mylu3b.sci;

function [] = perf_usolve(n, nb_loop)
    time = 0; dtime = 0; err_ar = 0; err_av = 0
    for i=1:nb_loop
        U = triu(rand(n,n)); b = rand(n,1)
        tic(); x = usolve(U,b)
        tmp = toc()
        time = time + tmp
        tic(); xex = U\b
        dtime = dtime + abs(tmp - toc())
        err_av = err_av + log(norm(xex-x)/(norm(xex)))
        err_ar = err_ar + norm(b-U*x)/(norm(U) * norm(x))
    end
    disp("Erreur avant : " + string(exp(err_av/nb_loop)))
    disp("Erreur arrière : " + string(err_ar/nb_loop))
    disp("Delta Temps exec. : " + string(dtime/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction


function [] = perf_lsolve(n, nb_loop)
    time = 0; err_ar = 0; err_av = 0
    for i=1:nb_loop
        L = tril(rand(n,n)); b = rand(n,1)
        tic(); x = lsolve(L,b)
        tmp = toc()
        time = time + tmp
        tic(); xex = L\b
        time = time + abs(tmp - toc())
        err_av = err_av + norm(xex-x)/(norm(xex))
        err_ar = err_ar + norm(b-L*x)/(norm(L) * norm(x))
    end
    disp("Erreur avant : " + string(err_av/nb_loop))
    disp("Erreur arrière : " + string(err_ar/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction

function [] = perf_gausskij3b(n, nb_loop)
    time = 0; dtime = 0; err_ar = 0; err_av = 0
    for i=1:nb_loop
        A = rand(n,n); b = rand(n,1)
        tic(); x = gausskij3b(A,b)
        tmp = toc()
        time = time + tmp
        tic(); xex = A\b
        dtime = dtime + abs(tmp - toc())
        //err_av = max(err_av, norm(xex-x)/(norm(xex)))
        err_av = err_av + norm(xex-x)/(norm(xex))
        err_ar = err_ar + norm(b-A*x)/(norm(A) * norm(x))
    end
    disp("Erreur avant : " + string(err_av/nb_loop))
    disp("Erreur arrière : " + string(err_ar/nb_loop))
    disp("Delta Temps exec. : " + string(dtime/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction

function [] = perf_mylu3b(n, nb_loop)
    time = 0; err = 0;
    for i=1:nb_loop
        A = rand(n,n);
        tic(); [L, U] = mylu3b(A)
        time = time + toc()
        err = err + norm(A-L*U)
    end
    disp("Erreur : " + string(err/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction


function [] = perf_mylu1b(n, nb_loop)
    time = 0; err = 0;
    for i=1:nb_loop
        A = rand(n,n);
        tic(); [L, U] = mylu1b(A)
        time = time + toc()
        err = err + norm(A-L*U)
    end
    disp("Erreur : " + string(err/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction

function [] = perf_mylu(n, nb_loop)
    time = 0; err = 0;
    for i=1:nb_loop
        A = rand(n,n);
        tic(); [L, U, P] = mylu(A)
        time = time + toc()
        err = err + norm(A-P*L*U)/norm(A)
    end
    disp("Erreur : " + string(err/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction

function [] = perf_lu(n, nb_loop)
    time = 0; err = 0;
    for i=1:nb_loop
        A = rand(n,n);
        tic(); [P, L, U] = lu(A)
        time = time + toc()
        err = err + norm(A-P*L*U)/norm(A)
    end
    disp("Erreur : " + string(err/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction
