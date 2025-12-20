

function generated_signal_PRBS = gen_PRBS(DeltaT, N_sim, amp_PRBS, offset_PRBS, seed)
    % Genera PRBS desiderato
    %
    % Input:
    %   DeltaT       - Passo di campionamento (in secondi) utilizzato nella simulazione.
    %   N_sim        - campioni di simulazione
    %   amp_PRBS     - Ampiezza massima del segnale PRBS (es. 2.5 per segnale in [-2.5, 2.5]).
    %   offset_PRBS  - Offset o livello medio del segnale PRBS (es. 0 per segnale centrato).
    %   seed (1 o 2) - Mi dice se prendere il PRBS1 o PRBS2, per avere 2 PRBS distinti e scorrelati 
    %
    % Output:
    %   generated_signal_PRBS - Oggetto 'iddata' contenente il segnale PRBS. 
    %                           Contiene i dati del segnale, il nome del canale di input 
    %                           e l'intervallo di campionamento (DeltaT).

    %controllo di validità degli ingressi
    if(DeltaT <= 0 || N_sim <= 0)
        error('PRBS parameters must be positive.');
    end

    if (seed ~= 1 && seed ~= 2)   %dev'essere seed = 1 o 2
        error('Errore: Seed non valido. Inserire seed = 1 oppure seed = 2 per sequenze scorrelate.');
    end

    % Genero un segnale PRBS discreto di 2 N_sim campioni
    PRBS_bin = idinput(2* N_sim, 'prbs'); 

    % In base al seed uso la prima parte o la seconda, scorrelate
    if(seed == 1)
        PRBS_bin = PRBS_bin(1:N_sim); % Seleziono la prima parte del PRBS
    else %seed ==2
        PRBS_bin = PRBS_bin(N_sim+1 : end);
    end

    % Lo adatto in ampiezza, offset e passo di campionamento
    generated_signal_PRBS = iddata([], amp_PRBS * PRBS_bin + offset_PRBS, DeltaT);
end