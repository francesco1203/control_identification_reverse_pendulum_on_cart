%Funzione di gestione del modello: estrai i coefficienti

function [A, B, C, Ts] = extract_from_model(model)

    % Input:
    % model = estratto da SI Tbox
    % Output:
    % A, B, C, Ts = parametri del modello
    
    %estraggo
    A = model.A;
    B = model.B;
    C = model.C;    %nel caso dell'ARX è banalmente 1
    Ts = model.Ts;
end