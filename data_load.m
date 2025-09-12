function alldata = data_load(dataset_name)
    % Data Loading
    if isequal(dataset_name, 'eurlex-4k')
        data = load('Eurlex_4k_original.mat');
        alldata = data.eurlex;
    elseif isequal(dataset_name, 'wiki10k')
        data = load('Wiki_10k_original.mat');
        alldata = data.wiki10;
    elseif isequal(dataset_name, 'Wikilh-325k')
        data = load('WikiLSHTC_325k_original.mat');
        alldata = data.wikiLSHTC;
    elseif isequal(dataset_name, 'Del-200k')
        data = load('Delicious_200k_original.mat');
        alldata = data.delicious;
    elseif isequal(dataset_name, 'amaz67')
        data = load('Amazon670K_original.mat');
        alldata = data.amz67;
    elseif isequal(dataset_name, 'amaz3m')
        data = load('Amazon3M_original.mat');
        alldata = data.amz3M;
    elseif isequal(dataset_name, 'amaz13')
        data = load('AmazonCat-13K_original.mat');
        alldata = data.amaz13;
    elseif isequal(dataset_name, 'wiki500k')
        data = load('WikipediaLarge-500K_original.mat');
        alldata = data.wiki500k;
	    clear data
    else
        error('Unknown dataset name. Please provide a valid dataset name.');
    end
end
