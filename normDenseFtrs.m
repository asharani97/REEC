function ftrMat = normDenseFtrs(ftrMat) 

numOfSamples = size(ftrMat,1); 

for i = 1:numOfSamples 
        divBy = norm(ftrMat(i,:));
        if( divBy>0 ) 
                ftrMat(i,:) = ftrMat(i,:)/divBy; 
        end;
end; 
