
block_size=8;
image=imread('image1.bmp');
image_red=image(:,:,1);
image_green=image(:,:,2);
image_blue=image(:,:,3);
imwrite(image_red,'red_image.bmp');
imwrite(image_green,'green_image.bmp');
imwrite(image_blue,'blue_image.bmp');
 figure
imshow(image_red);
title("IMAGE RED");
 figure
imshow(image_green);
title("IMAGE GREEN");
 figure
imshow(image_blue);
title("IMAGE BLUE");
m=1;
while m<=4
%comperession
for i=0:(size(image,2)/block_size)-1
for j=0:(size(image,1)/block_size)-1
block_r=image_red(((j*block_size)+1):(j+1)*block_size,((i*block_size)+1):(i+1)*block_size);
DCT_R((j*m)+1:(j+1)*m,(i*m)+1:(i+1)*m)=compression(block_r,m);
block_g=image_green(((j*block_size)+1):(j+1)*block_size,((i*block_size)+1):(i+1)*block_size);
DCT_G((j*m)+1:(j+1)*m,(i*m)+1:(i+1)*m)=compression(block_g,m);
block_b=image_blue(((j*block_size)+1):(j+1)*block_size,((i*block_size)+1):(i+1)*block_size);
DCT_B((j*m)+1:(j+1)*m,(i*m)+1:(i+1)*m)=compression(block_b,m);
end;
end;
%decompression
for i=0:(size(DCT_B,2)/m)-1
    for j=0:(size(DCT_B,1)/m)-1
        block_r=DCT_R(((j*m)+1):(j+1)*m,((i*m)+1):(i+1)*m);
        decompressed_r(((j*block_size)+1):(j+1)*block_size,((i*block_size)+1):(i+1)*block_size)=idct2(block_r,[block_size,block_size]);
        block_g=DCT_G(((j*m)+1):(j+1)*m,((i*m)+1):(i+1)*m);
        decompressed_g(((j*block_size)+1):(j+1)*block_size,((i*block_size)+1):(i+1)*block_size)=idct2(block_g,[block_size,block_size]);
        block_b=DCT_B(((j*m)+1):(j+1)*m,((i*m)+1):(i+1)*m);
        decompressed_b(((j*block_size)+1):(j+1)*block_size,((i*block_size)+1):(i+1)*block_size)=idct2(block_b,[block_size,block_size]);
    end;
end;

compressed_image=cat(3,DCT_R,DCT_G,DCT_B);
decompressed_image=cat(3,decompressed_r,decompressed_g,decompressed_b);
if m==1
    compressed_image_1=uint8(compressed_image);
    decompressed_image_1=uint8(decompressed_image);
    figure
    imshow(decompressed_image_1);
    title("decompressed image at m=1");
    imwrite(decompressed_image_1,'decompressed_image_1.bmp');
    psnr_value_1=psnr(decompressed_image_1,image);
    psnr_value_1=psnr(decompressed_image_1,image,255)
end
if m==2
    compressed_image_2=uint8(compressed_image);
    decompressed_image_2=uint8(decompressed_image);
    figure
    imshow(decompressed_image_2);
    title("decompressed image at m=2");
    imwrite(decompressed_image_2,'decompressed_image_2.bmp');
    psnr_value_2=psnr(decompressed_image_2,image);
    psnr_value_2=psnr(decompressed_image_2,image,255)
end
if m==3
    compressed_image_3=uint8(compressed_image);
    decompressed_image_3=uint8(decompressed_image);
    figure
    imshow(decompressed_image_3);
    title("decompressed image at m=3");
    imwrite(decompressed_image_3,'decompressed_image_3.bmp');
    psnr_value_3=psnr(decompressed_image_3,image);
    psnr_value_3=psnr(decompressed_image_3,image,255)
end
if m==4
    compressed_image_4=uint8(compressed_image);
    decompressed_image_4=uint8(decompressed_image);
    figure
    imshow(decompressed_image_4);
    title("decompressed image at m=4");
    imwrite(decompressed_image_4,'decompressed_image_4.bmp');
    psnr_value_4=psnr(decompressed_image_4,image);
    psnr_value_4=psnr(decompressed_image_4,image,255)
end
m=m+1;
end
figure
plot([1 2 3 4],[ psnr_value_1  psnr_value_2  psnr_value_3  psnr_value_4]);
title("PSNR Graph");
ylabel("PSNR Values");
xlabel("m Values" );
clear;
%description of function compression 
function [ component ] = compression( block,m )
component=dct2(block);
component=component(1:m,1:m);
end