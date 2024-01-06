clear all
clc
populationSize = 100; % Number of search agents
Max_iteration = 5000;
pop=100;
M=500;
runs = 30;
N=100;
for fn = 1:30
    if fn == 2
        continue;   %To skip function-2 of CEC-BC-2017 because of its unstable behavior
    end
    Function_name=strcat('F',num2str(fn));
    [lb,ub,dim,fobj]=CEC2017(Function_name);
    [c,d,dim,fobj]=CEC2017(Function_name);
    Best_score_T = zeros(1,runs);
    PO_cg_curve2 = zeros(runs,Max_iteration);
    %     Best_pos2 = zeros(1,dim);
   parfor run=1:runs
%         rng('shuffle');
% [Best_score_0 , pBestScore,PO_cg_curve ] =yuanCS(populationSize,Max_iteration,fobj);
% [gBestScore,Best,cg_curve]=HMO(N,Max_iteration,lb,ub,dim,fobj);
%         [Best_score_0,Best_pos,PO_cg_curve] = SSA(populationSize,Max_iteration,lb,ub,dim,fobj);
 [Best_score_0,pBestScore,PO_cg_curve]=CIHHO(populationSize,Max_iteration,lb,ub,dim,fobj);
% [Best_score_0,PO_cg_curve]=MELGWO(populationSize,Max_iteration,lb,ub,dim,fobj);
% [Best_score_0,BestSol,PO_cg_curve,FE]=ABC(populationSize,dim,ub,lb,fobj,Max_iteration);
% [Best_score_0,pBestScore,PO_cg_curve]=MSRCS(populationSize,dim,fobj);
% [Best_score_0, elite, PO_cg_curve, last_generation] = GA(dim,fobj,populationSize,Max_iteration);
gBestScore=Best_score_0-(fn*100);  %
        Best_score_T(1,run) = gBestScore;
        %         display(['Run: ', num2str(run), '         ', 'Fitness: ', num2str(Best_score_0), '     ', 'Position:      ', num2str(Best_pos)]);
        PO_cg_curve2(run,:) = PO_cg_curve;
        %         Best_pos2(run,:) = Best_pos;
    end
    %     Best_pos2;
    %Finding statistics
    Best_score_Best = min(Best_score_T);
    Best_score_Worst = max(Best_score_T);
    Best_score_Median = median(Best_score_T,2);
    Best_Score_Mean = mean(Best_score_T,2);
    Best_Score_std = std(Best_score_T);
    shuzhi(fn,:)=Best_score_T;
    pingjun(fn,:)=mean(PO_cg_curve2);
    %Printing results
    display(['Fn = ', num2str(fn)]);
    display(['Best, Worst, Median, Mean, and Std. are as: ', num2str(Best_score_Best),'   ', ...
        num2str(Best_score_Worst),'  ', num2str(Best_score_Median),'  ', num2str(Best_Score_Mean),'  ', num2str(Best_Score_std)]);
       xlswrite(strcat('D:\我的论文\CEC2017测试数据HHO\50维30次数值\CIHHO_NEW_50_5000.xlsx'),shuzhi);
       xlswrite(strcat('D:\我的论文\CEC2017测试数据HHO\50维平均收敛\CIHHO_NEW_50_5000.xlsx'),pingjun);
end
