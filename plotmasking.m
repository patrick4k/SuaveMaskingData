% function plotmasking(filename)
clear, clc, close all;

xyzfilename = "flight_11_15_2024\XYZ\XYZ_11_15_14_24_37.csv";
cpufilename = "flight_11_15_2024\XYZ\CPU_11_15_14_24_38.csv";
xyz = readtable(xyzfilename);
cpu = readtable(cpufilename);

timestamp_maskingstart = xyz.time(1);
time = xyz.time - timestamp_maskingstart;

%% X over Time
figure;
plot(time, xyz.CenterX);
xlabel('Time [s]');
ylabel('X [pixels]');
title('Bounding Box X Over Time');
grid on;

%% Y over Time
figure;
plot(time, xyz.CenterY);
xlabel('Time [s]');
ylabel('Y [pixels]');
title('Bounding Box Y Over Time');
grid on;

%% Z over Time
figure;
plot(time, xyz.Width);
xlabel('Time [s]');
ylabel('Z [pixels]');
title('Bounding Box Width Over Time');
grid on;

%% CPU over Time
timestamp_cpustart = cpu.Timestamp(1);
cputime = cpu.Timestamp - timestamp_cpustart;

figure;
plot(cputime, cpu.CPUUsage___);
xline(timestamp_maskingstart - timestamp_cpustart, '-r', 'Masking Enabled');
xlabel('Time [s]');
ylabel('CPU Usage [%]');
title('Total CPU Usage Over Flight');
grid on;

%% Average CPU
% fprintf('Select beginning of position hold\n');
% [t0_poshold, ~] = ginput(1);
% fprintf('Select end of position hold\n');
% [t1_poshold, ~] = ginput(1);
% 
% fprintf('Select beginning of masking\n');
% [t0_masking, ~] = ginput(1);
% fprintf('Select end of masking\n');
% [t1_masking, ~] = ginput(1);

% avgcpu_poshold = mean(cpu.CPUUsage___((cputime > t0_poshold) .* cputime < t1_poshold));
% avgcpu_masking = mean(cpu.CPUUsage___((cputime > t0_masking) .* cputime < t1_masking));

figure;
avgcpu_poshold = 39.6465;
avgcpu_masking = 44.7682;
bar(["No Controller", "Masking Controller"], [avgcpu_poshold, avgcpu_masking]);
title('Average CPU Usage');
ylabel('CPU Usage [%]');
ylim([0 100]);


% end
