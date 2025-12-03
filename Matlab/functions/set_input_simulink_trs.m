% Setta i segnali di input di simulazione del simulink taratura_reaz_stato

function set_input_simulink_trs(teta_zero_input, x_rif_step_amp_input, x_rif_step_time_input, dF_step_amp_input, dF_step_time_input)

    %teta_zero (scostamento iniziale)
    assignin('base', 'teta_zero', teta_zero_input);

    %x_step di riferimento
    assignin('base', 'x_rif_step_amp', x_rif_step_amp_input);
    assignin('base', 'x_rif_step_time', x_rif_step_time_input);

    %dF step
    assignin('base', 'dF_step_amp', dF_step_amp_input);
    assignin('base', 'dF_step_time', dF_step_time_input);
   
end
