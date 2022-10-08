function [inputRaster,R,info] = readTiff(inputRasterPath,rows,cols)
% readTiff 基于给定的行列号范围读取遥感影像
% inputRasterPath: 输入的遥感影像名称；
% rows：需要读取的遥感影像行号范围，如[1,100],读取第1到第100行；
% cols：需要读取的遥感影像行号范围，如[1,100],读取第1到第100列；
% 示例：inputRasterPath = ',/test.tif';
%           rows = [100,1000];
%           cols = [100,1000];
%           [raster,R,info]=readTiff(inputRasterPath,rows,cols);
 
% 获取原始遥感数据投影等信息
info = geotiffinfo(inputRasterPath);
% 判断给定的行列号上下限是否超出影像实际范围
if rows(1)>info.Height
     rows = [1,info.Height];
     disp('行号超出范围，读取原始影像全部行');
elseif rows(2)>info.Height
    rows = [rows(1),info.Height];
end
 
if cols(1)>info.Width  
    cols = [1,info.Width];
    disp('列号超出范围，读取原始影像全部列');
elseif cols(2)>info.Width
    cols = [cols(1),info.Width];
end
% 基于imread函数的读取指定范围的遥感影像
inputRaster = imread(inputRasterPath,'PixelRegion',{rows,cols});
R = info.SpatialRef;
% 判断原始影像是地理坐标还是投影坐标，matlab中地理坐标和投影坐标相关属性名有所不同
if contains(class(R),'Geo')  
    cellSize = R.CellExtentInLongitude;
    R.LatitudeLimits= [R.LatitudeLimits(2)-(rows(2)-1)*cellSize,R.LatitudeLimits(2)-(rows(1)-1)*cellSize]; 
    R.LongitudeLimits= [R.LongitudeLimits(1)+(cols(1)-1)*cellSize,R.LongitudeLimits(1)+(cols(2)-1)*cellSize]; 
else
    
    cellSize = R.CellExtentInWorldX;
    R.YWorldLimits= [R.YWorldLimits(2)-(rows(2))*cellSize,R.YWorldLimits(2)-(rows(1)-1)*cellSize]; 
    R.XWorldLimits= [R.XWorldLimits(1)+(cols(1)-1)*cellSize,R.XWorldLimits(1)+(cols(2))*cellSize]; 
end
R.RasterSize = [size(inputRaster,1),size(inputRaster,2)];
end