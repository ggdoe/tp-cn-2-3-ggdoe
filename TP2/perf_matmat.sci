exec matmat3b.sci;
exec matmat2b.sci;
exec matmat1b.sci;

function [m] = perf_matmat(n, nb_loop)
    times = zeros(nb_loop,1)
    for i=1:nb_loop
        A = rand(n,n);B = rand(n,n)
        tic(); matmat1b(A,B) // A*B
        times(i,1) = toc()
    end
    m = mean(times(1,:))
endfunction

function [] = graph_matmat(n)
    times = zeros(n,1)
    nbr = 10
    for i=1:n
        m = 0
        for j=1:nbr
            A = rand(n,n);B = rand(n,n)
            tic(); matmat1b(A,B)
            m = m + toc()
        end
        times(i,1) = m/nbr
    end
    plot(1:n,times(:,1))
endfunction

function [] = tictoc_matmat(n, nb_loop)
    times = zeros(nb_loop,1)
    for i=1:nb_loop
        A = rand(n,n);B = rand(n,n)
        tic(); matmat1b(A,B)
        times(1,i) = toc()
        tic(); matmat2b(A,B)
        times(2,i) = toc()
        tic(); matmat3b(A,B)
        times(3,i) = toc()
        tic(); A*B
        times(4,i) = toc()
    end
    disp(mean(times(1,:)))
    disp(mean(times(2,:)))
    disp(mean(times(3,:)))
    disp(mean(times(4,:)))
endfunction
