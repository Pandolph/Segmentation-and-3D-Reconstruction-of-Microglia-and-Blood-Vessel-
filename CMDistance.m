function [cmdistance3d,cmdistance2d] = CMDistance(cell, myelin, x, zxis)

% expand and change
h = zxis/x;
squeeze = floor(h)/h;
cell = expand(cell,h);
myelin = expand(myelin,h);

% points
Centroid = CentroidDetec(cell);
thresh = [0.01 0.5];
e = canny(double(myelin), [1 1 0], 'TMethod', 'relMax', 'TValue', thresh, 'SubPixel', true);
temp = e.edge;
[i,j,z]=ind2sub(size(temp),find(temp));
temp2 = [i,j,z];

Centroid = Centroid/squeeze;
temp2 = temp2/squeeze;

%distance 3d
[D,I] = pdist2(temp2,Centroid,'euclidean','Smallest',1);
% figure;hist(D,100)
distancetemp = [D;Centroid(:,3)'];
xlswrite('cmdistance3d.xlsx',distancetemp');
cmdistance3d = mean(distancetemp(:,1));

%distance 2d 

data3 = temp2;
data3(:,3) = round(temp2(:,3));
CentroidData3 = Centroid;
CentroidData3(:,3) = round(Centroid(:,3));
slice = length(CentroidData3(:,3));
distance = ones(slice,2);
for i = 1:slice
    mytemp  = data3(data3(:,3) == CentroidData3(i,3),:);
    [D,I] = pdist2(mytemp,CentroidData3(i,:),'euclidean','Smallest',1);% I is indice position of vessel
    if isempty(D)
        distance(i,1) = 0;
    else
        distance(i,1) = D;
    end
    distance(i,2) = CentroidData3(i,3);
end
cmdistance2d = mean(distance,1);
cmdistance2d = cmdistance2d(1);
%figure;hist(distance);
xlswrite('cmdistance2d.xlsx',distance);
