function [number] = save_images(I128, nf128, channel_folder, class_label, index, number, filename)
% Save images appropriately
    newer_filename_128 = [nf128 channel_folder '\' class_label filename '_' sprintf('%d', index) '_' sprintf('%d',number) '_' channel_folder '.jpg'];
    imwrite(I128, newer_filename_128);
    number = number + 1;
end

