
%Per settare ingresso a circuito simulink ./simulink_models/test_identificazione.slx

function set_input_simulink_tid(stp_tim_u_in, stp_amp_u_in, sin_frq_u_in, sin_amp_u_in, stp_tim_d_in, stp_amp_d_in, imp_dur_d_in, imp_amp_d_in)

    % Input:
    % parametri step ad u
    % parametri sin ad u
    % parametri step a d
    % parametri impulso a d

    %controllo di validità degli ingressi
    if(stp_tim_u_in < 0 || sin_frq_u_in <0 || stp_tim_d_in < 0 ||  imp_dur_d_in < 0)
        error('Input times must be non-negative.');
    end
    

    %riferimento u
    assignin('base', 'stp_tim_u', stp_tim_u_in);
    assignin('base', 'stp_amp_u', stp_amp_u_in);

    assignin('base', 'sin_frq_u', sin_frq_u_in);
    assignin('base', 'sin_amp_u', sin_amp_u_in);


    %disturbo d
    assignin('base', 'stp_tim_d', stp_tim_d_in);
    assignin('base', 'stp_amp_d', stp_amp_d_in);


    if(imp_dur_d_in == 0 && imp_amp_d_in == 0) 
        % L'utente intende disabilitare l'impulso, ma simulink
        % accetta solo valori positivi per dur
        imp_dur_d_in = 0.1; 
    end

    assignin('base', 'imp_dur_d', imp_dur_d_in);
    assignin('base', 'imp_amp_d', imp_amp_d_in);
   
end

