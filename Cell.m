function cell = Cell(Data,area_size)
tic
cell = Data;
se = strel('disk',2);
for i = 1:size(Data,3)
    Data(:,:,i) = imerode(Data(:,:,i),se);   
    Data(:,:,i) = imdilate(Data(:,:,i),se);
    cell = bwareaopen(Data,area_size);%��Ŀ��ͼ�������С��area_size�Ĳ���ȥ��
end
toc