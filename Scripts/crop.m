function [I128] = crop(image)
% Crop images into 32, 64, 128, 256p resolution
    I = imcrop(image, [104,51,603,531]);
    I128 = imresize(I,[128 128]);
end

