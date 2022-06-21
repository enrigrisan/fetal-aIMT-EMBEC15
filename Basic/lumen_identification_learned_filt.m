
function [lumen_mask, accuracy, id_flag] = lumen_identification_learned_filt(I,dims,rots,th_area,th_ecc,show)

I_in = I;
size_in = size(I);

%-- Frame trimming
upper_profile = squeeze(I(60,:)); 

[~, lower_zeros_ind] = find(~[upper_profile(1:fix(length(upper_profile)/2)),ones(1,fix(length(upper_profile)/2))]);
if isempty(lower_zeros_ind)
    lower_zeros_ind = 70; % x_min = 70;
end
lower_trim = [max(lower_zeros_ind)+1,60]; % y_min = 60;

[~, upper_zeros_ind] = find(~[ones(1,fix(length(upper_profile)/2)),upper_profile(fix(length(upper_profile)/2+1):end)]);
if isempty(upper_zeros_ind)
    upper_zeros_ind = 900; % x_max = 900;
end
upper_trim = [min(upper_zeros_ind)-3,floor(0.9*size(I,1))]; % y_max = 0.9*y_width;

mask_trim = zeros(size(I));
mask_trim(lower_trim(2):upper_trim(2),lower_trim(1):upper_trim(1)) = 1;

I(1:60,:) = 0;


%-- Filter loading and image resizing
load learned_filter

K = reshape(gamma_var',[sqrt(size(gamma_var,2)) sqrt(size(gamma_var,2)) size(gamma_var,1)]);

I = imresize(I,2*mean(lumen_width)/size(I,1));

max_dims = zeros(1,length(dims));
[~,ind_max_alpha] = max(alpha_var);
K_ini = squeeze(K(:,:,ind_max_alpha));

%-- Filtering with K_ini at different scales
for j = 1:length(dims)
    I_filt_dims = conv2(imresize(I,[size(I,1)+dims(j) size(I,2)+dims(j)])-0.5,K_ini,'same');
    max_dims(j) = max(max(I_filt_dims(ceil(0.1*size(I_filt_dims,1)):floor(0.9*size(I_filt_dims,1)),...
        ceil(0.1*size(I_filt_dims,2)):floor(0.9*size(I_filt_dims,2)))));
end

[~,ind_max_dims] = max(max_dims);

H = zeros(size(I,1)+dims(ind_max_dims),size(I,2)+dims(ind_max_dims));
I_filt_kers = zeros(size(I,1)+dims(ind_max_dims),size(I,2)+dims(ind_max_dims),size(K,3));


%-- Actual filtering
for i = 1:size(K,3)
    K_s = squeeze(K(:,:,i));
    I_filt_kers(:,:,i) = conv2(imresize(I,[size(I,1)+dims(ind_max_dims) size(I,2)+dims(ind_max_dims)])-0.5,K_s,'same');
    H = H + 2*alpha_var(i)*((I_filt_kers(:,:,i)>theta_var(i))-0.5);
end


% if show
%     figure(3),
%     subplot(1,2,1), imagesc(I), axis image, colormap gray, hold on;
%     contour(imresize(mask_trim,size(I),'nearest'),[0 0],'r');
%     subplot(1,2,2), imagesc(imresize(H,size(I))), axis image, colormap gray;
%     %     subplot(1,2,2), imagesc(imresize(H,size(I))>=graythresh(H)), axis image, colormap gray;
%     linkaxes;
% end

%-- Lumen Identification
H_res_mask = (imresize(H,size_in)>=graythresh(H)).*mask_trim;

cc = bwconncomp(H_res_mask);
stats = regionprops(cc, 'Area','Eccentricity','Centroid');

% [areas, idx] = sort([stats.Area],'descend');
% if areas(1)>=th_area
%     idx(areas<=th_area) = [];
% else
%     idx(2:end) = [];
% end
% [eccentricities, idx2] = sort([stats(idx(1:min([length(idx),4]))).Eccentricity],'descend');
% H_res_mask_sel = ismember(labelmatrix(cc), idx(idx2(1)));
% accuracy = areas(1)-th_area;


areas = [stats.Area];
eccs = [stats.Eccentricity];

valid_areas = areas>=th_area;
valid_eccs = (eccs>th_ecc(1))&(eccs<th_ecc(2));

if sum(valid_areas.*valid_eccs)>0
    [max_area, ind_max_area] = max(areas.*(valid_areas & valid_eccs));
    id_flag = 1;
else
    [max_area, ind_max_area] = max(areas);
    id_flag = 0;
end

lumen_mask = ismember(labelmatrix(cc), ind_max_area);
accuracy = max_area-th_area;


% %-- Identification Accuracy Computation
% w_mean_vals = zeros(1,size(K,3));
% for i = 1:size(K,3)
%     I_filt_kers_aux = I_filt_kers(:,:,i);
%     [~,ind_mean] = find(H_res_mask_sel.*I_filt_kers_aux);
%     w_mean_vals(i) = alpha_var(i)*mean(I_filt_kers_aux(ind_mean));
% end
% 
% id_accuracy = sum(w_mean_vals)/sum(alpha_var);


if show
    figure(4);
    subplot(1,2,1), imagesc(H_res_mask), axis image; colormap gray; hold on;
    for k = 1:size(stats,1)
        plot(stats(k).Centroid(1),stats(k).Centroid(2),'*');
        text(stats(k).Centroid(1),stats(k).Centroid(2),num2str(stats(k).Eccentricity),'Color','r');
    end
    contour(lumen_mask,[0 0],'y');
    contour(mask_trim,[0 0],'r');
    title(['Area above Threshold = ',num2str(accuracy)]);
    hold off;
    
    subplot(1,2,2), imagesc(I_in), axis image, colormap gray, hold on;
    contour(mask_trim,[0 0],'r');
    if id_flag==1
        contour(lumen_mask,[0 0],'y');
    end
end


end