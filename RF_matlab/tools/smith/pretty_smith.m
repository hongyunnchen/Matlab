function figNumber=pretty_smith()
% Usage: smith(option)
%
% Purpose: creates Smith chart display

% define X and R circles
%X=[1/3 1 3];
%R=[1/3 1 3];
R    =[0.2 0.5 1.0 2.0 5.0 10];
X    =[0.1 0.2 0.5 1.0 2.0 5.0 10];
Inter=[1.0 2.0 5.0 5.0 10  10  inf];   

% we want to plot smooth cirlces with 101 points
alpha=2*pi*(0:0.01:1);

if ~ishold
   clf;
end;

% draw a white circle
chart_color=[0 0 0];
patch(cos(alpha),sin(alpha),'-','edgecolor',chart_color,'facecolor',get(gca,'color'));
hold on;
plot([-1 1],[0 0],'color',chart_color);

% plot constant resistance and constant conductance circles
for rr=R
   xc=rr/(1+rr); % x position of the center
   rd=1/(1+rr);    % radius of the circle
   
   plot(xc+rd*cos(alpha),rd*sin(alpha),'-','color',chart_color);
   plot(-xc-rd*cos(alpha),rd*sin(alpha),'-','color',chart_color);
end;

% plot constant reactance and constant susseptance circles
for n=1:length(X)
   xx=X(n);
   xc=1;    % x position of the center
   yc=1/xx; % y position of the center
   rd=1/xx; % radius of the circle
   max_alpha=2*atan(xx);
   Inter_rd=1/(1+Inter(n));
   min_alpha=2*atan(Inter_rd*xx);
   alpha_xx= min_alpha:(max_alpha-min_alpha)/100:max_alpha;
   plot(xc-rd*sin(alpha_xx),yc-rd*cos(alpha_xx),'-','color',chart_color);
   plot(xc-rd*sin(alpha_xx),-yc+rd*cos(alpha_xx),'-','color',chart_color);
   plot(-xc+rd*sin(alpha_xx),yc-rd*cos(alpha_xx),'-','color',chart_color);
   plot(-xc+rd*sin(alpha_xx),-yc+rd*cos(alpha_xx),'-','color',chart_color);
end

%annotate smith chart
% Z_text_color=[0.5 0 0];
% Y_text_color=[0 0 0.5];
% for rr=R
%    xc=rr/(1+rr); % x position of the center
%    rd=1/(1+rr);    % radius of the circle
%    text(xc-rd,0,num2str(rr,'%.1f'), ...
%       'horizontalalignment','left','VerticalAlignment','bottom',...
%       'color',Z_text_color,'Rotation',90);
% end;   
% for xx=X
%    alpha_xx= 2*atan(1/xx);
%    text(1.1*cos(alpha_xx),1.1*sin(alpha_xx),num2str(xx,'+%.1f'), ...
%       'horizontalalignment','center','VerticalAlignment','middle',...
%       'color',Z_text_color);
%    text(1.1*cos(alpha_xx),-1.1*sin(alpha_xx),num2str(xx,'-%.1f'), ...
%       'horizontalalignment','center','VerticalAlignment','middle',...
%       'color',Z_text_color);
% end;  
% text(-1.1,0,'0.0', ...
%    'horizontalalignment','center','VerticalAlignment','middle',...
%    'color',Z_text_color);
% text(1.1,0,'\infty', ...
%       'horizontalalignment','center','VerticalAlignment','middle',...
%       'color',Z_text_color);

% for rr=R
%    xc=-rr/(1+rr); % x position of the center
%    rd=-1/(1+rr);    % radius of the circle
%    text(xc-rd,0,num2str(rr,'%.1f'), ...
%       'horizontalalignment','left','VerticalAlignment','bottom',...
%       'color',Y_text_color,'Rotation',-90);
% end;   
% for xx=X
%    alpha_xx= 2*atan(1/xx);
%    text(-1.1*cos(alpha_xx),-1.1*sin(alpha_xx),num2str(xx,'+%.1f'), ...
%       'horizontalalignment','center','VerticalAlignment','middle',...
%       'color',Y_text_color);
%    text(-1.1*cos(alpha_xx),+1.1*sin(alpha_xx),num2str(xx,'-%.1f'), ...
%       'horizontalalignment','center','VerticalAlignment','middle',...
%       'color',Y_text_color);
% end;  
% text(1.1,0,'0.0', ...
%    'horizontalalignment','center','VerticalAlignment','middle',...
%    'color',Y_text_color);
% text(-1.1,0,'\infty', ...
%    'horizontalalignment','center','VerticalAlignment','middle',...
%    'color',Y_text_color);

hold off;
axis image;
axis off;
