% MATLAB script to read matrices from .txt file
function [data_ids] = read_matrices(file1,npts)
    data = load(file1, '-ascii');
    data_ids = data(1:npts,:);

end
