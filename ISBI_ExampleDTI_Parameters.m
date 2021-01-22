function [MD, FA] = ISBI_ExampleDTI_Parameters(DTI_fit)
% extracts the MD and FA values from the fitted DT
MD = zeros(size(DTI_fit,1),1);
FA = zeros(size(DTI_fit,1),1);
for num_voxel = 1:size(DTI_fit,1)
  dt = [DTI_fit(num_voxel,1) DTI_fit(num_voxel,2) DTI_fit(num_voxel,3);  ...
        DTI_fit(num_voxel,2) DTI_fit(num_voxel,4) DTI_fit(num_voxel,5);  ... 
        DTI_fit(num_voxel,3) DTI_fit(num_voxel,5) DTI_fit(num_voxel,6)];
    
 
  
  [evec, eval] = eig(dt);
  % try to deal with non-positive definite tensors
  [eigs, ind] = sort(abs([eval(1, 1) eval(2, 2) eval(3, 3)]));
                    
                    
  MD(num_voxel) = (eigs(1)+eigs(2)+eigs(3))/3;

  FA(num_voxel) = sqrt(3/2).*sqrt((eigs(1)-MD(num_voxel)).^2+...
                        (eigs(2)-MD(num_voxel)).^2+(eigs(3)-MD(num_voxel)).^2)./...
                        sqrt(eigs(1).^2+eigs(2).^2+eigs(3).^2);
end

end