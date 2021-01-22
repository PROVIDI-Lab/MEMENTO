function data = ISBI_LoadSubchallenge1Description(protocol_description_file,acquisition_description_file)
    % Read protocol description file
    fields = {};
    if(exist(protocol_description_file,'file') < 1)
        error(['File ' protocol_description_file ' not found']);
    end
    fin = fopen(protocol_description_file,'rt');
    while(~feof(fin))
        line = fgetl(fin);
        % if the first character is a number this is an entry
        line = strtrim(line);
        fc = str2double(line(1));
        if(fc >= 0 && fc <= 9)
            parts = strsplit(line,'-');
            fields{end+1} = {str2double(parts{1}),parts{2},parts{3}};
        end
    end
    fclose(fin);
    
    % read the acquisition description file
    if(exist(acquisition_description_file,'file') < 1)
        error(['File ' acquisition_description_file ' not found']);
    end
    
    nfields = length(fields);
    for field_id = 1:length(fields)
       eval(['data.' fields{field_id}{2} ' = [];']); 
    end
    
    fin = fopen(acquisition_description_file,'rt');
    while(~feof(fin))
        line = fgetl(fin);
        parts = strsplit(line);
        gparts = true(length(parts),1);
        for part_id=1:length(parts)
            if(isempty(parts{part_id}))
                gparts(part_id) = false;
            end
        end
        parts(~gparts) = [];
        if(length(parts) ~= nfields)
            error('The number of entries in the protocol description and in the acquistion file do not match');
        end
        for field_id=1:length(fields)
            eval(['data.' strtrim(fields{field_id}{2}) '(end+1) = ' (parts{field_id}) ';']);
        end
    end
    fclose(fin);
    
    for field_id=1:length(fields)
       eval(['data.' strtrim(fields{field_id}{2}) ' = ascolumn(' 'data.' strtrim(fields{field_id}{2}) ');']);
    end    
end

function S = ascolumn(S)
    if(size(S,2) > size(S,1))
        S = S';
    end
end