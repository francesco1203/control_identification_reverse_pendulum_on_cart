%funzione di gestione del modello: elimina, i coeff non significativi dai
%vettori di coefficienti

function [A_rid, B_rid, C_rid] = azzera_ABC_non_sign(A, B, C, non_sign_A, non_sign_B, non_sign_C)

    % Input:
    % A, B, C = coeff. estratti del modello
    % non_sign_A = coeff. non sign di A da azzerare
    % non_sign_B = coeff. non sign di B da azzerare
    % non_sign_C = coeff. non sign di C da azzerare

    % Output:
    % A_rid, B_rid, C_rid = vettori di coeff. ridotti
    
    %elimina coefficienti non significativi 
    A_rid = A;
    if ~isempty(non_sign_A)  %controlla se ci sono coeff. da azzerare
       A_rid(non_sign_A) = 0;
    end

    B_rid = B;
    if ~isempty(non_sign_B)
        B_rid(non_sign_B) = 0;
    end

    C_rid = C;
    if ~isempty(non_sign_C)
        C_rid(non_sign_C) = 0;
    end
 
    
end