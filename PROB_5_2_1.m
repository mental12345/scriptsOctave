delta_x = .01;
x = (0 : delta_x : 5)';
M = zeros(size(x,1),1);
V = M;
y = M;
E = 1;
I = 1;
 

for i = 1 : size(x,1);
    M(i) = 28 * x(i);
    V(i) = 28;
    y(i) = 4.666 * x(i)^3 - 72 * x(i);
    if x(i) > 1;
        M(i) = M(i) - 10 * (x(i) - 1);
        V(i) = V(i) - 10;
        y(i) = y(i) - 1.6666 * (x(i) - 1)^3;
        if x(i) > 2;
            M(i) = M(i) - 20 * (x(i) - 2);
            V(i) = V(i) - 20;
            y(i) = y(i) - 3.333 * (x(i) - 2)^3;
            if x(i) > 3;
                 M(i) = M(i) - 20 * (x(i) - 3);
                 V(i) = V(i) - 20;
                 y(i) = y(i) - 3.3333 * (x(i) - 3)^3;
                 if x(i) == 5;
                     V(i) = V(i) + 22;
                 end
            end
        end
    end
end

y = y/(E*I); 

f = figure('visible', 'off') 
plot(x, M, 'r')
grid
title('Bending moment function ')
xlabel('x, meter')
ylabel('M(x), KN-m')
print(f, 'bending_moment2.png', '-dpng')
close(f)

f2 = figure('visible', 'off') 
plot(x, V, 'r')
grid
title('Shear force function ')
xlabel('x, meter')
ylabel('V(x), KN')
print(f2, 'shear_force2.png', '-dpng')
close(f2)


f3 = figure('visible', 'off')
plot(x, y, 'r')
grid
title('Deflection of beam ')
xlabel('x, meters')
ylabel('y, meters')
print(f3, 'deflection2.png', '-dpng')
close(f3)

[status, output] = system('cps3.sh deflection2.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end

[status, output] = system('cps3.sh bending_moment2.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end

[status, output] = system('cps3.sh shear_force2.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end