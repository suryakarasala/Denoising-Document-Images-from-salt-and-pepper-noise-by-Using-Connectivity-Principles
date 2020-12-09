close all;
clear all;

histo = 0;
conn_pixel = 0;
img_denoise = 1;


%% Build Histogram 

if histo == 1
    disp('Building histogram');
    I = imread('5.jpg');
    histogram(I, 256, 0, 255);
    clear I;
    disp('---------------------------------');
end

%% shells

if 0
    disp('shells creating');

   

    img = imread('5.jpg');
    d=imnoise(I,'salt & pepper',0.05);
    img = Thresh(d,100,255);
    [width,height] = size(img);
    scale = 0.3;
    img = imresize(img,scale,'cubic');
    figure; imagesc(img);
    uiwait(msgbox('Click on starting seed point'));
    [xc,yc] = ginput(1);
    close;
    xc = round(xc); yc = round(yc);
    
    call = 0;
    img = shells(xc,yc,2,1,img,8);
    img = imresize(img,[width height],'cubic');
    figure; imshow(img,[]); colorbar;
    title(sprintf('shells. old label = %d, new label = %d',1,2));
    clear img; 
    disp('---------------------------------');
end
    
%% Connected component analysis
if conn_pixel == 1,
    disp('Connected component analysis');

    I = imread('5.jpg');
    d=imnoise(I,'salt & pepper',0.05);
    if size(I,3) > 1,
        I1 = rgb2gray(d);
    end
    minm = 0; maxm = 40;
    I2 = Thresh(I1,minm,maxm);
    [width,height] = size(I2);
    img = zeros(size(I2));
    [img,N] = ConnectedPixel(I2,2,8);
    imagesc(img); title(sprintf('%d Connected pixels.  Threshold: [%d-%d]',N,minm,maxm));
    fprintf('%d connected components found.\n\n',N);
    
    clear I; clear img; clear N; clear L;
end

%% image denoising
if img_denoise == 1,
    disp('image denoising'); 
    
    I = imread('5.jpg');
    d=imnoise(I,'salt & pepper',0.03);
    if size(I,3) > 1,
        I1 = rgb2gray(d);
    end

    I2 = double(1-Thresh(I1,0,100));
    [img,N,L] = ConnectedPixel(I2,2);
    fprintf('%d connected components found\n\n',N);
    figure; subplot(141); imagesc(img); title('connected components');
    thresh = 200;
    for i=1:N
        if L(i) < thresh,
            ind = img == i;
            img(ind) = 0;
        end
    end
    img1=medfilt2(img);
    
    
     subplot(142); imagesc(img); title('noised image');
     
    subplot(143); imagesc(img1); title('Denoised image');
    img2=medfilt2(I1);
    subplot(144); imagesc(img2); title('Denoised image');
    disp('---------------------------------');
    
end

