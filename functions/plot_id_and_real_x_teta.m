
% Plot dei risultati simulazione del simulink di validazione

function plot_id_and_real_x_teta(simOut)
    %   Genera un grafico a doppio subplot per i dati di simulazione
    %   per il confronto identificato e sistema vero
    %
    %   Input:
    %   simOut - Oggetto Simulink.SimulationOutput (risultato della simulazione).
    

    % --- Estrazione dei dati ---
    try
        %uscite vere
        x_vero_ts = simOut.get('x_vero_sim'); 
        x_vero_data = x_vero_ts.Data;
    
        teta_vero_ts = simOut.get('teta_vero_sim'); 
        teta_vero_data = teta_vero_ts.Data;
     
        tempo_continuo = teta_vero_ts.Time;  %è lo stesso per entrambi


        %uscite identificazione
        x_id_ts = simOut.get('x_id_sim'); 
        x_id_data = x_id_ts.Data;
    
        teta_id_ts = simOut.get('teta_id_sim'); 
        teta_id_data = teta_id_ts.Data;

        tempo_discreto = teta_id_ts.Time; %è lo stesso per entrambi
    
        
    catch ME
        error('Errore nell''estrazione dei dati.');
    end

    %le uscite dei sistemi t.discreti non hanno lo stesso tempo
    %di quelle a tempo continuo, quindi bisogna interpolare

    
    % x_id_data e teta_id_data devono essere riportati su 'tempo_continuo' (continuo)
    x_id_data = interp1(tempo_discreto, x_id_data, tempo_continuo, 'previous');
    teta_id_data = interp1(tempo_discreto, teta_id_data, tempo_continuo, 'previous');

    tempo = tempo_continuo;     %d'ora in poi sarà il mio tempo di riferimento
    
    % --- x_vero vs x_id ---
    figure('Name', 'Posizione vera vs identificazione'); 
    plot(tempo, x_vero_data, 'b-', 'LineWidth', 1.5); hold on;
    plot(tempo, x_id_data,   'r-', 'LineWidth', 1.5); 
    grid on;
    
    title('Posizione del Carrello ($x$)', 'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Tempo ($s$)', 'Interpreter', 'latex');
    ylabel('Posizione $x$ ($m$)', 'Interpreter', 'latex');
    
    legend({'$x_{\text{vero}}(t)$', '$x_{\text{id}}(t)$'}, ...
           'Interpreter', 'latex', 'Location', 'best');
    
    
    % --- teta_vero vs teta_id ---
    figure('Name', 'Angolo vero vs identificazione');
    plot(tempo, teta_vero_data, 'b-', 'LineWidth', 1.5); hold on;
    plot(tempo, teta_id_data,   'r-', 'LineWidth', 1.5);
    grid on;
    
    title('Posizione Angolare del Pendolo ($\theta$)', 'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Tempo ($s$)', 'Interpreter', 'latex');
    ylabel('Angolo $\theta$ ($rad$)', 'Interpreter', 'latex');
    
    legend({'$\theta_{\text{vero}}(t)$', '$\theta_{\text{id}}(t)$'}, ...
           'Interpreter', 'latex', 'Location', 'best');

end