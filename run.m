clc
clear
close all


dataset_name = 'Indian_Pines';
classifier = 'KNN';
train_ratio = 0.1;

Dataset = get_data(dataset_name);
Dataset.train_ratio = train_ratio;

Hyperdata = load('Indian_Pines-62.mat');
Hyperdata = Hyperdata.X1;
ResSavePath = 'Result/';

IE = Entropy(Dataset.X);

alpha = 1 : 0.2 : 2;
beta = 1 : 0.2 : 2;
bandk = 30;
d = 6; %lower dimension
k = 1; %graph filter


count = 1;
for i=1:length(alpha)
    for j=1:length(beta)
       fprintf('%dth parameter\n',count);
       [S,obj] = RFGEC(Hyperdata, alpha(i), beta(j), d, k);
        y = SpectralClustering(S,bandk);
        for num_IE = 1 : bandk
            cluster_IE = find(y == num_IE);
            [~, Y_IE] = max(IE(cluster_IE));
            I(num_IE) = cluster_IE(Y_IE);
        end         
        [acc, ~] = test_bs_accu(I, Dataset, classifier);
        OA(count) = acc.OA;    
        clear I cluster_IE Y_IE
        count = count+1;
    end

end

OA = max(OA);
resFile = [ResSavePath dataset_name, '-' , classifier '.mat'];
save(resFile, 'OA');



