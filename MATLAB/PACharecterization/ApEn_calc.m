folder_path = 'fsk_data4/';
%cd(folder_path);

file_list = dir(fullfile(folder_path, '*.csv'));
result_day1 = zeros(2400,30);
result_file_day1 = cell(2400 ,1);

for i = 1:length(file_list)
    file_name = file_list(i).name;
    disp(file_name)
    
    data_table = readtable(file_name);
    complex_data = data_table.real + 1j * data_table.imag;

    m = 2;      % embedded dimension
    tau = 1;    % time delay for downsampling
    N = 1000;
    t = 0.001*(1:N);
    pa = complex_data;
    sd = std(pa);
    % specify the range of r
    rnum = 30;   
    
    % main calculation and display
    %figure

    for k = 1:rnum
        r = k*0.02;
        result_day1(i,k) = ApEn(m, r*sd, pa, tau);
       
       
    end

    result_file_day1{i,1} = file_name;
    
    %r = 0.02*(1:rnum);
    %plot(r,result_day1(1,:),'o-',r,result_day1(170,:),'o-',r,result_day1(202,:),'o-',r, result_day1(250,:),'o-', r, result_day1(2392,:),'o-',r, result_day1(2400,:),'o-')
    %axis([0 rnum*0.02 0 1.05*max(result_day1(:))])

    %legend('class0','class0','class1', 'class1', 'class11', 'class11')
    %title(['ApEn, m=' num2str(m) ', \tau=' num2str(tau)],'fontsize',14)
    %xlabel r

end

%% 


