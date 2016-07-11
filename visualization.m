
close

subj = {'136524' }; % array of subject names
data_folder = '~/Data/Tara';
save_folder = '~/Data/Tara';

for s=1:length(subj)
    % import the data
    path_t1             = sprintf('%s/%s_t3_FA.nii.gz',data_folder,subj{s});
    path_tract          = sprintf('%s/fdt_paths.nii.gz',data_folder);
    path_tract_thresh   = sprintf('%s/fdt_paths_thresholded.nii',data_folder);
    
    t1 = MRIread(path_t1);
    tract = MRIread(path_tract);
    tract_thresh = MRIread(path_tract_thresh);

    % renders the smoothed brain surface
    hcap = patch(isosurface(t1.vol(:,:,:),.01),...
        'FaceColor',[.9,.9,.9],...
        'EdgeColor','none','FaceAlpha',.1);
        reducepatch(hcap,.2)

    % renders the smoothed tract surface
    hiso1 = patch(isosurface(smooth3(tract.vol),20),...
            'FaceColor',[1,.5,0],...    
            'EdgeColor','none','FaceAlpha',.3);
    reducepatch(hiso1,.2)

    % renders the smoothed thresholded tract surface
    hiso2 = patch(isosurface(smooth3(tract_thresh.vol),50),...
            'FaceColor',[1,0,0],...    
            'EdgeColor','none','FaceAlpha',1);
    reducepatch(hiso2,.2)

    % visual figure parameters
    set(hiso1,'AmbientStrength',.6)
    set(hiso1,'SpecularColorReflectance',0,'SpecularExponent',5)
    set(hiso2,'AmbientStrength',.6)
    set(hiso2,'SpecularColorReflectance',0,'SpecularExponent',5)
    lighting GOURAUD
    lightangle(45,10);
    lightangle(260,-20);
    daspect([1 1 1])
    set(gca,'Visible','off')
%     zoom(1.5)
    axis vis3d
    
    % rotate and save the figures
    saveas(gca,sprintf('%s/%s_top.png',save_folder,subj{s}))
    view(180,0)
    saveas(gca,sprintf('%s/%s_front.png',save_folder,subj{s}))
    view(90,0)
    saveas(gca,sprintf('%s/%s_side.png',save_folder,subj{s}))
    close
end








