% To save the files create the next Excel files:

%   - BloqProtAcum.xlsx --> values for each protein concentration
%   - BloqProtAcumTotal.xlsx --> values for all the proteins
%   - BloqIgMPos.xlsx --> file for IgM positives
%   - BloqIgGPos.xlsx --> file for IgG positives

% Add these lines for non-batch processing:

% clear all
% close all
% fName = 'Excel/Chip34_R600_G600_CN18';
% chipNum=34;controlNeg = [18];sizeBloque = 96;
% fileName = 'Chip34_CN18';
 
nomRes = sprintf('Chip_%s_resultados.csv',num2str(chipNum));
fidRes = fopen(nomRes,'w');

noPlot = 0; 
noFiles = 1;
noBloq = 0;
noBloqIgMPos = 0;
noBloqIgGPos = 0;

%if noResChips== 0, Resultados = xlsread('Resultados_chips.xlsx');end % fichero de datos por chip
if noBloq== 0; BloqProt = xlsread('BloqProtAcum.xlsx');end % fichero de resultados acumulados max. conc.
if noBloq== 0; BloqProtAcumTotal = xlsread('BloqProtAcumTotal.xlsx');end % ficheros con todas las proteinas
if noBloqIgMPos == 0, BloqIgMPos = xlsread('BloqIgMPos.xlsx');end % fichero de positivos
if noBloqIgGPos==0, BloqIgGPos = xlsread('BloqIgGPos.xlsx');end % fichero de positivos


% INTA = xlsread('Correspondencia_INTA.xlsx');
% ind = find(INTA == chipNum);
% INTAnum = INTA(ind,3);

Res635 = [zeros(24,1)']; Res532 = [zeros(24,1)'];
DataRaw = xlsread(strcat(fName,'.xlsx'));

% Comienzo de bloques
% col 9 F635Median
% col 13 B635
% col 21 F532Median
% col 25 B532 
% col 46 F635 Median - B635
% col 49 F532 Mean - B532
% col 52 SNR 635
% col 53 SNR 532

% Controles negativos por numero de chip
% if chipNum == 21,controlNeg = 22;end % 
% if chipNum == 22,controlNeg = 3;end %
% if chipNum == 23,controlNeg = 13;end % 
% if chipNum == 24,controlNeg = 15;end % 
% if and(chipNum >= 25,chipNum<= 30), controlNeg = [23];end % Chip 25-30
% if and(chipNum >= 31,chipNum<= 32),controlNeg = [15];end % Chip 31 y 32
% if chipNum == 33,controlNeg = [3,16];end % Chip 33
% if chipNum == 34,controlNeg = [18];end % Chip 33
% if and(chipNum >= 35,chipNum<= 37),controlNeg = [1];end % Chip 33
% if chipNum == 34,controlNeg = [8];end % Chip 34
% if chipNum == 38,controlNeg = [1];end % Todos he seleccionado el 1
% if chipNum == 39,controlNeg = [2];end %  Original 9
% if chipNum == 40,controlNeg = [11];end %  
% if chipNum == 41,controlNeg = [15,19];end % del 15 o 19
% if and(chipNum >= 42,chipNum<= 43),controlNeg = [8];end % Todos
% if chipNum == 44,controlNeg = [1];end %  
% if chipNum == 45,controlNeg = [1];end %  
% if chipNum == 46,controlNeg = [3];end %
% if chipNum == 47,controlNeg = [2];end %
% if chipNum == 48,controlNeg = [12];end % 
% if chipNum == 68,controlNeg = [9 16];end %
% if and(chipNum >= 64,chipNum <= 67) controlNeg = [10];end % 
% if and(chipNum >= 74,chipNum <= 79) controlNeg = [19];end %
% if chipNum == 80,controlNeg = [1];end %
% if and(chipNum >= 81,chipNum <= 108) controlNeg = [19];end %
% if chipNum == 109,controlNeg = [21];end %
% if and(chipNum >= 110,chipNum <= 119) controlNeg = [19];end %
% if chipNum == 113,controlNeg = [16];end %
% Tipos de chip
% chipType = 1 /#21
% chipType = 2 /#25-34
% chipType = 3/ #35-33

