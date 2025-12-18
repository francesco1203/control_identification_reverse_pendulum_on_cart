
% Plot dei risultati simulazione del simulink di validazione

function plot_id_and_real_x_teta(simOut, ss_too)
    %   Genera un grafico a doppio subplot per i dati di simulazione
    %   per il confronto identificato e sistema vero
    %
    %   Input:
    %   simOut - Oggetto Simulink.SimulationOutput (risultato della simulazione).
    %   ss_too - booleano che indica se devo stampare anche risultati in
    %            spazio di stato
    
    
    % Se ss_too non viene passato, lo imposta a false di default
    if nargin < 2
        ss_too = false;
    end


    % --- Estrazione dei dati ---
    try
        %uscite vere
        x_vero_ts = simOut.get('x_vero_sim'); 
        x_vero_data = x_vero_ts.Data;
    
        teta_vero_ts = simOut.get('teta_vero_sim'); 
        teta_vero_data = teta_vero_ts.Data;
     
        tempo_continuo = teta_vero_ts.Time;


        %uscite identificazione con modelli polinomiali
        x_id_ts = simOut.get('x_id_sim'); 
        x_id_data = x_id_ts.Data;
    
        teta_id_ts = simOut.get('teta_id_sim'); 
        teta_id_data = teta_id_ts.Data;

        tempo_discreto = teta_id_ts.Time; 

        % x_id_data e teta_id_data devono essere riportati su 'tempo_continuo' (continuo)
        x_id_data = interp1(tempo_discreto, x_id_data, tempo_continuo, 'previous');
        teta_id_data = interp1(tempo_discreto, teta_id_data, tempo_continuo, 'previous');


        %uscite identificazione modello in spazio di stato
        if(ss_too)
            ss_x_id_ts = simOut.get('ss_x_id_sim'); 
            ss_x_id_data = ss_x_id_ts.Data;
        
            ss_teta_id_ts = simOut.get('ss_teta_id_sim'); 
            ss_teta_id_data = ss_teta_id_ts.Data;
    
            ss_tempo_discreto = ss_teta_id_ts.Time; 

            % x_id_data e teta_id_data devono essere riportati su 'tempo_continuo' (continuo)
            ss_x_id_data = interp1(ss_tempo_discreto, ss_x_id_data, tempo_continuo, 'previous');
            ss_teta_id_data = interp1(ss_tempo_discreto, ss_teta_id_data, tempo_continuo, 'previous');
        end
    
        tempo = tempo_continuo;     %d'ora in poi sarà il mio tempo di riferimento

    catch ME
        error('Errore nell''estrazione dei dati.');
    end

    
    % --- x_vero vs x_id ---
    figure('Name', 'Posizione vera vs identificazione'); 
    plot(tempo, x_vero_data, 'b-', 'LineWidth', 1.5); hold on;
    plot(tempo, x_id_data,   'r-', 'LineWidth', 1.5); 
    if(ss_too)
        hold on;
        plot(tempo, ss_x_id_data, '-', 'Color',[0.10, 0.73, 0.61],  'LineWidth', 1.5);
    end
    grid on;
    
    title('Posizione del Carrello ($x$)', 'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Tempo ($s$)', 'Interpreter', 'latex');
    ylabel('Posizione $x$ ($m$)', 'Interpreter', 'latex');
    
    if(ss_too)
        legend({'$x_{\text{vero}}(t)$', '$x_{\text{id,poly}}(t)$', '$x_{\text{id,SS}}(t)$'}, ...
           'Interpreter', 'latex', 'Location', 'best');
    else
        legend({'$x_{\text{vero}}(t)$', '$x_{\text{id,poly}}(t)$'}, ...
           'Interpreter', 'latex', 'Location', 'best');
    end
    
    
    
    % --- teta_vero vs teta_id ---
    figure('Name', 'Angolo vero vs identificazione');
    plot(tempo, teta_vero_data, 'b-', 'LineWidth', 1.5); hold on;
    plot(tempo, teta_id_data,   'r-', 'LineWidth', 1.5);
    if(ss_too)
        hold on;
        plot(tempo, ss_teta_id_data, '-', 'Color', [0.10, 0.73, 0.61], 'LineWidth', 1.5);
    end
    grid on;
    
    title('Posizione Angolare del Pendolo ($\theta$)', 'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Tempo ($s$)', 'Interpreter', 'latex');
    ylabel('Angolo $\theta$ ($rad$)', 'Interpreter', 'latex');
    
    if(ss_too)
        legend({'$\theta_{\text{vero}}(t)$', '$\theta_{\text{id,poly}}(t)$', '$\theta_{\text{id,SS}}(t)$'}, ...
           'Interpreter', 'latex', 'Location', 'best');
    else
        legend({'$\theta_{\text{vero}}(t)$', '$\theta_{\text{id,poly}}(t)$'}, ...
           'Interpreter', 'latex', 'Location', 'best');
    end
    

end