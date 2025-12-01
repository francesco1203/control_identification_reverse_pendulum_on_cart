
%Per settare ingresso a circuito simulink ./simulink_models/test_mpc

function set_input_simulink_tmpc(stp_tim_u_in, stp_amp_u_in, imp_dur_d_in, imp_amp_d_in)

    % Input:
    % parametri step ad u
    % parametri impulso a d

    
    %riferimento u
    assignin('base', 'stp_tim_u', stp_tim_u_in);
    assignin('base', 'stp_amp_u', stp_amp_u_in);

    %disturbo d
    
    if(imp_dur_d_in == 0 && imp_amp_d_in == 0) 
        % L'utente intende disabilitare l'impulso, ma simulink
        % accetta solo valori positivi per dur
        imp_dur_d_in = 0.1; 
    end

    assignin('base', 'imp_dur_d', imp_dur_d_in);
    assignin('base', 'imp_amp_d', imp_amp_d_in);
   
end

