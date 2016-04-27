function [debug_mode] = tools( varargin, nargin )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preprocessing software for CTD-LADCP                                     %
% Autor: Pierre Rousselot / Date: 10/03/16                                 %
% Jedi master: Jacques Grelet                                              %
% -> Arguments for ctdSeaProcessing                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialization
debug_mode = false;
mod = [];

if( nargin == 0)
    
    debug_mode = false;

else
    %% Test argument number
    if( nargin < 2)
          msgbox('The program need 2 arguments minimum', 'Error', 'error')
    end

    %% Read argument
    property_argin = varargin(1:end);
    while length(property_argin) >= 2,
    property = property_argin{1};
    value    = property_argin{2};
    property_argin = property_argin(3:end);
        switch lower(property)
            case 'mode'
                mod = value;
            otherwise
                msgbox([property 'argument unknown'], 'Error', 'error')
        end
  
    end

    if strcmp(mod,'debug')
        debug_mode = true;
    else
        msgbox('Unknown mode', 'Error', 'error')
    end
end
    
end

