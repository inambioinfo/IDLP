function [AUCn,avgROC] = AUC_main( phenotype_gene_matrix_groundTruth,phenotype_gene_matrix_prediction)
%R �� row_phenotype, column_gene
phenotype_gene_matrix_prediction(isnan(phenotype_gene_matrix_prediction)) = -1;
[rows, cols] = size(phenotype_gene_matrix_groundTruth);

AUCn = zeros(rows, 7);

[B, IX] = sort(phenotype_gene_matrix_prediction, 2, 'descend');%B�洢������������IX�洢����������,2:��������
clear R;
clear B;

topn = zeros(rows, cols);
for j = 1 : rows     %j: iterate phenotype 
    for k = 1 : cols%���ǰѰ�˳���ŵ�һ����Ԥ��Ե���һ����ǰ��һԽ��Խ��
        real_col = IX(j, k);
        if phenotype_gene_matrix_groundTruth(j, real_col) > 0
            topn(j, k) = 1;%
        else
            topn(j, k) = 0;
        end
    end

    AUCn(j,1) = AUC(topn(j,:), 20);
    AUCn(j,2) = AUC(topn(j,:), 50);
    AUCn(j,3) = AUC(topn(j,:), 100);
    AUCn(j,4) = AUC(topn(j,:), 300);
    AUCn(j,5) = AUC(topn(j,:), 500);
    AUCn(j,6) = AUC(topn(j,:), 1000);
    AUCn(j,7) = AUC(topn(j,:), cols);
end
%filtering out phenotypes that donot interact with any genes in new added
%gene-phenotype matrix;
avgROC = mean(AUCn(sum(AUCn,2)>0,:));

end
