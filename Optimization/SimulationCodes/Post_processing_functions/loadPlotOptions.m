function pOpts   = loadPlotOptions
%% loadPlotOptions 
% Description:  This function helps to keep common figure styling for the whole thesis.
%               The main figure and plot generation options (as the figure sizes, the font size, the colormap and other) are located here.
% 
% Outputs:      pOpts:	struct that contains all the important options and functions. As fields you can find:
%                       1) The figures position, font size, linewidth, box option. (figurePosition, lineWidthImportant, lineWidthMinor, Box)
%                       2) The all plots colormap function (colormapFunction)
%                       3) The figure generation function (gFigure)
%                       4) The axes generation function (gAxes)
%                       5) The line plots generation function (gLine)
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Plots constant options 
pOpts.figurePosition       = [40,90,1480/3,470];
pOpts.figurePosition2       = [-1265, 35, 1025, 370];%[40,90,1480,370];%[40,90,1480,470];
pOpts.figurePosition3       = [215 130 885 525];

pOpts.colormapFunction  	= @(numOfColors) jet(numOfColors); % copper jet 
pOpts.fontsize              = 12;
pOpts.Box                   = 'on';

pOpts.linewidthImportant    = 2;
pOpts.linewidthMinor        = 1.5;
pOpts.LineColor             = [138,57,22; 186,177,47; 158,220,65; 115, 44, 185; 44, 105, 185; 92, 178, 172]/255;
 
pOpts.MarkerSize            = 40;
pOpts.MarkerEdgeColor       = [0,0,0; 0,0,0; 0,0,0; [161,57,57; 51,98,192; 41,161,105]/2 ]/255;
pOpts.MarkerFaceColor       = [161,57,57; 51,98,192; 41,161,105; 161,57,57; 51,98,192; 41,161,105]/255;
pOpts.MarkerFaceAlpha       = 1;
pOpts.MarkerLineWidth       = 1.5;

pOpts.FillFaceColors        = [161,57,57; 51,98,192; 41,161,105; 255,215,0]/255;
pOpts.FillLineWidth         = 1.5;
pOpts.FillFaceAlpha         = 0.5;

pOpts.TileSpacing           = 'normal';

%% Generate figure
gFigure                     = @(figureName) generateFigure(figureName,pOpts);
pOpts.gFigure               = gFigure;

%% Generate tiledlayout
gTiledLayout                     = @(parent,GridSize) generateTiledLayout(parent,GridSize,pOpts);
pOpts.gTiledLayout               = gTiledLayout;

%% Generate tile
gTileAxes                       = @(parent, tileLocation, Span) generateTileAxes(parent, tileLocation, Span, pOpts);
pOpts.gTileAxes                 = gTileAxes;

%% Generate axes
gAxes                       = @(figureGenerated) generateAxes(figureGenerated,pOpts);
pOpts.gAxes                 = gAxes;

%% Generate line plot
gLine                       = @(Parent, Data1, Data2) generateLine(Parent, Data1, Data2, pOpts);
pOpts.gLine                 = gLine;

%% Generate Scatter
gScatter                    = @(Parent, Data1, Data2, cNum) generateScatter(Parent, Data1, Data2, pOpts, cNum);
pOpts.gScatter              = gScatter;

%% Generate fill
gFill                    = @(Parent, Data1, Data2, cNum) generateFill(Parent, Data1, Data2, pOpts, cNum);
pOpts.gFill              = gFill;

end

function figureGenerated = generateFigure(figureName,pOpts)

figureGenerated             = figure;
figureGenerated.Name        = figureName; 
figureGenerated.Position    = pOpts.figurePosition;

end

function tiledLayoutGenerated = generateTiledLayout(Parent,GridSize,pOpts)

tiledLayoutGenerated                = tiledlayout(GridSize(1),GridSize(2));
tiledLayoutGenerated.Parent         = Parent;
tiledLayoutGenerated.TileSpacing    = pOpts.TileSpacing;

end

function  tileAxesGenerated = generateTileAxes(parent, tileLocation, Span, pOpts)

tileAxesGenerated = nexttile(parent, tileLocation, Span);

% Auxilary axes generation
figureAuxilary  = figure('Visible','off');

% Generate axes based on the axes options
axesAuxilary    = generateAxes(figureAuxilary,pOpts);

% Copy the auxilary axes properties to the tile axes
copyobj(axesAuxilary.Children, tileAxesGenerated);

end

function axesGenerated = generateAxes(Parent,pOpts)

axesGenerated               = axes;
axesGenerated.Parent        = Parent;
axesGenerated.FontSize      = pOpts.fontsize;
axesGenerated.LineWidth     = pOpts.linewidthImportant;
axesGenerated.Box        	= pOpts.Box;
axesGenerated.NextPlot      = 'add';

end

function lineGenerated      = generateLine(Parent, Data1, Data2, pOpts)
    
    % Auxilary axes generation
    figureAuxilary  = figure('Visible','off');

    % Generate axes based on the axes options
    axesAuxilary    = generateAxes(figureAuxilary,pOpts);

    % Generate the line
    lineGenerated           = plot(axesAuxilary,Data1, Data2);
    
    % Implement the line to the parent axes
    lineGenerated.Parent    = Parent;
    lineGenerated.LineWidth = pOpts.linewidthImportant;    
    
end

function scatterGenerated      = generateScatter(Parent, Data1, Data2, pOpts, cNum)

    scatterGenerated                    = scatter(Parent, Data1, Data2);
    scatterGenerated.LineWidth          = pOpts.MarkerLineWidth;   
    scatterGenerated.MarkerFaceAlpha    = pOpts.MarkerFaceAlpha;   
    scatterGenerated.MarkerFaceColor    = pOpts.MarkerFaceColor(cNum,:);
    scatterGenerated.MarkerEdgeColor    = pOpts.MarkerEdgeColor(cNum,:);   
    scatterGenerated.SizeData           = pOpts.MarkerSize;
    
end

function fillGenerated      = generateFill(Parent, Data1, Data2, pOpts, cNum)

    fillGenerated                       = fill(Parent, Data1, Data2, 'r');
    fillGenerated.LineWidth             = pOpts.FillLineWidth;
    fillGenerated.FaceAlpha             = pOpts.FillFaceAlpha;
    fillGenerated.FaceColor             = pOpts.FillFaceColors(cNum,:);
end
