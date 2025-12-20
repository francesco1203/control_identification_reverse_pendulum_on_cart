
function plot_x_teta(simOut)
    % Genera un grafico a doppio subplot per i dati di simulazione
    % di un sistema carrello-pendolo inverso (posizione e angolo).
    %
    %
    %   Input:
    %   simOut - Oggetto Simulink.SimulationOutput (risultato della simulazione).
    
    % --- 1. Estrazione dei dati ---
    try
        x_ts = simOut.get('x_sim'); 
        x_data = x_ts.Data;
    
        teta_ts = simOut.get('teta_sim'); 
        teta_data = teta_ts.Data;
    
        % Estrae il vettore tempo (assumiamo sia lo stesso per entrambi)
        tempo = teta_ts.Time; 
    catch ME
        error('Errore nell''estrazione dei dati.');
    end
    
    
    % --- 2. Figura 1: Posizione del Carrello (x) ---
    figure('Name', 'Posizione Carrello'); % Crea la prima figura nominata
    plot(tempo, x_data, 'b-', 'LineWidth', 1.5); % Plotta x in blu
    grid on;
    title('Posizione del Carrello ($x$)', 'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Tempo ($s$)', 'Interpreter', 'latex');
    ylabel('Posizione $x$ ($m$)', 'Interpreter', 'latex');
    legend('$x(t)$', 'Interpreter', 'latex', 'Location', 'best');
    
    % --- 3. Figura 2: Posizione Angolare del Pendolo (theta) ---
    figure('Name', 'Angolo Pendolo'); % Crea la seconda figura nominata
    plot(tempo, teta_data, 'r-', 'LineWidth', 1.5); % Plotta teta in rosso
    grid on;
    title('Posizione Angolare del Pendolo ($\theta$)', 'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Tempo ($s$)', 'Interpreter', 'latex');
    ylabel('Angolo $\theta$ ($rad$)', 'Interpreter', 'latex');
    legend('$\theta(t)$', 'Interpreter', 'latex', 'Location', 'best');

end