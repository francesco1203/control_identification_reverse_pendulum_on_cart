
function [a_coeff, b_coeff, DevStd_a, DevStd_b] = ARX_manual_estimation(y, u, na, nb)
    % Stima i parametri di un modello ARX usando il metodo dei minimi quadrati.
    %
    % INPUTS:
    %   y (vettore): Dati di output misurati (risposta del sistema).
    %   u (vettore): Dati di input noti (eccitazione).
    %   na (scalare): Ordine della parte autoregressiva (numero di ritardi di y).
    %   nb (scalare): Ordine della parte esogena (numero di ritardi di u).
    %
    % OUTPUT:
    %   teta_cappello (vettore): Vettore dei parametri stimati [a1...ana, b1...bnb]' 
    %   DevStd: vettore delle deviazioni standard dei parametri


    % 1. Lunghezza dei dati (N)
    N = length(y);

    % 2. il primo campione utile è max(na, nb) + 1, per avere tutte le y e u, non partiamo da 1
    start_index = max(na, nb) + 1; 

    % 3. Prealloca la Matrice del Regressore (Phi) e il Vettore di Output (Y)

    % Numero di parametri (dimensione di theta): q = na + nb
    q = na + nb;
    
    % Phi: (N - start_index) righe per (na + nb) colonne
    % Y: (N - start_index) righe per 1 colonna
    Phi = zeros(N - start_index, q);
    Y = zeros(N - start_index, 1);

    % 4. Riempio la matrice Phi
    % L'indice 'k' va da 1 a (N - start_index) e inizia da tempo start_index
    
    for k = 1 : (N - start_index)
        t = start_index + k - 1; % Tempo corrente nel campione originale
        
        % Vettore di regressione phi(t) (preallocazione)
        phi_t = zeros(q, 1);
        
        % Componenti Autoregressive (y ritardati)
        for i = 1:na
            % phi(i) = y(t-i) [Nota: il segno dipende dalla convenzione del modello ARX]
            phi_t(i) = - y(t - i); 
        end
        
        % Componenti Esogene (u ritardati)
        for i = 1:nb
            % phi(na + i) = u(t-i)
            phi_t(na + i) = u(t - i);
        end
        
        % Assegna la riga alla Matrice Phi
        Phi(k, :) = phi_t'; 
        
        % Assegna il valore di output a Y
        Y(k) = y(t);
    end


    % 5. Implementazione della Formula LS
    % teta_cappello = (Phi' * Phi)^-1 * Phi' * Y
    
    % Matrice S(N)
    S_N = Phi' * Phi; 

    % Stima dei parametri
    teta_cappello = S_N \ (Phi' * Y); 


    % 6. split in a e b
    a_coeff = teta_cappello(1:na);
    a_coeff = [1; a_coeff];         %aggiungo l'1 iniziale di A

    b_coeff = teta_cappello(na+1:end);
    b_coeff = [0; b_coeff];         %aggiungo lo 0 inziiale di B (u(t))


    % 6. Calcolo di lambda_cappello^2

    % Residui di predizione (epsilon)
    % epsilon = Y - Phi * teta_cappello
    epsilon = Y - Phi * teta_cappello;
    
    % Varianza del rumore stimata (lambda_cappello^2)
    % (1/N) * sommatoria(epsilon^2)
    sum_epsilon = epsilon' * epsilon;
    lambda_cappello_quadro = (1 / N) * sum_epsilon; 
    
    
    % 7. Calcolo della matrice di covarianza

    % Matrice di Covarianza stimata
    % MatCov = lambda_cappello^2 * S(N)^-1
    %MatCov = inv(S_N) * lambda_cappello_quadro ;
    MatCov = S_N \ eye(size(S_N)) * lambda_cappello_quadro ;


    % 8. Estrazioni delle varianze e dunque delle devstd come radici
    VarTeta = diag(MatCov);  %elementi su diagonale = varianze di teta

    DevStd = sqrt(VarTeta);  %deviazioni standard


    % 9. split in a e b
    DevStd_a = DevStd(1:na);
    DevStd_b = DevStd(na+1:end);
    

    
end