if chipNum == 21,
id1 = [ 83 95 107; 23 35 47; 82 94 106;...
    22 34 46;81 93 105;21 33 45; 80 92 104;20 32 44;...
    79 91 103; 19 31 43; 74 86 98; 14 26 38; 76 88 100;...
    16, 28 40; 75 87 99; 15 27 39; 77 89 101;17 29 41];
% nom = [{'N5Nt01'};{'N5Nt02'};{'N6Ct0.05'};...
%     {'N6Ct0.1'};{'NC10.05'};{'NC1 0.1'};{'NC2 0.05'};{'NC2 0.1'};...
%     {'NP2 0.05'}; {'NP2 0.1'}; {'P 0.05'};{'P 0.1'};{'RBD1 0.1'};...
%     {'RBD1 0.2'}; {'RBD2 0.05'};{'RBD2 0.1'};{'S1 0.2'};{'S1 0.1'}];
nom = [ {'N5Nt'};{'N6Ct'};...
    {'NC1'};{'NC2'};...
    {'NP2'}; {'P'};{'S'};...
    {'RBD2'};{'S1'}];


end


if or(chipNum >= 25, chipNum <= 34),
id1 = [  83 95 NaN; 35 47 NaN; 82 94 NaN;...
    34 46 NaN;81 93 NaN; 33 45 NaN; 80 92 NaN;32 44 NaN;...
    79 91 NaN; 31 43 NaN; 74 86 NaN; 26 38 NaN; 76 88 NaN;...
    28 40 NaN; 75 87 NaN; 27 39 NaN; 77 89 NaN; 29 41 NaN];
% nom = [ {'N5Nt01'};{'N5Nt02'};{'N6Ct0.05'};...
%     {'N6Ct0.1'};{'NC10.05'};{'NC1 0.1'};{'NC2 0.05'};{'NC2 0.1'};...
%     {'NP2 0.05'}; {'NP2 0.1'}; {'P 0.05'};{'P 0.01'};{'RBD1 0.1'};...
%     {'RBD1 0.2'}; {'RBD2 0.05'};{'RBD2 0.1'};{'S1 0.2'};{'S1 0.1'}];

nom = [ {'N5Nt'};{'N6Ct'};...
    {'NC1'};{'NC2'};...
    {'NP2'}; {'P'};{'S'};...
    {'RBD2'};{'S1'}];

end


if chipNum >= 35,
id1 = [  82 83 NaN; 86 87 NaN; 74 75 NaN;...
    78 79 NaN;66 67 NaN; 70 71 NaN; 58 59 NaN;62 63 NaN;...
    50 51 NaN; 54 55 NaN; 10 11 NaN; 14 15 NaN; 26 27 NaN;...
    30 31 NaN; 18 19 NaN; 22 23 NaN; 34 35 NaN; 38 39 NaN];
% nom = [ {'N5Nt01'};{'N5Nt02'};{'N6Ct0.05'};...
%     {'N6Ct0.1'};{'NC10.05'};{'NC1 0.1'};{'NC2 0.05'};{'NC2 0.1'};...
%     {'NP2 0.05'}; {'NP2 0.1'}; {'P 0.05'};{'P 0.1'};{'RBD1 0.1'};...
%     {'RBD1 0.2'}; {'RBD2 0.05'};{'RBD2 0.1'};{'S1 0.2'};{'S1 0.1'}];

nom = [ {'N5Nt'};{'N6Ct'};...
    {'NC1'};{'NC2'};...
    {'NP2'}; {'P'};{'S'};...
    {'RBD2'};{'S1'}];
end

if chipNum >= 74,
id1 = [  82 83 NaN; 86 87 NaN; 74 75 NaN;...
    78 79 NaN;66 67 NaN; 70 71 NaN; 58 59 NaN;62 63 NaN;...
    50 51 NaN; 54 55 NaN; 10 11 NaN; 14 15 NaN; 26 27 NaN;...
    30 31 NaN; 18 19 NaN; 22 23 NaN; 34 35 NaN; 38 39 NaN];
