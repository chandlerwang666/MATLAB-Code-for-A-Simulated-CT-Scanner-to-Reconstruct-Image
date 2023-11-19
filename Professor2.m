clear all;
ctscanv4 = readmatrix("data4.txt");

no_of_rot  = ctscanv4(end, 3)+1;
no_of_data = length(ctscanv4)/no_of_rot;


ctdata = reshape( ctscanv4(:,4), no_of_data, no_of_rot);

rangle = 360/(no_of_rot-1);

    
img = zeros( no_of_data, no_of_data);
nimg = img;


figure(1);
clf;
subplot(1,2,1);
imagesc(nimg);
axis image;

drawnow;

for r = 0:(no_of_rot-1)/2
    
    rimg = imrotate( nimg, -rangle, 'bicubic', 'crop');
    
    nimg = rimg + ones(no_of_data,1)*(ctdata(:, r+1)'./no_of_data);
    
    subplot(1,2,1);
    imagesc(imrotate( nimg, (r*rangle), 'crop'));
    title(sprintf('Scan #:%d Angle: %4.1f', r, r*rangle));
    axis image;
    drawnow;
    
    %pause;%(0.001);
end

init_th = min([350 max(max(nimg))]);

figure(1);

subplot(1,2,1);
imagesc(nimg);
axis image;
colorbar;

subplot(1,2,2);
imagesc(nimg>init_th);

axis image;

drawnow;

sld_hd = uicontrol( gcf, 'Style','slider','Position', [670 120 90 300], 'Min',0,'Max',max(max(nimg)), 'SliderStep', [0.01 0.1], 'Value',init_th,'callback', 'th=get(gco,''Value'');subplot(1,2,2);imagesc(nimg>round(th));title(th);drawnow;');

