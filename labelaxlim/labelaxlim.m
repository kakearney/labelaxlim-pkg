function hlbl = labelaxlim(ax, xy, fmt)
%LABELAXLIM Replace ticks with small labels near corners
% 
% hlbl = labelaxlim(ax, xy, fmt)
%
% Replaces tick labels with small text labels in corners of axes.  Call
% again to update values, change coordinate axes, etc.
%
% Input variables:
%   
%   ax: axes handle(s)
%
%   xy:     'x', 'y', or 'xy', indicating which coordinate axes to label
%
%   fmt:    fprintf format specifier used to translate axis limits to a
%           string
%
% Output variables:
%
%   hlbl:   nax x 3 array of handles of origin, x-max, and y-max labels,
%           respectively

% Copyright 2012 Kelly Kearney


if nargin < 3
    fmt = '%g';
end

if ischar(fmt)
    fmt = {fmt fmt};
end

hlbl = zeros(numel(ax), 3);

for iax = 1:numel(ax)
    
    haslabel = isappdata(ax(iax), 'labellim');
    
    lim = get(ax(iax), {'xlim', 'ylim'});
    switch xy
        case 'xy'
            origin = sprintf([fmt{2} ', ' fmt{1}], lim{2}(1), lim{1}(1));
            xmax   = sprintf(fmt{1}, lim{1}(2));
            ymax   = sprintf(fmt{2}, lim{2}(2));
            set(ax(iax), 'xticklabel', '', 'yticklabel', '');
            
        case 'x'
            origin = sprintf(fmt{1}, lim{1}(1));
            xmax   = sprintf(fmt{1}, lim{1}(2));
            ymax   = '';
            set(ax(iax), 'xticklabel', '', 'yticklabelmode', 'auto');
            
        case 'y'
            origin = sprintf(fmt{2}, lim{2}(1));
            xmax   = '';
            ymax   = sprintf(fmt{2}, lim{2}(2));
            set(ax(iax), 'yticklabel', '', 'xticklabelmode', 'auto');
            
        otherwise
            error('Invalid x/y axis indicator');
        
    end
    
    if haslabel
        hlbl(iax,:) = getappdata(ax(iax), 'labellim');
        set(hlbl(iax,1), 'string', origin);
        set(hlbl(iax,2), 'string', xmax);
        set(hlbl(iax,3), 'string', ymax);
    else        
        hlbl(iax,1) = textLoc(origin, 'southwest', 'Parent', ax(iax));
        hlbl(iax,2) = textLoc(xmax,   'southeast', 'Parent', ax(iax));
        hlbl(iax,3) = textLoc(ymax,   'northwest', 'Parent', ax(iax));
    end

    setappdata(ax(iax), 'labellim', hlbl(iax,:));
    
end

