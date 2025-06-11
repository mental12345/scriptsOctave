I= 1;
E = 1;
delta_x = .005;
x = (0 : delta_x : 6)';
M = zeros(size(x,1),1);
V = M;
y = M;

for i = 1 : size(x,1);
    M(i) = 3 * x(i) - x(i)^2 ;
    V(i) = 3 - 2 * x(i);
    y(i) = (3/6) * x(i)^3 - x(i)^4/12 - 2.666 * x(i);
    if x(i) > 4;
        M(i) = M(i)- (x(i) - 4)^2;
        V(i) = V(i)  - (2 *(x(i) -4)) + 3;
        y(i) = y(i) +(3/6) * (x(i) - 4)^3 - (x(i) - 6)^3/3 ;
        if x(i) == 6;
            M(i) = M(i) + 3 * (x(i) - 4);
            V(i) = V(i) -2;
            y(i) = y(i) ;
        end
    end
end

y = y/(E*I);

f = figure('visible', 'off') 
plot(2,1,1) % Bending moment
plot(x, M, 'r')
grid on
title('Bending moment function ')
xlabel('x, meter')
ylabel('M(x), kN-meter')
print(f, 'bending_moment.png', '-dpng')
close(f)


f2 = figure('visible', 'off') 
subplot(2,1,2) %Shear force
plot(x, V, 'r')
grid
title('Shear force function ')
xlabel('x, meter')
ylabel('V(x), kN')
print(f2, 'shear_force.png', '-dpng')
close(f2)

f3 = figure('visible', 'off')
plot(x, y, 'r')
grid
title('Deflection of beam ')
xlabel('x, meters')
ylabel('y, meters')
print(f3, 'deflection.png', '-dpng')
close(f3)

[status, output] = system('cps3.sh deflection.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end

[status, output] = system('cps3.sh bending_moment.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end

[status, output] = system('cps3.sh shear_force.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end