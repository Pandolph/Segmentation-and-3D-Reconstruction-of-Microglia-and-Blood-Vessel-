function cell = Cell(Data,area_size,se_size)
cell = Data;
se = strel('disk',se_size);
for i = 1:size(Data,3)
    Data(:,:,i) = imerode(Data(:,:,i),se);
    Data(:,:,i) = imdilate(Data(:,:,i),se);
    cell = bwareaopen(Data,area_size);%��Ŀ��ͼ�������С��area_size�Ĳ���ȥ��
    % �ҵ����С��area_size����ͨ����Ȼ��ɾ������cellѰ�����ĵĹ������� 
end