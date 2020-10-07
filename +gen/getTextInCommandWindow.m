% NK
% taken from undocumentedmatlab.com
function [cwText,jTextArea] = getTextInCommandWindow()
    jDesktop = com.mathworks.mde.desk.MLDesktop.getInstance;
        
    try
        cmdWin = jDesktop.getClient('Command Window');
        jTextArea = cmdWin.getComponent(0).getViewport.getComponent(0);
    catch
        commandwindow;
        jTextArea = jDesktop.getMainFrame.getFocusOwner;
    end
    
    cwText = string(char(jTextArea.getText));
    cwText = cwText.splitlines;
end