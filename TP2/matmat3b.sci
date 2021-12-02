// Ex 8)
function [C] = matmat3b(A,B)
    C = zeros(size(A)(1), size(B)(2))
    for i = 1:size(A)(1)
        for j = 1:size(A)(2)
            for k = 1: size(B)(2)
                C(i,j) = A(i,k) * B(k,j) + C(i,j)
            end
        end
    end
endfunction

