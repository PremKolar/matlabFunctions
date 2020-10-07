function ax2 = ticklabelbetweenticks(ax1)
    % ticklabelbetweenticks  Shift the tick labels in the X axis
    %    ticklabelbetweenticks(AX) shifts current ticklabels to the right
    % between
    %    tick marks in axis AX. It only works for the X axis.
    %    Returns the handler to the hidden axis with the
    % centered ticklabels.
    
    % Author M. Vichi (CMCC), from ideas posted on the Mathworks
    % forum
    
    if nargin==0, ax1=gca; end
    
    ax2=axes(ax1.Parent,'position',get(ax1,'position'));
    
    %invert the order of the axes
    
    c=get(ax1.Parent,'children');
    set(ax1.Parent,'children',flipud(c))
    
    xlim=get(ax1,'XLim');
    xtick=get(ax1,'XTick');
    delt=diff(xtick);
    xtick2=[0.5*[delt delt(end)]+xtick(1:end)];
    xticklabels=get(ax1,'XTickLabel');
    set(ax2,'Xlim',xlim,'XTick',xtick2,'XTicklabel',xticklabels);
    ytick=get(ax1,'YTick');
    yticklabels=get(ax1,'YTickLabel');
    set(ax2,'Ylim',ylim,'YTick',ytick,'YTicklabel',yticklabels);
    set(ax1,'XTickLabel','','Visible', 'on')
end