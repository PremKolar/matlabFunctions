% barObj(years,D_real,{'costs','overhead','yield'},combos,contracts)
classdef barObjWithSumLine < gen.barObj
    
    
    methods
        function obj = barObjWithSumLine(varargin)
            obj@gen.barObj(varargin{:});
        end
        
        % -----------------------------------------------------------------
        function plot(obj)
            
            
            %%
            obj.h.popup.String = obj.legend_j;
            
            %%
            if ~obj.checkForSelections || obj.T==1
                cla(obj.h.axis);
                return
            end
            
            %%
            cla(obj.h.axis); hold(obj.h.axis,'on');
            
            obj.bars = [];
            obj.bartags = cell(obj.T,obj.K*obj.I);
            for k = 1:obj.K % types
                x = (1:obj.T)+(k)*obj.barwidth-obj.barwidth/8; % years..
                y =  obj.M_j(:,:,k)'; % all years x all chunks
                obj.bars = [obj.bars bar(obj.h.axis,x,y,obj.barwidth,'stacked')];
                if ~isempty(obj.M_tags)
                    obj.bartags(:,obj.I*(k-1)+1:obj.I*k) = obj.M_tags_j(:,:,k)';
                end
            end
            
            for b=1:numel(obj.bars)
                if obj.bars(b).XData(1) ==  2-obj.barwidth-obj.barwidth/8
                    obj.bars(b).XData = obj.bars(b).XData+obj.barwidth/4;
                end
            end
            
            
            caxis(obj.h.axis,[1 numel(obj.legend_i)]);
            
            set(obj.h.axis,'XTick',1:obj.T);
            set(obj.h.axis,'XTickLabel',obj.legend_t);
            
            
            % TODO mouse over
            warning('off')
            if numel(obj.legend_i)<=30
                fprintf('building legend...\n')
                legend(obj.h.axis,obj.legend_i,'Location','northeastoutside','AutoUpdate','off');
            else
                fprintf(2,'more than 50 values. legend would be too large!\n')
            end
            warning('on')
            
            
            grid on
            if ~isempty(obj.Mb)
                obj.plotB;
            end
            
            
            
            
            %             txt = strip(sprintf('%s   |   ',obj.legend_k{:}));
            %             x = obj.h.axis.XLim(1) + 0.1 * diff(obj.h.axis.XLim);
            %             obj.typesText = text(obj.h.axis,x,1.03*maxy,txt(1:end-2),'FontSize',obj.fontsize,'interpreter','none');
            grid(obj.h.axis,'on')
            axis(obj.h.axis,'tight')
            gen.ticklabelbetweenticks(obj.h.axis)
            
            maxy = obj.h.axis.YLim(2);
            ydiff = diff(obj.h.axis.YLim,1);
            symbols = {'- ' '- ' '+ ' '= '};
            for k = 1:obj.K
                txt = [symbols{k} obj.legend_k{k}];
                x = obj.h.axis.XLim(1)+(k)*obj.barwidth-3/8*obj.barwidth;
                y = maxy-ydiff/8;
                obj.typesText(k) = text(obj.h.axis,x,y,txt,'FontSize',obj.fontsize,'interpreter','none','Rotation',90);
            end
            
            yl = obj.h.axis.YLim;
            xt = obj.h.axis.XTick;
            xt(end+1) = xt(end)+1;
            plot(obj.h.axis,repmat(xt,2,1),repmat(yl',1,numel(xt)),'color', 'black');
            %             plot(obj.h.axis,repmat(xt-.3,2,1),repmat(yl',1,numel(xt)),'LineStyle','--','Color','black','LineWidth',.1);
            
        end
    end
end


