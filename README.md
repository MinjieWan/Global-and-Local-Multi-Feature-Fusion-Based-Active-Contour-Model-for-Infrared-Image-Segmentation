# Global and Local Multi-Feature Fusion-Based Active Contour Model for Infrared Image Segmentation
This repository contains the codes for paper "Global and local multi-feature fusion-based active contour model for infrared image segmentation" by Minjie Wan*, Qinyan Huang, Yunkai Xu, et al. (*Corresponding author). 

## Abstract
Infrared (IR) image segmentation technology plays a pivotal role in many urgent fields, such as traffic surveillance, nondestructive detection and autonomous driving. In recent years, active contour model (ACM) has been one of the most commonly used tools for image segmentation, but the precision sharply decreases when dealing with IR images with intensity inhomogeneity. To solve this problem, a new ACM based on global and local multi-feature fusion (GLMF) is proposed in this paper. First of all, the multi-feature fitting maps inside and outside the contour are calculated using the strategy of global and local information fusion. Then, a hybrid signed pressure function (SPF) is designed by combining multiple fitting error maps, which are measured by the similarity between the multi-feature fitting map and the original feature map. Next, a level set formulation (LSF) is constructed using the proposed hybrid SPF and the level set function is thus evolved. Finally, the contour of IR foreground object with visual saliency can be extracted using the zero level set of the converged level set function. Both qualitative and quantitative experiments based on IR datasets verify that the presented ACM has remarkable advantages in terms of accuracy and robustness when compared with other typical ACMs.

![Fig_2](https://github.com/user-attachments/assets/c4ebbd8d-4bdb-4352-8cde-28b8e80f9487)

Part of the contour evolution results are presented below: 
![绘图1](https://github.com/user-attachments/assets/e25324f8-f263-4918-b76c-059d4eceda77)


## Requirements
- Matlab 2017a

## Usage
- Download all the files included in this repository.
- Run main.m to test the performance.

## Citation
If you use our code and dataset for research, please cite our paper:

Wan M, Huang Q, Xu Y, et al. Global and local multi-feature fusion-based active contour model for infrared image segmentation[J]. Displays, 2023, 78: 102452.
