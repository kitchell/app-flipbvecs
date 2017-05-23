function [] = main()
% normalizes the bvals and splits the bvecs

% load config.json
config = loadjson('config.json');

%load bvecs
bvecs = dlmread('dwi.bvecs');

%params
params.x_flip = config.xflip;
params.y_flip = config.yflip;
params.z_flip = config.zflip;

if ~(size(bvecs,1) == 3), bvecs = bvecs'; end

if params.x_flip
    bvecs(1,:) = -bvecs(1,:);
end
if params.y_flip
    bvecs(2,:) = -bvecs(2,:);
end
if params.z_flip
    bvecs(3,:) = -bvecs(3,:);
end

% may not be necessary depending on the data structure?

if params.x_flip && params.y_flip && params.z_flip
    dlmwrite(dwi_x_y_z_flipped.bvecs, bvecs);
elseif params.x_flip && params.y_flip && ~params.z_flip
    dlmwrite(dwi_x_y_flipped.bvecs, bvecs);
elseif params.x_flip && ~params.y_flip && params.z_flip
    dlmwrite(dwi_x_z_flipped.bvecs, bvecs);   
elseif ~params.x_flip && params.y_flip && params.z_flip
    dlmwrite(dwi_y_z_flipped.bvecs, bvecs);
elseif params.x_flip && ~params.y_flip && ~params.z_flip
    dlmwrite(dwi_x_flipped.bvecs, bvecs);
elseif ~params.x_flip && params.y_flip && ~params.z_flip
    dlmwrite(dwi_y_flipped.bvecs, bvecs);
elseif ~params.x_flip && ~params.y_flip && params.z_flip
    dlmwrite(dwi_z_flipped.bvecs, bvecs);
end

