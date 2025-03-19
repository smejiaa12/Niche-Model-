% Funcion Epid_Sir
% Function is sent to the gsua Toolbox with the model information.

function sol = SIR1(params,domain,ins)

M = zeros(9,domain(2) + 1);

%Defne initial conditions
M(1,1) = params(1);     % Suceptible Mosquitoes
M(2,1) = params(2);     % Infected mosquitoes
M(3,1) = params(3);     % Susceptible humans
M(4,1) = params(4);     % Infected humans
M(5,1) = params(5);     % Recovered humans
M(6,1) = params(4);     % Infected humans inst
M(7,domain(1))=sum(M(1:2,domain(1))); % Mosquitoes Population
M(8,domain(1))=sum(M(3:5,domain(1))); % Human Population


% Define parameters
mu_h = params(6);       % Human probability of dying
mu_m = params(7);       % Mosquitoes probability of dying
gamma = params(8);      % Recovered probability
z = params(9);          % Number of effective interactions
beta_hm = params(10);   % Human-to-mosquito infection probability
beta_mh = params(11);   % Mosquito-to-human infection probability
r = params(12);         % Mosquitoes reproductive rate
c_m = params(13);       % Mosquitoes carrying capacity
v_h = params(14);       % Human connectivity index
v_m = params(15);       % Mosquitoes connectivity index


% Diferential Equations
for i = domain(1):domain(2)

   if ins.action==1
        if (i > 2)
            N_M = sum(M(1:2, i-2)); 
            % Emerging dynamic for the aquatic population A(t)
            A = r*N_M*exp(1-(M(1,i)+M(2,i))/c_m);
        else
            N_M = sum(M(1:2, 1));
            A = r * N_M*exp(1 - (M(1,i)+M(2,i))/c_m);
        end
   else
      if (i > 2)
          N_M = sum(M(1:2, i-2)); 
          % Emerging dynamic for the aquatic population A(t)
          A = r*N_M*exp(1-(M(1,i)+M(2,i))/(eps+c_m*ins.timeSer(i)));
      else
          N_M = sum(M(1:2, 1));
          A = r * N_M*exp(1 - (M(1,i)+M(2,i))/(eps+c_m*ins.timeSer(i)));
      end
   end
   

    if ins.action==1
        aleph_m = 1+(v_m*M(2,i))/(M(2,i)+M(1,i));
        aleph_h = 1+(v_h*(M(5,i)+M(4,i)))/(M(4,i)+M(3,i));
    else 
         aleph_m = 1+(v_m*(1-ins.Num(i))*M(2,i))/(M(2,i)+M(1,i));
         aleph_h = 1+(v_h*(1-ins.Nuh(i))*(M(5,i)+M(4,i)))/(M(4,i)+M(3,i)); 
    end

    
    if (M(3,i)<1)
        G_mh=0; % Prob of interaction Sus Human - Inf mosquito
    else
        G_mh = 1-(1-(1/M(3,i))^aleph_m)^(z*M(2,i)*(M(3,i)/M(8,i)));
    end
    G_hm = 1-(1-(M(4,i)/M(8,i))^aleph_h)^z; % Prob of interaction Sus mosquito - Inf Human
    M(1,i+1) = M(1,i)*(1-beta_hm*G_hm)*(1-mu_m)+A; % Susceptible Mosquitoes S_m
    M(2,i+1) = M(1,i)*beta_hm*G_hm*(1-mu_m)+ M(2,i)*(1-mu_m); % Infected mosquitoes I_m
    M(3,i+1) = M(3,i)*(1-beta_mh*G_mh)*(1-mu_h)+mu_h*M(8,i); % Susceptible humans S_h
    M(4,i+1) = M(3,i)*beta_mh*G_mh*(1-mu_h)+ M(4,i)*(1-gamma)*(1-mu_h); % Infected humans I_h
    M(5,i+1) = M(5,i)*(1-mu_h)+M(4,i)*(1-mu_h)*gamma; % Recovered humans R_h
    M(6,i+1) = M(6,i) + M(3,i)*beta_mh*G_mh*(1-mu_h); %Instanstin infected humans 
    % Total population
    M(7,i+1) = sum(M(1:2,i));
    M(8,i+1)= sum(M(3:5,i));
    % Store Aleph Values
    %M(9,i+1) = aleph_m;
    %M(10,i+1) = aleph_h;
    %M(9,i+1)=1-(1-((M(4,i))/M(8,i))^aleph_h)^z
    %M(9,i+1)=z*(1-(M(4,i)/M(8,i))^aleph_h)^(z-1)*((M(4,i)/M(8,i))^aleph_h)*((v_h*M(3,i)/(M(4,i)+M(3,i))^2)*log(M(4,i)/M(8,i))+aleph_h/M(4,i));
    %M(10,i+1)=-z*(M(3,i)/M(8,i))*(1-(1/M(3,i))^aleph_m)^(z*M(2,i)*(M(3,i)/M(8,i)))*(log(1-(1/M(3,i))^aleph_m)-((1/M(3,i))^aleph_m*M(2,i)*log(1/M(3,i))*v_m*M(1,i))/((M(1,i)+M(2,i))^2*(1-(1/M(3,i))^aleph_m)));
    %M(11,i+1)=abs(((M(1,i)*beta_hm*M(9,i)*(1-mu_m)*M(3,i)*beta_mh*M(10,i)*(1-mu_h))/(mu_m*(1-(1-gamma)*(1-mu_h))))^(1/2));
end 
% Solution outputs
sol = struct();
sol.x = domain(1) : domain(2)+1;
sol.y = M;
end