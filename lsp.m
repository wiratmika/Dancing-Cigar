% A = [170 1 75; 165 1 67; 167 1 78; 160 1 50]; % Contoh yang di Kitab Chan
A = [12 -51 4; 6 167 -68; -4 24 -41]; % Contoh yang di Wikipedia QR Decomposition

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
    Q = eye(m);
    R = A;

    for i = 1:n
        x = R(i:m, i);
        v = x + sign(x(1, 1)) * norm(x) * unitVector(m + 1 - i);
        H = eye(m);
        H(i:m, i:m) = H(i:m, i:m) - (2 * v * v') / (v' * v);
        Q = Q * H;
        R = H * R;
    end
end

function [c, s] = rotate(a, b)
    if b == 0
        c = 1;
        s = 0;
    else
        if abs(b) > abs(a)
            r = a / b;
            s = 1 / sqrt(1 + r^2);
            c = s * r;
        else
            r = b / a;
            c = 1 / sqrt(1 + r^2);
            s = c * r;
        end
    end
end

function [Q, R] = givens(A)
    [m, n] = size(A);
    Q = eye(m, m);
    R = A;

    for i = 1:n
        for j = m:-1:(i + 1)
            G = eye(m, m);
            [c, s] = rotate(R(j - 1, i), R(j, i));
            G([j - 1, j], [j - 1, j]) = [c -s; s c];
            R = G' * R;
            Q = Q * G;
        end
    end
end

[Q, R] = householder(A);
Q * R; % sama lho

[Q, R] = givens(A);
Q * R; % sama lho (1)

function x = solveWithHouseholder(A, b)
    [m, n] = size(A);
    [Q, R] = householder([A b]);
    c = R(1:n, n + 1);
    R = R(1:n, 1:n);
    x = inv(R) * c;
end

solveWithHouseholder([3 -2; 0 3; 4 4], [3; 5; 4])

function x = solveWithGivens(A, b)
    [m, n] = size(A);
    [Q, R] = givens([A b]);
    c = R(1:n, n + 1);
    R = R(1:n, 1:n);
    x = inv(R) * c;
end

solveWithGivens([3 -2; 0 3; 4 4], [3; 5; 4])

% AJAIB!!!
