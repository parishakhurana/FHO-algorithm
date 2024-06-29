%% Fire Hawk Optimizer (FHO) source code - version 1.0
% Programmer: Mahdi Azizi, Siamak TalatAhari, Amir H. Gandomi
% E-mail: mehdi.azizi875@gmail.com

%  Main source:
%  Fire Hawk Optimizer: a novel metaheuristic algorithm
%  https://link.springer.com/article/10.1007/s10462-022-10173-w

%% Clear Workspace & Command Window
% clc; clear all;
% 
% % import CEC2017.F7
% 
% %% Problem Information
% selected_function = 'F1';          % @ Cost Function
% [lb,ub,dim,fobj] = CEC2017(selected_function);

function [Best_Pos,GB1,Convergence_curve] = FHO_2best(fobj,lb,ub,dim)
VarNumber = dim;                         % Number of variables;
VarMin = lb *ones(1,VarNumber);        % Lower bound of variable;
VarMax = ub *ones(1,VarNumber);         % Upper bound of variable;



%% General Parameters of the Algorithm
MaxFes = 600 ;                       % Maximum number of generations
nPop = 25 ;                             % Maximum number of initial candidates
HN = randi([1 ceil(nPop/5)],1,1) ;      % Maximum number of FireHawks

% Counters
Iter=0;
FEs=0;

%% Initialization
Pop=[]; Cost=[];
for i=1:nPop
    % Initialize Positions
    Pop(i,:)=unifrnd(VarMin,VarMax,[1 VarNumber]);
    % Cost Function Evaluations
    Cost(i,1)=fobj(Pop(i,:));
    FEs=FEs+1;
end

% Sort Population
[Cost, SortOrder]=sort(Cost);
Pop=Pop(SortOrder,:);
BestPop1 = Pop(1,:);
BestPop2 = Pop(2,:);

% Fire Hawks
FHPops=Pop(1:HN,:);

% Prey
Pop2=Pop(HN+1:end,:);
SP=mean(Pop2);

% Distance between  Fire Hawks and Prey
for i=1:HN
    nPop2=size(Pop2,1);
    if nPop2<HN
        break
    end
    Dist=[];
    for q=1:nPop2
        Dist(q,1)=distance(FHPops(i,:), Pop2(q,:));
    end
    [ ~, b]=sort(Dist);
    alfa=randi(nPop2);
    PopNew{i,:}=Pop2(b(1:alfa),:);
    Pop2(b(1:alfa),:)=[];
    if isempty(Pop2)==1
        break
    end
end
if isempty(Pop2)==0
    PopNew{end,:}=[PopNew{end,:} ;Pop2];
end

% Update Bests
GB1 = Cost(1);
GB2 = Cost(2);

%% Main Loop
while FEs<MaxFes
    Iter=Iter+1;
    PopTot=[];
    Cost=[];
    for i=1:size(PopNew,1)
        PR=cell2mat(PopNew(i));
        FHl=FHPops(i,:);
        SPl=mean(PR);
        
        Ir=unifrnd(0,1,1,3);
        FHnear=FHPops(randi(HN),:);
        FHl_new=FHl+(Ir(1)*GB1 + Ir(2)*GB2 -Ir(2)*FHnear);
        FHl_new = max(FHl_new,VarMin);
        FHl_new = min(FHl_new,VarMax);
        PopTot=[PopTot ;FHl_new];
        
        for q=1:size(PR,1)
            Ir=unifrnd(0,1,1,2);
            PRq_new1=PR(q,:)+((Ir(1)*FHl-Ir(2)*SPl));
            PRq_new1 = max(PRq_new1,VarMin);
            PRq_new1 = min(PRq_new1,VarMax);
            PopTot=[PopTot ;PRq_new1];
            
            Ir=unifrnd(0,1,1,2);
            FHAlter=FHPops(randi(HN),:);
            PRq_new2=PR(q,:)+((Ir(1)*FHAlter-Ir(2)*SP));
            PRq_new2 = max(PRq_new2,VarMin);
            PRq_new2 = min(PRq_new2,VarMax);
            PopTot=[PopTot ;PRq_new2];
        end
    end
    for i=1:size(PopTot,1)
        Cost(i,1)=fobj(PopTot(i,:));
        FEs=FEs+1;
    end
    % Sort Population
    [Cost, SortOrder]=sort(Cost);
    PopTot=PopTot(SortOrder,:);
    Pop=PopTot(1:nPop,:);
    HN = randi([1 ceil(nPop/5)],1,1);
    BestPop=Pop(1,:);
    FHPops=Pop(1:HN,:);
    Pop2=Pop(HN+1:end,:);
    SP=mean(Pop2);
    clear PopNew
    
    % Distance between  Fire Hawks and Prey
    for i=1:HN
        nPop2=size(Pop2,1);
        if nPop2<HN
            break
        end
        Dist=[];
        for q=1:nPop2
            Dist(q,1)=distance(FHPops(i,:), Pop2(q,:));
        end
        [ ~, b]=sort(Dist);
        alfa=randi(nPop2);
        PopNew{i,:}=Pop2(b(1:alfa),:);
        Pop2(b(1:alfa),:)=[];
        if isempty(Pop2)==1
            break
        end
    end
    if isempty(Pop2)==0
        PopNew{end,:}=[PopNew{end,:} ;Pop2];
    end
    
    GB1=min(GB1,Cost(1));
    GB2=min(GB2,Cost(2));
    % Store Best Cost Ever Found
    BestCosts(Iter,1)=GB1;
    Convergence_curve(Iter)=GB1;
    % Show Iteration Information
end
Conv_History=BestCosts;
Best_Pos=BestPop;
end


%% Calculate the Euclidean Distance
function o = distance(a,b)
for i=1:size(a,1)
    o(1,i)=sqrt((a(i)-b(i))^2);
end
end