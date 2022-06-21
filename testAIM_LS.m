%addpath('./Functions')
%addpath('./Functions/Basic')
addpath('./Basic')

load('FetalUS_Video_Example')

px_size = info.PixelSpacing(1);
f_rate = info.CineRate + 1;


n_frames = size(seq,3);
mean_dist_lumen = NaN(1,n_frames);
norm_I = max(max(seq(:,:,1)));

a = repmat(struct('auto',[NaN NaN]),[n_frames 1]);
a_meas = NaN(2,n_frames); %segm_frames; diam;
A = struct('IntUp',a,'IntDn',a,'Meas',a_meas);

% for f = frames(1):frames(2)
for f = 50:50

    I = double(seq(:,:,f))/double(norm_I);

    %-- Lumen Identification
    dims = (-80:10:80);
    rots = 0;
    th_area = 1500;
    th_ecc = [0.92,1]; %0.999

    [lumen_mask_ini,accuracy, id_flag] = lumen_identification_learned_filt(I,dims,rots,th_area,th_ecc,false);

    %-- Lumen Segmentation
    if id_flag==1

        gap = 90;

        stats = regionprops(lumen_mask_ini, 'BoundingBox');
        pos_crop = stats.BoundingBox + [0 -gap 0 2*gap];
        pos_crop(2) = max([pos_crop(2),60]);
        pos_crop(4) = min([pos_crop(4),0.9*size(I,1)-60]);
        pos_crop = round(pos_crop);


        I_crop = I(pos_crop(2)+1:pos_crop(2)+pos_crop(4)-1,pos_crop(1)+1:pos_crop(1)+pos_crop(3)-1);
        lumen_mask_ini_crop = lumen_mask_ini(pos_crop(2)+1:pos_crop(2)+pos_crop(4)-1,pos_crop(1)+1:pos_crop(1)+pos_crop(3)-1);

        iter = 4000;
        rein_step = 20; %20
        dt = 0.02; %0.02
        exit = 0.001;
        beta = 0.05;
        e = 10; %10
        b = 2.5; %2
        n = 20; %20

        I_crop_res = imresize(I_crop,0.5);
        lumen_mask_ini_crop_res = imresize(lumen_mask_ini_crop,0.5);

        I_crop_filt_res = anisotropic_filtering(I_crop_res,40,'dt',0.1,'n',20,'e',1,'show',false);

        phi_lumen_ini = double(bwdist(lumen_mask_ini_crop_res)-bwdist(1-lumen_mask_ini_crop_res)+...
            im2double(lumen_mask_ini_crop_res)-.5);

        phi_lumen_crop_res = LS_edge_based(I_crop_filt_res,phi_lumen_ini,iter,rein_step,dt,exit,beta,e,b,n,false);

        lumen_mask_crop = imresize(phi_lumen_crop_res<=0,size(I_crop));
        phi_lumen_crop = double(bwdist(lumen_mask_crop)-bwdist(1-lumen_mask_crop)+im2double(lumen_mask_crop)-.5);


        %         vis(2,I_crop), hold on;
        %         contour(lumen_mask_ini_crop,[0 0],'w');
        %         contour(phi_lumen_crop,[0 0],'r');
        %         hold off;

        %         %-- EMBC 2015 Image
                figure(4);
                subplot(3,1,1), imagesc(I_crop), axis image, colormap gray, axis off, hold on;
                contour(lumen_mask_ini_crop,[0 0], 'w'); hold off;
                subplot(3,1,2), imagesc(I_crop_filt_res), axis image, colormap gray, axis off;
                subplot(3,1,3), imagesc(I_crop), axis image, colormap gray, axis off, hold on;
                contour(lumen_mask_ini_crop,[0 0], 'w');
                contour(phi_lumen_crop,[0 0], 'y'); hold off;

        side = 20; %3

        lumen_cont = bwmorph(phi_lumen_crop<=0,'remove');
        cc_sides = bwconncomp(lumen_cont(:,1+side:end-side));

        if cc_sides.NumObjects == 2
            [I_up,J_up] = ind2sub(cc_sides.ImageSize,cc_sides.PixelIdxList{1});
            [I_dn,J_dn] = ind2sub(cc_sides.ImageSize,cc_sides.PixelIdxList{2});
            I_up_uncrop = (I_up)+(pos_crop(2)-1);
            J_up_uncrop = (J_up+side+1)+(pos_crop(1)-1);
            I_dn_uncrop = (I_dn)+(pos_crop(2)-1);
            J_dn_uncrop = (J_dn+side+1)+(pos_crop(1)-1);

            A.IntUp(f).auto = [I_up_uncrop, J_up_uncrop];
            A.IntDn(f).auto = [I_dn_uncrop, J_dn_uncrop];
            A.Meas(1,f) = f;

        else
            I_up_uncrop = NaN;
            J_up_uncrop = NaN;
            I_dn_uncrop = NaN;
            J_dn_uncrop = NaN;
        end

        mean_dist_lumen(f) = mean(min(pdist2([I_up_uncrop,J_up_uncrop],[I_dn_uncrop,J_dn_uncrop],'euclidean'),[],1));
        A.Meas(2,f) = px_size*mean_dist_lumen(f);

        phi_lumen_mask = zeros(size(I));
        phi_lumen_mask(pos_crop(2)+1:pos_crop(2)+pos_crop(4)-1,pos_crop(1)+1:pos_crop(1)+pos_crop(3)-1) = phi_lumen_crop<=0;
        phi_lumen = double(bwdist(phi_lumen_mask)-bwdist(1-phi_lumen_mask)+im2double(phi_lumen_mask)-.5);

        vis(3,I), hold on;
        %         contour(phi_lumen,[0 0],'r');
        plot(J_up_uncrop,I_up_uncrop,'--r');
        plot(J_dn_uncrop,I_dn_uncrop,'--r');
        %title(['Frame ',num2str(f),'/',num2str(frames(2)),'. Lumen Diameter in px = ',num2str(mean_dist_lumen(f))]);
        hold off;

    end

    %disp(['Frame ',num2str(f),'/',num2str(frames(2)),' analyzed.']);

    %     pause;

end

