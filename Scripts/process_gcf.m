function [number] = process_gcf(gcf, nf128, channel_folder, class_label, index, number, filename)
    saveas(gcf, [filename 'temp.jpg'])
    im = imread([filename 'temp.jpg']);
    [I128] = crop(im);
    delete([filename 'temp.jpg'])
    number = save_images(I128, nf128, channel_folder, class_label, index, number, filename);
end

