function Finalproject
global matrix1;     %creating our variable
matrix1.output = [];

matrix1.fig = figure('numbertitle','off','name','Matrix Solver');       %making our figure
matrix1.displayMessage = uicontrol('style','text','units','normalized','position',[0.05,0.96,0.06,0.033],'string','Matrix','horizontalalignment','right');  
matrix1.input = uicontrol('style','edit','units','normalized','position',[.05,.86,.3,0.04],'callback',{@inputRead});   %this edit box will send the string inputted to be read by the callback function
matrix1.eigen = uicontrol('style','pushbutton','units','normalized','position',[0.05,.8,.05,.05],'string','solve','callback',{@plotVectors});
matrix1.axes = axes('position',[.47,.3,.5,.6]);
    function inputRead(source,~)
        %this function takes in the string put in the gui and converts it
        %into a numeric matrix, and then displays it
        matrix1.output = str2num(source.String);
        
        if diff(size(matrix1.output)) == 0
            matrix1.displayMessage2 = uicontrol('style','text','units','normalized','position',[0.05,0.73,0.06,0.033],'string','Matrix:','horizontalalignment','right');
            matrix1.outputDisplay = uicontrol('style','text','units','normalized','position',[0.05,.58,.15,.15],'string',num2str(matrix1.output),'horizontalalignment','right');
        else
            msgbox('Nonsquare matrix!','Matrix Solver Error','error','modal');  %error for nonsquare matrices
        end
        
    end
    function plotVectors(source,event)
        
        [V,D] = eig(matrix1.output); %gives us 2 matrices, V for the eigenvectors, D for the eigenvalues
        
        matrix1.displayValues = uicontrol('style','text','units','normalized','position',[0.03,.58,.15,.033],'string','Eigen Values:','horizontalalignment','right');
        matrix1.displayValuesMatrix = uicontrol('style','text','units','normalized','position',[0.02,.38,.3,.17],'string',num2str(D),'horizontalalignment','center');
        matrix1.displayVectors = uicontrol('style','text','units','normalized','position',[0,.34,.15,.033],'string','Eigen Vectors:','horizontalalignment','right');
        matrix1.displayVectorsMatrix = uicontrol('style','text','units','normalized','position',[0.02,0,.3,.3],'string',num2str(V),'horizontalalignment','center');
        
        littleD = diag(D);
        Dlength = length(littleD);
        delete(matrix1.axes);                               %clears plot
        matrix1.axes = axes('position',[.47,.3,.5,.6]);       %makes the plot again
        if Dlength == 2
         for i = 1:Dlength
            hold on;                                        %uses quiver to plot the vectors
            q = quiver3(0,0,0,V(1,i),V(2,i),0);
         end
     elseif Dlength == 3
        for i = 1:Dlength
            hold on;
            q = quiver3(0,0,0,V(1,i),V(2,i),V(3,i));
        end
        else
            msgbox('I cant graph that!','Matrix Solver Error','error','modal');   %error message for non-2x2 or 3x3 matrices
        end  
        
    end
    
end
