% 1. copy all files into separate directory
% 2. Run MATLAB
% 3. In command prompt type in cd 'the_name_of_installation_directory'
%    where the_name_of_installation_directory is a full path to teh installation directory
%    for example, if files were copied to the directory 'rf_book' on drive c, then
%    one should type in cd 'c:\rf_book'
% 4. From MATLAB command line run set_path
% 5. In the main menue of the command window go to file/set path...
% 6. In the path browser go to file\save path
% 7. now all paths are setup and you can run examples from the command line

root_dir=pwd;
path(root_dir,path);

for i=1:10
   current_dir=strcat(root_dir,'\ch',num2str(i,'%02.f'));
   path(current_dir,path);
end;

tools_dir=strcat(root_dir,'\tools');
path(tools_dir,path);

current_dir=strcat(tools_dir,'\amplifiers');
path(current_dir,path);
current_dir=strcat(tools_dir,'\conversion');
path(current_dir,path);
current_dir=strcat(tools_dir,'\global');
path(current_dir,path);
current_dir=strcat(tools_dir,'\networks');
path(current_dir,path);
current_dir=strcat(tools_dir,'\smith');
path(current_dir,path);
current_dir=strcat(tools_dir,'\circles');
path(current_dir,path);

circles_dir=current_dir;
current_dir=strcat(circles_dir,'\gain');
path(current_dir,path);
current_dir=strcat(circles_dir,'\noise');
path(current_dir,path);
current_dir=strcat(circles_dir,'\quality');
path(current_dir,path);
current_dir=strcat(circles_dir,'\stability');
path(current_dir,path);
