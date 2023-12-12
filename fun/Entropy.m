function H = Entrop(X)
    G = 256;
    [L, N] = size(X);
    H = zeros(L, 1);
    minX = min(X(:));
    maxX = max(X(:));
    edge = linspace(minX, maxX, G);
    for i = 1 : L
        histX = hist(X(i, :), edge) / N;
        H (i) = - histX * log(histX + eps)';
    end  
    
%     
%     % Establish size of data
% [n m] = size(X);
% % Housekeeping
% H = zeros(1,m);
% for Column = 1:m
%     % Assemble observed alphabet
%     Alphabet = unique(X(:,Column));
% 	
%     % Housekeeping
%     Frequency = zeros(size(Alphabet));
% 	
%     % Calculate sample frequencies
%     for symbol = 1:length(Alphabet)
%         Frequency(symbol) = sum(X(:,Column) == Alphabet(symbol));
%     end
% 	
%     % Calculate sample class probabilities
%     P = Frequency / sum(Frequency);
% 	
%     % Calculate entropy in bits
%     % Note: floating point underflow is never an issue since we are
%     %   dealing only with the observed alphabet
%     H(Column) = -sum(P .* log2(P));
% end
    

    
end
