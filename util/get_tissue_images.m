function [tissues, tissuetype, T2] = get_tissue_images()
% Author: Zimu Huo
% Date: 2024-01-02
    tissuetype = {'graymatter', 'deep_graymatter', 'whitematter', 'csf'};
    T2 = [110, 100, 60, 1500];
    T2s = [40, 45, 50, 1000];
    mat = load('tissue_images.mat');
    tissues = squeeze(mat.tissue_images);
end
