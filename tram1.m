% konstanty, počáteční podmínky, interval, kde hledáme řešení %
x = [-d/2,d/2];g = 9.81; rho = 650; a = 0.25; a1 = 0; a2 = 0; a3 = 0 ;a4 = 0; E = 10^5; Izz = 1;d = 10; n = 20;
f = @ (x) -g*rho*a^2*1.^(x); % rozložení působící síly %
L = E*Izz*diffmat([n n+4],4,x); %diferenciální rovnice%
T1 = diffrow(n+4,0,-d/2,x); T2 = diffrow(n+4,0,d/2,x); T3 = diffrow(n+4,1,-d/2,x); T4 = diffrow(n+4,1,d/2,x); % rovnice příslušné poč. podmínkám%
% sestavení rovnice a její vyřešení %
A = [L; T1; T2; T3; T4]; rhs = [gridsample(f, n); a1; a2; a3; a4];
u = A\rhs;
plot(chebfun (u) , '.-'); % vykreslení %