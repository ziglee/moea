function r = main_exec(a, b, generations)
    epi = 0.005;

    r = a + (b - a) .* rand(80,5);

    for i = 1:generations  
        x = r(:,1);
        fy1 = y1(x);
        fy2 = y2(x);
        fg1 = g1(x);
        fg2 = g2(x);

        y1g1 = h(fy1, fg1, 80);
        y1g2 = h(fy1, fg2, 80);
        y2g1 = h(fy2, fg1, 80);
        y2g2 = h(fy2, fg2, 80);

        h1 = max(y1g1, y1g2);
        h2 = max(y2g1, y2g2);

        r = [x fy1 fy2 h1 h2];

        r = ordena_por_dominancia(r);

        aprovados = 0;
        alpha = rand(1,1);        
        for z = 1:40
            % cruzamentos dos individuos que violaram as condicoes com algum
            % individuo aleatorio entre os primeiros 10 mais bem rankeados
            if (r(z,4) > epi) && (r(z,5) > epi)                        
                pontoBom = r(randi(10,1),1);                       
                r(z + 40,1) = (pontoBom * alpha) + (r(z,1) * (1 - alpha));            
                pontoBom = r(randi(10,1),1);                       
                r(z + 40,1) = (pontoBom * alpha) + (r(z + 40,1) * (1 - alpha));
            elseif r(z,4) > epi            
                pontoBom = r(randi(10,1),1);                       
                r(z + 40,1) = (pontoBom * alpha) + (r(z,1) * (1 - alpha));            
            elseif r(z,5) > epi            
                pontoBom = r(randi(10,1),1);                       
                r(z + 40,1) = (pontoBom * alpha) + (r(z,1) * (1 - alpha));            
            else 
                aprovados = aprovados + 1;
            end
        end   
        aprovados

        % mutacao dos novos pontos gerados
        for z = 41:80
            alpha = (-1 + (1 + 1) .* rand(1,1));
            r(z,1) = r(z-40,1) + alpha;
        end    
    end
end