// Ex 8)
function [C] = matmat2b(A,B)
    C = zeros(size(A)(1), size(B)(2))
    for i = 1:size(A)(1)
        for j = 1:size(A)(2)
            C(i,j) = A(i,:) * B(:,j) + C(i,j)
        end
    end
endfunction

