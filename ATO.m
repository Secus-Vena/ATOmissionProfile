%% 假设路程s 预定时间T 阻力f 牵引力F
%单纯加速 能够在时间点完成路程；
%接下来考虑制动什么时候开始，以及ATO算法，简易计算

%% 初定义
%a 加速度 M 列车质量 v 列车速度km/h t时间序列 slope 坡道千分数 
%g 重力加速度
slope=0;
Distance=50;%总距离
M=0.1;
g=10;
Time=15;%总时长
dt=0.1;%每一秒算一次
L=0:dt:Time;
S=zeros(length(L),1);
V=zeros(length(L),1);
T=zeros(length(L),1);

%% 列车牵引力及阻力计算
% F1=300-0.285*v;%v 0-199
% F2=31500/v;%v >199
% f1=0.775+0.0062367*v+0.000113*(v^2); %单位基本阻力 N/kN
% f2=slope;%单位坡道阻力
% fb=;%制动力
F1=1.775;
F2=-0.225;
f1=0.775;
f2=slope;
fb=0.225;

j=0;
%% 判断 及 工况切换
for L=0:dt:Time
    j=j+1;
if V(j)>199
    F=F2;
else
    F=F1;
end
f=f1+f2;%单位阻力
a=F/(M*g)-f;
V(j+1)=V(j)+a*dt;
S(j+1)=S(j)+(V(j)+V(j+1))*dt/2;
T(j)=L;
if S(j+1)>=Distance
    break;
end
end

V=V(1:j);
T=T(1:j);
S=S(1:j);

plot(T,V);
xlabel('time');
ylabel('speed');
figure
plot(S,V);
xlabel('distance');
ylabel('speed');