% nom = [ {'N5Nt 0.05'};{'N5Nt 0.1'};{'N6Ct 0.05'};...
%     {'N6Ct 0.1'};{'NC1 0.05'};{'NC1 0.1'};{'NC2 0.05'};{'NC2 0.1'};...
%     {'NP2 0.05'}; {'NP2 0.1'}; {'P 0.05'};{'P 0.1'};{'S 0.1'};...
%     {'S 0.2'}; {'RBD2 0.05'};{'RBD2 0.1'};{'S1 0.2'};{'S1 0.1'}];
nom = [ {'N5Nt'};{'N6Ct'};...
    {'NC1'};{'NC2'};...
    {'NP2'}; {'P'};{'S'};...
    {'RBD2'};{'S1'}];
end

% orden de ploteado en el eje X de las proteinas

orden_plot = [4,0,5,0,6,0,3,0,7,0,2,0,8,0,9,0,1];
%orden_plot = [1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9];


factNeg = [2,2,2,...
    2,2,2,2,2,...
    2,2,2,2,2,...
    2,2,2,2,2]; % Factor para calcular el control negativo


% numBloques = 24;
% sizeBloque = size(DataRaw,1)/numBloques;


 
numBloques = size(DataRaw,1)/sizeBloque;


numProt = size(id1,1);
numProtDif = numProt/2;
numPuntosProt = size(id1,2);
minSNR = 3;  % minimo SNR
minR = 0;    % minimoa relacion F/B
minPos = 70;  % procentaje para considerar positivo
thresPos = 50;  % porcentaje dudoso 
%colorRange = [ 0 50 100 300 500 800 1000 2000 5000]; % Rango de colores para el ploteado
colorRange = [ 0 100 300 800 2000 5000];
numColor = 5;
map = [255,255,255;
       255,255,0;
       255,152,0;
       255,0,0;
       146,89,0]/255;
       
%listColor = colormap(jet(numColor));
listColor = colormap(map);

maxSNR = 20;

mType635 = 'o';
puntoS635 = 5;
 
MaxMarker = 12;
MaxProt = 100;
MaxProtColor = 500;

%listColor635 = colormap(autumn(numColor));
%listColor532 = colormap(winter(numColor));




if noPlot == 0,
%     pos635 = [0.1 0.1 0.35 0.8];
%     pos532 = [0.48 0.1 0.5 0.8];
    
    pos635 = [0.1 0.1 0.25 0.8];
    pos532 = [0.37 0.1 0.37 0.8];
    
    subplot('Position',pos532) 
    subplot('Position',pos635) 
end


k = 1;
for i = 1:sizeBloque:size(DataRaw,1), % 24 bloques
    block(k,1) = i; block(k,2) = i+sizeBloque;
    k = k+1;
end

% Lectura de los controles negativos
controlNeg635B = []; controlNeg532B=[];
for k = 1: size(controlNeg,2), % Controles Negativos 
    Neg635Prot = []; snr635Prot = [];
    Neg532Prot = []; snr532Prot = [];
 for i = 1: numProt,  % Controles negativos
    Neg635 = [];Neg532=[];snr635 = [];snr532=[];
    for j = 1: numPuntosProt ,      % Numero de proteinas
        if isnan(id1(i,j)) == 1, 
            Neg635 = [Neg635 NaN];
            Neg532 = [Neg532 NaN];
            continue
        end
        i1 = block(controlNeg(k)) +id1(i,j) -1;
        F635 = DataRaw(i1,9);
        B635 = DataRaw(i1,13);
        F532 = DataRaw(i1,21);
        B532 = DataRaw(i1,25);
        snr635L = DataRaw(i1,52);
        snr532L = DataRaw(i1,53);
        Neg635 =[Neg635 F635-B635];
        Neg532 =[Neg532 F532-B532];
        
    end
    Neg635Prot = [Neg635Prot; Neg635];
    Neg532Prot = [Neg532Prot; Neg532];
    snr635Prot = [snr635Prot; snr635];
    snr532Prot = [snr532Prot; snr532];
    
     
 end
 
controlNeg635B = [ controlNeg635B  Neg635Prot ]; 
controlNeg532B = [ controlNeg532B  Neg532Prot ]; 

 
end

