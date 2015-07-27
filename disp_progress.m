function [T] = disp_progress(type,Tin,L,num_prints,inner)
    if nargin == 3
        num_prints=L;
    end
    if nargin<5
        inner=0;
    end
  
    %%
    if labindex == 1
        switch type
            case 'init'
                T=init(Tin,inner);return;
            otherwise
                T=later(Tin,L,num_prints);return;
        end
    else
        T=[];return
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=init(Tin,inner)
    T.cc=0;
    T.time=0;
    T.name=Tin;
    T.tic=tic;
    if ~inner
        clc
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=later(T,L,num_prints)
    T.cc=T.cc+1;
    %%
    if mod(T.cc,ceil(L/num_prints))==0;
        T=calcu(T,L);
        printout(T,L);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sendoutStrings(strout)
    for a=1:numel( strout.a)
        disp(strout.a{a})
    end
    for b=1:numel( strout.b)
        disp(strout.b{b})
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function strout=makeStrings(T,L)
    strout.a{1}='';
    strout.a{2}=['master thread says:'];
    strout.a{3}='####';
    strout.a{4}=['-',T.name,'-'];
    strout.a{5}='####';
    %%
    strout.b{1}=sprintf('step: %d/%d\n',T.cc,L);
    strout.b{2}=sprintf('%03d%% done.\n',round(T.prcnt_done));
    strout.b{3}=sprintf('time so far: %s\n', datestr(sec2day(T.time),'dd-HH:MM:SS'));
    
    if isfinite(T.time_to_go)
        b4 =  datestr(sec2day(T.time_to_go),'dd-HH:MM:SS');
        
    else
        b4 =  'calculating...';
    end
    strout.b{4}  = sprintf('time to go     :   %s \n',b4);
end
function printout(T,L)
    %% build output
    toprint=makeStrings(T,L);
    %% print
    sendoutStrings(toprint);
    %% waitbar
    spmdwaitbar(T.cc,L,30);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out=spmdwaitbar(l,L,len)
    frac=l/L;
    out=['[',repmat('-',1,floor(frac*len)),'>',repmat(' ',1,ceil((1-frac)*len)),']\n'];
    fprintf(out);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function T=calcu(T,L)
    T.time=toc(T.tic);
    T.frac=((T.cc-1)/L);
    T.time_to_go=T.time/T.frac-T.time;
    T.prcnt_done=T.frac*100;
    if isfield(T,'uplevel')
        T.uplevel.full_time_to_go=(T.time_to_go + T.time)*T.uplevel.togo;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [DD]=sec2day(SS)
    DD=SS/24/60/60;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

