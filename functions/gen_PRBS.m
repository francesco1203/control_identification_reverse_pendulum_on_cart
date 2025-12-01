% Genera PRBS desiderato

function generated_signal_PRBS = gen_PRBS(DeltaT, N_sim, amp_PRBS, offset_PRBS)

    % Input:
    %   DeltaT       - Passo di campionamento (in secondi) utilizzato nella simulazione.
    %   N_sim        - campioni di simulazione
    %   amp_PRBS     - Ampiezza massima del segnale PRBS (es. 2.5 per segnale in [-2.5, 2.5]).
    %   offset_PRBS  - Offset o livello medio del segnale PRBS (es. 0 per segnale centrato).
    %
    % Output:
    %   generated_signal_PRBS - Oggetto 'iddata' contenente il segnale PRBS. 
    %                           Contiene i dati del segnale, il nome del canale di input 
    %                           e l'intervallo di campionamento (DeltaT).

    % Genero un segnale PRBS discreto
    PRBS_bin = idinput(N_sim, 'prbs'); 

    %lo adatto in ampiezza, offset e passo di campionamento
    generated_signal_PRBS = iddata([], amp_PRBS * PRBS_bin + offset_PRBS, DeltaT);
end