%   Valores de referencia para los controles negativos
for i = 1:numProt,
    controlNeg635(i) =  factNeg(i)*(nanmean(controlNeg635B(i,:))+2*nanstd(controlNeg635B(i,:))); 
    controlNeg532(i) =  factNeg(i)*(nanmean(controlNeg532B(i,:))+2*nanstd(controlNeg532B(i,:))); 
end
 

% Lectura de cada uno de los bloques
blockT635=[];blockT532=[];

if noPlot == 0,
    figure(1)
    set(gcf,'PaperPositionMode','auto')
end

for k = 1:numBloques,
    disp(sprintf('Chip %s bloque %s', num2str(chipNum),num2str(k)))
    %figure(k)
    blockP635= [];blockP532= [];
    blockP635Total= [];blockP532Total= [];
    listColor = colormap(map);
    yPuntos532MeanTotal = [];yPuntos635MeanTotal = [];
    yPuntos635NTotal = []; yPuntos532NTotal = [];
    
    serie = 0;
    for p = 1:2: numProt, % se evaluan las proteinas por tipo (2 concentraciones)
        
        % valores de los controles negativos para cada una de las
        % concentracion
        thBck635_a = controlNeg635(p);
        thBck532_a = controlNeg532(p);
        thBck635_b = controlNeg635(p+1);
        thBck532_b = controlNeg532(p+1);

        yPuntos635_a = []; yPuntos532_a=[];
        yPuntos635_b = []; yPuntos532_b=[];
        snr635_a = []; snr532_a = [];
        snr635_b = []; snr532_b = [];
        
        for m = 1: numPuntosProt,
            if isnan(id1(p,m)) == 1, continue, end
            i1 = block(k) + id1(p,m) -1 ;
            i1b = block(k) + id1(p+1,m) -1 ; % proteina con segunda conc.
            
            F635_a = DataRaw(i1,9); F635_b = DataRaw(i1b,9);
            B635_a = DataRaw(i1,13); B635_b = DataRaw(i1b,13);
            
            F532_a = DataRaw(i1,21); F532_b = DataRaw(i1b,21);
            B532_a = DataRaw(i1,25); B532_b = DataRaw(i1b,25);
            
            snr635L_a = DataRaw(i1,52);snr635L_b = DataRaw(i1b,52);
            snr532L_a = DataRaw(i1,53); snr532L_b = DataRaw(i1b,53);

            % Lectura de los valores, solo cuando se está por debajo del
            % nivel mínimo de SNR
            
            if snr635L_a < minSNR,
            yPuntos635_a = [yPuntos635_a NaN];
            else
            yPuntos635_a = [yPuntos635_a F635_a-B635_a];
            end
            
            if snr635L_b < minSNR,
            yPuntos635_b = [yPuntos635_b NaN];
            else
            yPuntos635_b = [yPuntos635_b F635_b-B635_b];
            end
            
            if  snr532L_a < minSNR,
            yPuntos532_a = [yPuntos532_a NaN];
            else
            yPuntos532_a = [yPuntos532_a F532_a-B532_a];
            end
            
            if  snr532L_b < minSNR,
            yPuntos532_b = [yPuntos532_b NaN];
            else
            yPuntos532_b = [yPuntos532_b F532_b-B532_b];
            end
            
            % Registro de los datos de señal ruido
            
            if or( isnan(snr635L_a) == 1, snr635L_a <= minSNR)
                snr635_a = [snr635_a NaN];
            else
                snr635_a = [snr635_a snr635L_a];
            end
          
            if or( isnan(snr635L_b) == 1, snr635L_b <= minSNR)
                snr635_b = [snr635_b NaN];
            else
                snr635_b = [snr635_b snr635L_b];
            end
            
            if or( isnan(snr532L_a) == 1, snr532L_a <= minSNR)
                snr532_a = [snr532_a NaN];
            else
                snr532_a = [snr532_a snr532L_a];
            end
            
            if or( isnan(snr532L_b) == 1, snr532L_b <= minSNR)
                snr532_b = [snr532_b NaN];
            else
                snr532_b = [snr532_b snr532L_b];
            end
        
             
        end % Fin del ciclo de lectura para una proteina 

        
        
        % Calculo de los estimadores 
        % valores de las proteinas A (primera concentracion)
        
        yPuntos635N_a = 100*(yPuntos635_a - thBck635_a)/ thBck635_a;
        yPuntos532N_a = 100*(yPuntos532_a - thBck532_a)/ thBck532_a;
       
        yPuntos635Mean_a = nanmean(yPuntos635N_a);
        snr635Mean_a = nanmean(snr635_a);
        
        yPuntos532Mean_a = nanmean(yPuntos532N_a);
        snr532Mean_a = nanmean(snr532_a);
        
        % valoresde las proteinas B (segunda concentracion)

        yPuntos635N_b = 100*(yPuntos635_b - thBck635_b)/ thBck635_b;
        yPuntos532N_b = 100*(yPuntos532_b - thBck532_b)/ thBck532_b;
        
        yPuntos635Mean_b = nanmean(yPuntos635N_b);
        snr635Mean_b = nanmean(snr635_b);
        
        yPuntos532Mean_b = nanmean(yPuntos532N_b);
        snr532Mean_b = nanmean(snr532_b);
        
      
        
        % Seleccion de la concentracion A o B. Se utiliza el mayor de los
        % dos valores
        
        if yPuntos635Mean_a >= yPuntos635Mean_b,
            yPuntos635Mean = yPuntos635Mean_a;
            snr635Mean = snr635Mean_a;
        else
            yPuntos635Mean = yPuntos635Mean_a;
            snr635Mean = snr635Mean_a;
        end
        
        if yPuntos532Mean_a >= yPuntos532Mean_b,
            yPuntos532Mean = yPuntos532Mean_a;
            snr532Mean = snr532Mean_a;
        else
            yPuntos532Mean = yPuntos532Mean_a;
            snr532Mean = snr532Mean_a;
        end
        
        % Almacenamiento de datos
        
