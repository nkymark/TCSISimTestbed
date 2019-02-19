% Author:   Kok Yew Ng
% Created:  15th Jan 2016
% Modified: 15th Jan 2016
% 

%%
function SavePlot( filename, tag, scrsz, sub )

plotHandle = figure( 'position', [scrsz(1) / 2.4, scrsz(1) / 3.6, scrsz(1) / 1.8, scrsz(1) / 2.4], 'NumberTitle', 'off' );
existing = findobj( tag, 'Type', 'axes' );

if sub == 1
    for ii = 1:length( existing )
        copyobj( existing(ii),plotHandle );
    end
elseif sub == 0
    copyobj( existing,plotHandle );
end

print( gcf, '-dpng', [filename '.png'] );

% Use the following codes to save figures as pdf files for higher resolution
% set( gcf, 'PaperOrientation', 'Landscape' );
% print( gcf, '-dpdf', [filename '.pdf'],  '-bestfit' );

close( plotHandle );
delete( plotHandle );
