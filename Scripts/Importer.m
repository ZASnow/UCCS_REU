clc

filename = 'A_160405_200';

data = importdata(filename);
o_cell = struct2cell(o);
events = cell2mat(o_cell(5));

array_length = length(events);

sentinel = 0;
label = 0;
n1 = 0;
n2 = 0;
n3 = 0;
n4 = 0;
n5 = 0;
for i = 1:array_length
    if sentinel == 0
        label = 0;                          % Initialize label and arrays
        cz_to_be_saved = [];
        c3_to_be_saved = [];
        c4_to_be_saved = [];
    end
    
    if (events(i) > 0 && events(i) < 6)     % 91???? 92???????
        label = events(i);                  % Get the finger being moved
        sentinel = 1;                       % We want to keep appending
        cz_to_be_saved = [cz_to_be_saved; data(i,1)];
        c3_to_be_saved = [c3_to_be_saved; data(i,2)];  % Append data
        c4_to_be_saved = [c4_to_be_saved; data(i,3)];  
    end
    
    if events(i) == 0 && sentinel == 1      % When finger prompt ends
        if length(cz_to_be_saved) < 280     % Only save good sized data
            if label == 1
                n = n1;
                n1 = n1 + 1;
            elseif label == 2
                n = n2;
                n2 = n2 + 1;
            elseif label == 3
                n = n3;
                n3 = n3 + 1;
            elseif label == 4
                n = n4;
                n4 = n4 + 1;
            else
                n = n5;
                n5 = n5 + 1;
            end
            
            filename_cz = "cz_" + label + "_" + n;
            filename_c3 = "c3_" + label + "_" + n;
            filename_c4 = "c4_" + label + "_" + n;
        
            writematrix(cz_to_be_saved, filename_cz)
            writematrix(c3_to_be_saved, filename_c3)
            writematrix(c4_to_be_saved, filename_c4)
        end
        
        sentinel = 0;                       % Reset the sentinel
        
   end
end