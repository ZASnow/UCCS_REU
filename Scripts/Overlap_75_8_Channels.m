clear
clc

for loop_index = 1:19
    % Load data
    switch loop_index
        case 1
            filename = 'A_160405_200HZ';
        case 2
            filename = 'A_160408_1000HZ';
        case 3
            filename = 'B_151110_200HZ';
        case 4
            filename = 'B_160309_1000HZ';
        case 5
            filename = 'B_160311_1000HZ';
        case 6
            filename = 'B_160316_200HZ';
        case 7
            filename = 'C_151204_200HZ';
        case 8
            filename = 'C_160429_1000HZ';
        case 9
            filename = 'E_160321_1000HZ';
        case 10
            filename = 'E_160415_1000HZ';
        case 11
            filename = 'E_160429_1000HZ';
        case 12
            filename = 'F_151027_200HZ';
        case 13
            filename = 'F_160209_200HZ';
        case 14
            filename = 'F_160210_1000HZ';
        case 15
            filename = 'G_160413_1000HZ';
        case 16
            filename = 'G_160428_1000HZ';
        case 17
            filename = 'H_160804_1000HZ';
        case 18
            filename = 'I_160719_1000HZ';
        case 19         
            filename = 'I_160723_1000HZ';
    end
    
    labels_filename = strcat(filename, '_Labels');
    data = load(filename);
    data = struct2cell(data);
    data = cell2mat(data);

    labels = load(labels_filename);
    labels = struct2cell(labels);
    labels = cell2mat(labels);

    % Extract individual channels
    cz_data = data(1,:,:);
    c3_data = data(2,:,:);          
    c4_data = data(3,:,:);
    t3_data = data(4,:,:);
    t4_data = data(5,:,:);
    f3_data = data(6,:,:);
    fz_data = data(7,:,:);
    f4_data = data(8,:,:);

    [~, ~, num_epochs] = size(data); % Get length of data set (this varies!)

    folder = "Images";
    % Here's the fun part
    nf128 = sprintf('Images\\75\\Images_Cropped_128\\%s\\', filename);
    for index = 1:num_epochs           % Iterate over number of epochs in data
        % Conditional for saving files into the correct folder
        if labels(index) == 1
            class_label = '1\';
        elseif labels(index) == 2
            class_label = '2\';
        elseif labels(index) == 3
            class_label = '3\';
        elseif labels(index) == 4
            class_label = '4\';
        else  
            class_label = '5\';
        end
        
        for j = 1:8
            % Here's where we do overlapping
            switch j
                case 1
                    data = cz_data;
                    channel_folder = 'cz';
                case 2
                    data = c3_data;
                    channel_folder = 'c3';
                case 3
                    data = c4_data;
                    channel_folder = 'c4';
                case 4
                    data = t3_data;
                    channel_folder = 't3';
                case 5
                    data = t4_data;
                    channel_folder = 't4';
                case 6
                    data = f3_data;
                    channel_folder = 'f3';
                case 7
                    data = fz_data;
                    channel_folder = 'fz';
                case 8
                    data = f4_data;
                    channel_folder = 'f4';
            end
            number = 0;
            
            for i = 0:6
                stft(data(1,(i*25+1):(i*25+100),index),100,'Window',kaiser(30,5),...
                    'OverlapLength',29,'FFTLength',60)
                number = process_gcf(gcf, nf128, channel_folder, class_label, index, number, filename);
            end
        end
        fprintf('Finished processing and cropping %s %d\n', filename, index)
        close all
        close all hidden
    end
end