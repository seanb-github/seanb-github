library(pheatmap) ## for heatmap generation
library(tidyverse) ## for data wrangling
library(ggplotify) ## to convert pheatmap to ggplot2
library(heatmaply) ## for constructing interactive heatmap

rownames(shap_s2) <- shap_s2[,1]

shap_s2 <- shap_s2[,-1]

shap_s2 <- t(shap_s2)

rownames(shap_s2) <- c('Age', 'GCS', 'GCS Motor', 'Imaging PCA 1', 'Cause = Fall', 'Imaging PCA 3',
                       'Imaging PCA 2', 'Imaging PCA 4', 'Cause = Traffic', 'Major Extracranial Injury',
                       'Cause = Other', 'Cause = Violence', 'Pupils', 'Hypotension', 'Hypoxia')

#

saveRDS(shap_s2, file="shap_s2_v2.rds")

#

shap_s2 <- readRDS("shap_s2_v2.rds")

shap_s2 <- prop.table(shap_s2, margin = 1)

#

shap_s1 <- readRDS("shap_s1.rds")

rownames(shap_s1) <- c('AC-Gow-Sil', 'KM-Gow-Sil', 'SC-Gow-Sil','AC-Eucl-Sil', 'KM-Eucl-Sil', 'SC-Eucl-Sil',
                       'AC-Gow-Gap', 'KM-Gow-Gap', 'SC-Gow-Gap', 'AC-Eucl-Gap', 'KM-Eucl-Gap', 'SC-Eucl-Gap')

shap_s1 <- prop.table(shap_s1, margin = 1)

colnames(shap_s1) <- c('Imaging PCA 4', 'Imaging PCA 3', 'Imaging PCA 2', 'Age', 'Imaging PCA 1',
                       'Major Extacranial Injury', 'GCS', 'Hypotension', 'GCS Motor', 'Cause = Violence',
                       'Cause = Traffic', 'Pupils', 'Cause = Fall',  'Hypoxia', 'Cause = Other')
pheatmap(shap_s1,
         clustering_method = "complete",
         col = colorRampPalette(c("white", "grey50", "black"))(100),
         clustering_distance_rows = "manhattan",
         clustering_distance_columns = "correlation",
         scale = "none",
         main = "",
         annotation_col = NULL,
         angle_col=45,
         legend=FALSE)

#

pheatmap(shap_s2,
         clustering_method = "complete",
         col = colorRampPalette(c("white", "grey50", "black"))(100),
         clustering_distance_rows = "manhattan",
         scale = "none",
         distfun = "correlation",
         main = "",
         annotation_col = NULL,
         angle_col=45,
         legend=FALSE)
