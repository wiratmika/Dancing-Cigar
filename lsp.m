A = [170 1 75; 165 1 67; 167 1 78; 160 1 50]; % Contoh yang di Kitab Chan
% A = [12 -51 4; 6 167 -68; -4 24 -41]; % Contoh yang di Wikipedia QR Decomposition

% This implementation is written by Wiratmika.
% You may plagiarize them, but please remember how
% awesome the original coder of this shit is.
% SEMANGAT TEMAN-TEMAN KITA PASTI BISA.
function result = unitVector(n)
    result = zeros(n, 1);
    result(1, 1) = 1;
end

function [Q, R] = householder(A)
    [m, n] = size(A);
    R = A;
    Q = eye(m, m);

    for i=1:n
        x = R(i:m, i);
        v = x + sign(x(1, 1)) * norm(x) * unitVector(m + 1 - i);
        H = eye(m, m);
        H(i:m, i:m) = H(i:m, i:m) - (2 * v * v') / (v' * v);
        Q = Q * H;
        R = H * R;
    end
end

function [Q, R] = givens(A)
    % Work in progress
end

[Q, R] = householder(A)
