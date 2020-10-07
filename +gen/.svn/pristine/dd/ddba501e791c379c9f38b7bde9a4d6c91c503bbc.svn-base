% original code taken from Moveit2 (File Exchange)
%
% originalButtonDownFcn: use, to restore a prior button down callback
% funToDoAfterwards    : callback to fire upon button release
function mouseMoveGraphicsObject(src,~,originalButtonDownFcn,funToDoAfterwards)
if nargin<3
    originalButtonDownFcn = [];
else
    validateattributes(originalButtonDownFcn,{'function_handle'},{'scalar'})
end
if nargin<4
    funToDoAfterwards = [];
    validateattributes(originalButtonDownFcn,{'funToDoAfterwards'},{'scalar'})
end

% Unpack gui object
gui = get(gcf,'UserData');
% Remove mouse pointer
set(gcf,'PointerShapeCData',nan(16,16));
set(gcf,'Pointer','custom');
% Set callbacks
gui.currenthandle = src;
thisfig = gcbf();
set(thisfig,'WindowButtonMotionFcn',@(h,e)movit());
set(thisfig,'WindowButtonUpFcn',@(h,e)stopmovit(src,originalButtonDownFcn,funToDoAfterwards));
% Store starting point of the object
gui.startpoint = get(gca,'CurrentPoint');
set(gui.currenthandle,'UserData',{get(gui.currenthandle,'XData') get(gui.currenthandle,'YData')});
% Store gui object
set(gcf,'UserData',gui);

    function movit()
        % Unpack gui object
        gui = get(gcf,'UserData');
        try
            if isequal(gui.startpoint,[])
                return
            end
        catch
        end
        % Do "smart" positioning of the object, relative to starting point...
        pos = get(gca,'CurrentPoint')-gui.startpoint;
        XYData = get(gui.currenthandle,'UserData');
        set(gui.currenthandle,'XData',XYData{1} + pos(1,1));
        % set(gui.currenthandle,'YData',XYData{2} + pos(1,2));
        drawnow;
        % Store gui object
        set(gcf,'UserData',gui);
    end

    function stopmovit(MovedObject,originalButtonDownFcn,funToDoAfterwards)
        % Clean up the evidence ...
        thisfig = gcbf();
        gui = get(gcf,'UserData');
        set(gcf,'Pointer','arrow');
        set(thisfig,'WindowButtonUpFcn','');
        set(thisfig,'WindowButtonMotionFcn','');
        drawnow;
        set(gui.currenthandle,'UserData','');
        set(gcf,'UserData',[]);
        if contains(func2str(originalButtonDownFcn),mfilename)
            return % only first time
        end
        MovedObject.ButtonDownFcn = originalButtonDownFcn;
        feval(funToDoAfterwards)
    end


end