%         yPuntos635NTotal = [yPuntos635NTotal yPuntos635N_a yPuntos635N_b];
%         yPuntos532NTotal = [yPuntos532NTotal yPuntos532N_a yPuntos532N_b];
%         yPuntos635MeanTotal = [yPuntos635MeanTotal yPuntos635Mean ];
%         yPuntos532MeanTotal = [yPuntos532MeanTotal yPuntos532Mean ];
        yPuntos635NTotal = [ yPuntos635N_a yPuntos635N_b];
        yPuntos532NTotal = [ yPuntos532N_a yPuntos532N_b];
        yPuntos635MeanTotal = [ yPuntos635Mean ];
        yPuntos532MeanTotal = [ yPuntos532Mean ];
        

        
        if isnan(yPuntos635Mean) == 1, yPuntos635Mean=NaN;end
        if isnan(yPuntos532Mean) == 1, yPuntos532Mean=NaN;end
        
        % REPRESENTACION DE LOS DATOS
        
        % El nivel de colores se determina en base a la señal.
        
        % Asignacion de colores
        
        for ic = 2:size(colorRange,2)
            if isnan(yPuntos635Mean) == 1,c635=[0,0,0]; break, end
            if yPuntos635Mean < colorRange(1),
                    c635=listColor(1,1:3); break
            end
            if yPuntos635Mean >= colorRange(end)
                    c635=listColor(numColor,1:3);
            end
            if and(yPuntos635Mean >= colorRange(ic-1),yPuntos635Mean < colorRange(ic)),
                    c635=listColor(ic-1,1:3);break
            end
        end
        for ic = 2:size(colorRange,2)
            if isnan(yPuntos532Mean) == 1, c532=[0,0,0]; break, end
            if yPuntos532Mean < colorRange(1),
                    c532=listColor(1,1:3); break
            end
            if yPuntos532Mean >= colorRange(end),
                    c532=listColor(numColor,1:3);
            end
            if and(yPuntos532Mean >= colorRange(ic-1),yPuntos532Mean < colorRange(ic)),
                    c532=listColor(ic-1,1:3);break
            end
        end
        
        mType635 = 'o';
        puntoS635 = 4;
        
        % Asignacion del marcador
        
        if isnan(yPuntos635Mean)==1, mType635 = '*';puntoS635 = 2;,end
        if yPuntos635Mean <= 0, mType635 = '*';puntoS635 = 2;,end
        if and ( yPuntos635Mean > 0, yPuntos635Mean <= MaxProt),puntoS635 = yPuntos635Mean*MaxMarker/MaxProt;,end  
        if yPuntos635Mean >=MaxProt,puntoS635 = MaxMarker;,end  
        
        mType532 = 'o';
        puntoS532 = 4;
        
        if isnan(yPuntos532Mean)==1, mType532 = '*';puntoS532 = 2;,end
        if yPuntos532Mean <= 0, mType532 = '*';puntoS532 = 2;,end
        if and ( yPuntos532Mean > 0, yPuntos532Mean <= MaxProt),puntoS532 = yPuntos532Mean*MaxMarker/MaxProt;,end  
        if yPuntos532Mean >=MaxProt,puntoS532 = MaxMarker;,end  
        
        % Dibujo de los puntos
        
        if noPlot == 0,
            %xp = (numProt/2 + 1)-(p-serie) 
            xp = orden_plot(p);
            yp = k;
            subplot('Position',pos532); plot(xp,k,mType532,'MarkerSize',...
                puntoS532 ,'MarkerFaceColor',c532,'MarkerEdgeColor','k'); hold on
            subplot('Position',pos635); plot(xp,k,mType635,'MarkerSize',...
                puntoS635 ,'MarkerFaceColor',c635,'MarkerEdgeColor','k'); hold on
           %  serie = serie + 1; % indice apra ajustar el punto de representacion
        end
        
        
        blockP635 = [blockP635; yPuntos635Mean];
        blockP532 = [blockP532; yPuntos532Mean];
        blockP635Total = [blockP635Total, yPuntos635NTotal];
        blockP532Total = [blockP532Total, yPuntos532NTotal];

    
    end % Fin del ciclo para las proteina de un bloque
    
    
    % Marcado de positivos y lineas de alarma
    
    % nom = [ {'N5Nt'};{'N6Ct'};{'NC1'};{'NC2'};{'NP2'}; {'P'};{'S'};{'RBD2'};{'S1'}];
 
    if isnan(blockP635(9)) == 1,  % Señal de la proteina S1- 9
        Res635(k) = -1;         
    end
    if isnan(blockP532(9)) == 1,
        Res532(k) = -1;         
    end
    
    if blockP635(9) <= colorRange(2),
        Res635(k) = 0;         
    end

     %   Busqueda de IgM /IgG
     
    rColor = 'k';
    wLine = 1;
    rIgmIgg = NaN;
    
    if blockP635(9) > colorRange(3), 
        if blockP532(9) > 0
            rIgmIgg = blockP635(9)/blockP532(9) ;
