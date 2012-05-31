function r = main_exec(a, b, generations)
    epi = 0.005;

    % inicializa uma populacao com 80 individuos aleatorios na primeira
    % coluna, as outras colunas inicializadas com zero e serao setadas
    % posteriormente
    r = [(a + (b - a) .* rand(80,5)) zeros(80,1) zeros(80,1) zeros(80,1) zeros(80,1)];

    for i = 1:generations  
        x = r(:,1);
        
        % avalia os pontos da populacao pelas funcoes y1, y2, g1 e g2
        fy1 = y1(x);
        fy2 = y2(x);
        fg1 = g1(x);
        fg2 = g2(x);

        y1g1 = h(fy1, fg1, 80); % avalia quanto y1 violou g1
        y1g2 = h(fy1, fg2, 80); % avalia quanto y1 violou g2
        y2g1 = h(fy2, fg1, 80); % avalia quanto y2 violou g1
        y2g2 = h(fy2, fg2, 80); % avalia quanto y2 violou g2

        % seleciona a violacao maior de y1 com relacao a g1 e g2
        h1 = max(y1g1, y1g2); 
        % seleciona a violacao maior de y2 com relacao a g1 e g2
        h2 = max(y2g1, y2g2); 

        r = [x fy1 fy2 h1 h2];

        % ordena toda a populacao de acordo com a dominancia de um individuo
        % com relacao a y1 e y2
        r = ordena_por_dominancia(r);
        
        % avalia apenas os individuos de posicao 1 ate 40, os filhos
        % resultados dos cruzamentos substituirao os individuos de posicao
        % 41 ate 80
        alpha = rand(1,1);        
        for z = 1:40 
            % seleciona dois pontos bons aleatoriamente entre os 10
            % primeiros mais bem rankeados
            pontoBom1 = r(randi(10,1),1);
            pontoBom2 = r(randi(10,1),1);
                
            % se violou h1 e h2
            if (r(z,4) > epi) && (r(z,5) > epi)
                % cruza o individuo que violou as duas restricoes, com um
                % individuo bem rankeado
                filho = (pontoBom1 * alpha) + (r(z,1) * (1 - alpha));
                
                % cruza o individuo resultado do cruzamento acima, com
                % outro individuo bem rankeado
                r(z + 40,1) = (pontoBom2 * alpha) + (filho * (1 - alpha));
            % se violou apenas h1
            elseif r(z,4) > epi
                % cruza o individuo que violou a restricao, com um
                % individuo bem rankeado
                r(z + 40,1) = (pontoBom1 * alpha) + (r(z,1) * (1 - alpha));            
            % se violou apenas h2
            elseif r(z,5) > epi
                % cruza o individuo que violou a restricao, com um
                % individuo bem rankeado
                r(z + 40,1) = (pontoBom1 * alpha) + (r(z,1) * (1 - alpha));            
            % se não violou as restricoes
            end
        end   

        % mutacao dos novos individuos (posicoes de 41 a 80)
        for z = 41:80
            % gera um alpha aleatorio de -1 a 1
            alpha = (-1 + (1 + 1) .* rand(1,1));
            % muta o individuo somando-o com alpha
            r(z,1) = r(z,1) + alpha;
        end    
    end
end