
function set_input_simulink_tmpc(stp_tim_u_in, stp_amp_u_in, imp_dur_d_in, imp_amp_d_in)
    
    % Setta ingresso a circuito simulink ./simulink_models/test_mpc
    %
    % Input:
    % parametri step ad u
    % parametri impulso a d
    
    
    %controllo di validità degli ingressi
    if(stp_tim_u_in < 0 || imp_dur_d_in < 0)
        error('Input times must be non-negative.');
    end
    
    %riferimento u
    assignin('base', 'stp_tim_u', stp_tim_u_in);
    assignin('base', 'stp_amp_u', stp_amp_u_in);

    %disturbo d
    
    if(imp_dur_d_in == 0 && imp_amp_d_in == 0) % L'utente intende disabilitare l'impulso
        imp_dur_d_in = 0.1; %simulink accetta solo valori positivi per dur
    end

    assignin('base', 'imp_dur_d', imp_dur_d_in);
    assignin('base', 'imp_amp_d', imp_amp_d_in);
   
end

