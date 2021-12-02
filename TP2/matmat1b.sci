// Ex 8)
function [C] = matmat1b(A,B)
    C = zeros(size(A)(1), size(B)(2))
    for i = 1:size(A)(1)
        C(i,:) = A(i,:) * B + C(i,:)
    end
endfunction