%             if and ( rIgmIgg >= 0.5, rIgmIgg <= 1), rColor ='c'; end
            if  rIgmIgg > 1, rColor ='r'; wLine = 2; end
        end
        if blockP532(9) <= 0,
             rIgmIgg = 999;
             rColor ='r'; wLine = 2;
        end
    end


    %colorRange = [ 0 50 100 300 500 800 1000 2000 5000];  
    %colorRange = [ 0    100 300     800      2000 5000];
   % nom = [ {'N5Nt'};{'N6Ct'};{'NC1'};{'NC2'};{'NP2'}; {'P'};{'S'};{'RBD2'};{'S1'}];
   
   % Como positivo utilizas el mayor NC2, P y S1.
   
    maxS635 =  max([blockP635(4),blockP635(6),blockP635(9)]) ; 
    if maxS635 <= colorRange(2),
        Res635(k) = 0;        % Negativo 
    end
    
    if and(maxS635>= colorRange(2), maxS635 < colorRange(3)),
        
%      if noPlot == 0, subplot('Position',pos635); plot([0 numProt/2+1],[k k],'--','Color',rColor,...
%             'LineWidth',wLine); end
%      Res635(k) = 1;        % Dudoso
    % No se marca los dudosos
    Res635(k) = 1;
    end
    if maxS635 >= colorRange(3),
        yp = k;
       if noPlot == 0, subplot('Position',pos635); plot([0 numProt/2+1],[yp yp],'-','Color',rColor,...
            'LineWidth',wLine); end
        Res635(k) = 2;  % Positivo
    end
   

    %colorRange = [ 0 50 100 300 500 800 1000 2000 5000];
    %colorRange = [ 0    100 300     800      2000 5000];   
    
    maxS532 = max([blockP532(4),blockP532(6),blockP532(9)]);
    if maxS532 <= colorRange(2),
        Res532(k) = 0;      % Negativo   
    end
    if maxS532 >= colorRange(2),
        yp = k;
        if noPlot == 0,subplot('Position',pos532); plot([0 numProt/2+1],[yp yp],'-k'); end
        Res532(k) = 1; % Positivo
    end
     
