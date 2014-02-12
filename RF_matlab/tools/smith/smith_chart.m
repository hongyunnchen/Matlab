function figNumber=smith_chart(option)
% Usage: smith(option)
%
% Purpose: creates Smith chart display
%
% Parameters:
%   option = 0 <-- Z-Smith Chart is created (black color, solid line)
%   option = 1 <-- Y-Smith Chart is created (black color, solid line)
%   option = 2 <-- ZY-Smith Chart is created (black color,
%                  Z-Chart- solid line, Y-Chart - dashed line)

figNumber=figure;

% define X and R circles
X=[0.2 0.5 1 2 5];
R=[0.2 0.5 1 2 5];

% we want to plot smooth cirlces with 101 points
alpha=2*pi*(0:0.01:1);

% if no arguments are not specified we assume Z-chart
if nargin<1
   option=0;
end;

% draw a white circle
chart_color=[0.5 0.5 0.5];
patch(cos(alpha),sin(alpha),'-','edgecolor',chart_color,'facecolor',get(gca,'color'));
hold on;
plot([-1 1],[0 0],'color',chart_color);

for rr=R
   xc=rr/(1+rr); % x position of the center
   rd=1/(1+rr);  % radius of the circle
   
   % plot circles
   if (option==0 | option==2)
      plot(xc+rd*cos(alpha),rd*sin(alpha),'-','color',chart_color);
   end;
   if option==1
      plot(-xc-rd*cos(alpha),rd*sin(alpha),'-','color',chart_color);
   end;
   if option==2
      plot(-xc-rd*cos(alpha),rd*sin(alpha),'-','color',chart_color);
   end;
end;
   
for xx=X
   xc=1;    % x position of the center
   yc=1/xx; % y position of the center
   rd=1/xx; % radius of the circle
   alpha_xx= 2*atan(xx)*(0:0.01:1);
   if (option==0 | option==2)
      plot(xc-rd*sin(alpha_xx),yc-rd*cos(alpha_xx),'-','color',chart_color);
      plot(xc-rd*sin(alpha_xx),-yc+rd*cos(alpha_xx),'-','color',chart_color);
   end;
   if (option==1)
      plot(-xc+rd*sin(alpha_xx),yc-rd*cos(alpha_xx),'-','color',chart_color);
      plot(-xc+rd*sin(alpha_xx),-yc+rd*cos(alpha_xx),'-','color',chart_color);
   end;
   if (option==2)
      plot(-xc+rd*sin(alpha_xx),yc-rd*cos(alpha_xx),':','color',chart_color);
      plot(-xc+rd*sin(alpha_xx),-yc+rd*cos(alpha_xx),':','color',chart_color);
   end;
end

%annotate smith chart
Z_text_color=[0.5 0 0];
Y_text_color=[0 0 0.5];
if option == 0
   for rr=R
      xc=rr/(1+rr); % x position of the center
      rd=1/(1+rr);    % radius of the circle
      text(xc-rd,0,num2str(rr,'%.1f'), ...
         'horizontalalignment','left','VerticalAlignment','bottom',...
         'color',Z_text_color,'Rotation',90);
   end;   
   for xx=X
      alpha_xx= 2*atan(1/xx);
      text(1.1*cos(alpha_xx),1.1*sin(alpha_xx),num2str(xx,'+%.1f'), ...
         'horizontalalignment','center','VerticalAlignment','middle',...
         'color',Z_text_color);
      text(1.1*cos(alpha_xx),-1.1*sin(alpha_xx),num2str(xx,'-%.1f'), ...
         'horizontalalignment','center','VerticalAlignment','middle',...
         'color',Z_text_color);
   end;  
   text(-1.1,0,'0.0', ...
      'horizontalalignment','center','VerticalAlignment','middle',...
      'color',Z_text_color);
   text(1.1,0,'\infty', ...
      'horizontalalignment','center','VerticalAlignment','middle',...
      'color',Z_text_color);
end;

if option == 1
   for rr=R
      xc=-rr/(1+rr); % x position of the center
      rd=-1/(1+rr);    % radius of the circle
      text(xc-rd,0,num2str(rr,'%.1f'), ...
         'horizontalalignment','right','VerticalAlignment','top',...
         'color',Y_text_color,'Rotation',90);
   end;   
   for xx=X
      alpha_xx= 2*atan(1/xx);
      text(-1.1*cos(alpha_xx),-1.1*sin(alpha_xx),num2str(xx,'+%.1f'), ...
         'horizontalalignment','center','VerticalAlignment','middle',...
         'color',Y_text_color);
      text(-1.1*cos(alpha_xx),+1.1*sin(alpha_xx),num2str(xx,'-%.1f'), ...
         'horizontalalignment','center','VerticalAlignment','middle',...
         'color',Y_text_color);
   end;  
   text(1.1,0,'0.0', ...
      'horizontalalignment','center','VerticalAlignment','middle',...
      'color',Y_text_color);
   text(-1.1,0,'\infty', ...
      'horizontalalignment','center','VerticalAlignment','middle',...
      'color',Y_text_color);
end;

hold off;
axis image;
axis off;
