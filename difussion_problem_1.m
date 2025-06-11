%First Fick's law Diffusion problem 
%Diffusion across a thin metal plate 

x = (-.05:.001:.05)';
D = 1.2e-10; %diffusion coefficient
Xa = 0;
Ca = 2; 
Cb = 0.5;
J = 1e-7;%diffusion flux

%Calculating Xb
Xb = D * ((Ca-Cb)/J);

dx = Xa - Xb;
dc = Ca - Cb;

 
for i = 1: size(x,1);
    y(i) = (dc/dx)*x(i);
end

    
%Plot concentration gradient
f = figure('visible', 'off') 
plot(x, y, 'b');
grid
title('Linear concentration profile')
xlabel('Position x, meters ')
ylabel('Concetration of diffusion C, kg/m^3')
print(f, 'concentration_profile.png', '-dpng')
close(f)

[status, output] = system('cps3.sh concentration_profile.png results-bucket-xf34c65');

% Optional: handle result
if status != 0
    disp('Command failed:');
    disp(output);
else
    disp('Upload completed successfully');
end