%      if and(maxS532 >= colorRange(2),maxS532 < colorRange(3)),
%         if noPlot == 0,subplot('Position',pos532); plot([0 numProt/2+1],[k k],'-k'); end
%         Res532(k) = 1; % Positivo

    
%     if Res635(k) == -1, m635=' IgM Baja calidad';end
%     if Res532(k) == -1, m532=' IgG Baja calidad';end
%     if Res635(k) == 0, m635=' IgM negativo';end
%     if Res532(k) == 0, m532=' IgG negativo';end
%     if Res635(k) == 1, m635=' IgM DUDOSO';end
%     if Res532(k) == 1, m532=' IgG DUDOSO';end
%     if Res635(k) == 2, m635=' IgM POSITIVO';end
%     if Res532(k) == 2, m532=' IgG POSTITIVO';end
%     if Res635(k) == 3, m635=' IgM POSITIVO alto';end
%     if Res532(k) == 3, m532=' IgG POSTITIVO alto';end
%     if Res635(k) == 4, m635=' IgM POSITIVO muy alto';end
%     if Res532(k) == 4, m532=' IgG POSITIVO muy alto';end 
%     if Res635(k) == 5, m635=' IgM POSITIVO super alto';end
%     if Res532(k) == 5, m532=' IgG POSTITIVO super alto';end 
%     
%     
%     textRes = sprintf('%s,%s,%s,%s,%s \r',num2str(chipNum),num2str(k),...
%         m635,m532,num2str(rIgmIgg));
%    %textRes = sprintf('%s,%s,%s,%s,%s,%s \r',num2str(chipNum),num2str(k),...
%    %     num2str(INTAnum(k),m635,m532,num2str(rIgmIgg));
%     fprintf(fidRes,'%s',textRes);    
     
%     if  and( and ( or(blockP532(17) >= minPos,blockP532(18) >= minPos),...
%             or(blockP532(11)>= minPos,blockP532(12)>= minPos)),...
%             or(blockP532(10)>= minPos,blockP532(9)>= minPos )),
 
%     if  and ( or(blockP532(17) >= minPos,blockP532(18) >= minPos),...
%             or(blockP532(11)>= minPos,blockP532(12)>= minPos)),
%     subplot('Position',pos532); plot([k k],[0 18],'-k')
%     Res532(k) = 1;
%     end
    
    blockP635(find(blockP635 <= 0)) = 0; % valores negativos puestos a 0
    blockP532(find(blockP532 <= 0)) = 0; % valores negativos puestos a 0
    
     
    
    if noBloq==0, 
        BloqProt = [BloqProt; [chipNum k  blockP635' blockP532']];
        BloqProtAcumTotal = [BloqProtAcumTotal; [chipNum k  blockP635Total blockP532Total]];
    end
    blockT635 = [ blockT635 blockP635];
    blockT532 = [ blockT532 blockP532];

    if Res635(k) >= 2,
         if noBloqIgMPos == 0; BloqIgMPos = [BloqIgMPos; [chipNum k  blockP635']];end
    end
    if Res532(k) >= 1,
         if noBloqIgGPos == 0, BloqIgGPos = [BloqIgGPos; [chipNum k  blockP532']];end
    end
    
end  
     
fclose(fidRes) 
 
%if noResChips == 0, Resultados = [Resultados ;[chipNum Res635 Res532]];end

%if noResChips == 0, xlswrite('Resultados_chips.xlsx',Resultados);end
if noBloq == 0, xlswrite('BloqProtAcum.xlsx',BloqProt);end
if noBloq == 0, xlswrite('BloqProtAcumTotal.xlsx',BloqProtAcumTotal);end
if noBloqIgMPos == 0, xlswrite('BloqIgMPos.xlsx',BloqIgMPos);end
if noBloqIgGPos == 0, xlswrite('BloqIgGPos.xlsx',BloqIgGPos);end


if noPlot == 0,
save(sprintf('Chip_data/Chip%s',num2str(chipNum)),'blockT635','blockT532');

   %orden_plot = [1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0,9];  
   % nom_rev = [ {'N5Nt'};{'N6Ct'};{'NC1'};{'NC2'};{'NP2'}; {'P'};{'S'};{'RBD2'};{'S1'}];
  %nom_rev = [{'*S1'};{'RBD2'};{'S'};{'*P'};{'NP2'};{'*NC2'};{'NC1'};{'N6Ct'};{'N5Nt'}];
  %orden_plot = [4,0,5,0,6,0,3,0,7,0,2,0,8,0,9,0,1];
 nom_rev = [{'*S1'};{'*P'};{'*NC2'};{'N5Nt'};{'N6Ct'};{'NC1'};{'NP2'};...
      {'S'};{'RBD2'}];
  
  
    subplot('Position',pos635)
    set(gca,'YTick',[1:1:numBloques])
    set(gca,'Ylim',[0 numBloques+1])
    title('IgM','fontsize',10);
    %xlabel('Protein')
    ylabel('Block')
    set(gca,'XTick',[1:size(id1,1)/2])

    set(gca,'XTickLabel',nom_rev)

    
%     set ( gca, 'xdir', 'reverse' )
%     set ( gca, 'ydir', 'reverse' )
    
    oldticksX = get(gca,'xtick');
    oldticklabels = cellstr(get(gca,'xtickLabel'));
    set(gca,'xticklabel',[])
    tmp = text(oldticksX, zeros(size(oldticksX))-0.5, oldticklabels,...
        'rotation',45,'horizontalalignment','right','fontsize',8);
    
    set(gca,'FontSize',10)
    set(gca,'XGrid','off')
    set(gca,'YGrid','off')

    text(1,-2,'Red line IgM/IgG > 1 ','fontsize',8)
    text(1,-2.5,'Balck line positive detection ','fontsize',8)

    
    
    subplot('Position',pos532)
    title('IgG','fontsize',10);
    %set(gca,'YTick',[1:1:numBloques])
    %xlabel('Protein')   
    set(gca,'YTick',[])
    set(gca,'XTick',[1:size(id1,1)/2])
    set(gca,'XTickLabel',nom_rev)
    set(gca,'Ylim',[0 numBloques+1])     
         
    oldticksX = get(gca,'xtick');
    oldticklabels = cellstr(get(gca,'xtickLabel'));
    set(gca,'xticklabel',[])
    tmp = text(oldticksX, zeros(size(oldticksX))-0.5, oldticklabels,...
        'rotation',45,'horizontalalignment','right','fontsize',8);
    
    set(gca,'XGrid','off')
    set(gca,'YGrid','off')
    
     
    cbh=colorbar;
    set(cbh,'YTick',1:9)
    set(cbh,'YTickLabel', {'0' '100' '300' '800'  '2000' ' '})
   
    %grid on
    %set(gca,'XTick',[1 : size(id1,1) ])
    %set(gca,'XTickLabel',sprintf('%3.4f|',x))
    %set(gca,'XTickLabel','')
    set(get(cbh,'XLabel'),'String','%CN')
    
%     level=[{'-'},{'+/-'},{'+'},{'++'},{'+++'}];
%     pos= [2,5,9,13,16]
%     for i = 1:5
%         %text( i-0.3  , j  ,num2str(matrixRel(j,i)),'FontSize',7,'Color','w');
%         text( 28.5  , pos(i)  ,level(i));
%     end

%      text(1,-1,'Solid line positive detection','fontsize',8)
%      text(10,-1,'Black dashed line ambiguous detection','fontsize',8)
%      text(1,-1.5,'Cyan solid line IgM/IgG > 0.5','fontsize',8)
%      text(10,-1.5,'Red solid line IgM/IgG > 1','fontsize',8)
    text(5,-2,fileName,'fontsize',5)

    set(gcf,'position',[100,50,1200,900])
    %saveas(gcf,sprintf('Bloque_%s',num2str(k)),'png')
    saveas(gcf,fileName,'png')
end
 


