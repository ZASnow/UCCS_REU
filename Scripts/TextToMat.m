clc

filename = 'I_160723_1000';
cd ..
cd cleaned_data
cd Text_Files
data = importdata(filename);
o_cell = struct2cell(o);
events = cell2mat(o_cell(5));

% If 1000HZ, downsample to 200
if strcmp(filename(10), '1')
    events = downsample(events, 5);
    disp("DOWNSAMPLING");
end

array_length = length(events);

% This shit is bazonkers
sentinel = 0;
labels = [];
count = 0;
for i = 1:array_length
    if sentinel == 0
        cz_to_be_saved = [];
    end
    if (events(i) > 0 && events(i) < 6)
        sentinel = 1;                       % We want to keep appending
        cz_to_be_saved = [cz_to_be_saved; data(i,1)];
    end
    if events(i) == 0 && sentinel == 1      % When finger prompt ends
        if length(cz_to_be_saved) < 280 && length(cz_to_be_saved) > 254
            count = count + 1;
        end
        sentinel = 0;                       % Reset the sentinel        
   end
end

to_be_saved = zeros(8,255,count);
sentinel = 0;
labels = [count];
count = 0;
for i = 1:array_length
    if sentinel == 0
        label = 0;                          % Initialize label and arrays
        cz_to_be_saved = [];
        c3_to_be_saved = [];
        c4_to_be_saved = [];
        t3_to_be_saved = [];
        t4_to_be_saved = [];
        f3_to_be_saved = [];
        fz_to_be_saved = [];
        f4_to_be_saved = [];
    end

    if (events(i) > 0 && events(i) < 6)     % 91???? 92???????
        label = events(i);                  % Get the finger being moved
        sentinel = 1;                       % We want to keep appending
        cz_to_be_saved = [cz_to_be_saved; data(i,1)];
        c3_to_be_saved = [c3_to_be_saved; data(i,2)];  % Append data
        c4_to_be_saved = [c4_to_be_saved; data(i,3)];  
        t3_to_be_saved = [t3_to_be_saved; data(i,3)]; 
        t4_to_be_saved = [t4_to_be_saved; data(i,3)]; 
        f3_to_be_saved = [f3_to_be_saved; data(i,3)]; 
        fz_to_be_saved = [fz_to_be_saved; data(i,3)]; 
        f4_to_be_saved = [f4_to_be_saved; data(i,3)]; 
    end

    if events(i) == 0 && sentinel == 1      % When finger prompt ends
        if (length(cz_to_be_saved) < 280) && (length(cz_to_be_saved) > 254)    
            cz_to_be_saved = cz_to_be_saved(end-254:end); % Shorten all
            c3_to_be_saved = c3_to_be_saved(end-254:end); % to 255
            c4_to_be_saved = c4_to_be_saved(end-254:end);
            t3_to_be_saved = t3_to_be_saved(end-254:end);
            t4_to_be_saved = t4_to_be_saved(end-254:end);
            f3_to_be_saved = f3_to_be_saved(end-254:end);
            fz_to_be_saved = fz_to_be_saved(end-254:end);
            f4_to_be_saved = f4_to_be_saved(end-254:end);
            count = count + 1;
            temp_2d_array = [cz_to_be_saved'; c3_to_be_saved'; ...
                c4_to_be_saved'; t3_to_be_saved'; t4_to_be_saved'; ...
                f3_to_be_saved'; fz_to_be_saved'; f4_to_be_saved';];
            to_be_saved(:,:,count) = temp_2d_array;
            labels(count) = label;
        end           
        sentinel = 0;                       % Reset the sentinel    
   end
end

% Size Check
[~, label_size] = size(labels);
[~, ~, to_be_saved_size] = size(to_be_saved);
if label_size ~= to_be_saved_size
    disp('OH FUCK');
end

new_filename = strcat(filename, 'HZ.mat');
label_filename = strcat(filename, 'HZ_Labels.mat');
save(new_filename, 'to_be_saved' );
save(label_filename, 'labels');

cd ..
cd ..
cd uncleaned_data
