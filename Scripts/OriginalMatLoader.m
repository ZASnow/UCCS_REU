clc

o_cell = struct2cell(o);
data = cell2mat(o_cell(6));

cz = data(:,20);
cz_200hz = downsample(cz,5);
c3 = data(:,5);
c3_200hz = downsample(c3,5);
c4 = data(:,6);
c4_200hz = downsample(c4,5);
t3 = data(:,15);
t3_200hz = downsample(t3,5);
t4 = data(:,16);
t4_200hz = downsample(t4,5);
f3 = data(:,3);
f3_200hz = downsample(f3,5);
fz = data(:,19);
fz_200hz = downsample(fz,5);
f4 = data(:,4);
f4_200hz = downsample(f4,5);

cl = struct('labels', {'cz' 'c3' 'c4' 't3' 't4' 'f3' 'fz' 'f4'});
data = [cz_200hz'; c3_200hz'; c4_200hz'; t3_200hz'; t4_200hz'; f3_200hz'; fz_200hz'; f4_200hz'];
%data = [cz'; c3'; c4'; t3'; t4'; f3'; fz'; f4'];

cd ..
eeglab