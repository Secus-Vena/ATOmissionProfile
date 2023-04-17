%% 巡航速度规划 ATO2.0版本 
%不考虑力的计算，单纯速度、距离、时间的安排
%条件：已知距离s 规划总时间Tplan 实际用的时间是Ts 最大加速度MA 最大减速度MB 
%速度巡航算法规划 整完了  版本0614
%% 算法思想
%1 在启动的时候最大加速度启动，制动的时候最大减速度制动，要寻找最佳速度V
%2 计算在速度V下跑完全程，时间为Ts，计算富余时间 Tsur=Tplan-Ts
%3 判断 并按照步长dv(人为设定）
%如果Tsur>0 那么意味着车早就完成了，速度应该下调
%如果Tsur<0 那么意味着车在规定时间还没到，速度应该上调
%4 由第三步得到了一个Tsur<0的速度 利用二分法细调并定义时间误差允许范围epsi
%细调原则：
%设定vlim0 代表是Tsur>0 vlim1代表是 Tsur<0
%当Tsur>0之后，更新vlim0值为此时刻v;Tsur<0之后，更新vlim1的值为此时刻v
%v=(vlim0+vlim1)/2;
%最终0<Tsur<epsi时，得到最佳限速v
%% 初定义
%a 加速度  v 列车速度m/s T 总时间
%MA 最大加速度 MB 最大减速度 限速VMAX
s=50;%总距离
Tplan=10;%总时长
VMAX=15;
MB=-3;
MA=3;

%% 巡航速度最佳区间
a=MA;
dv=0.1;%降速
v=VMAX;
flag=0;
vlim0=0;
n=10^3;
Tsur=1;

while(1)
     if Tsur>0
        v=v-dv;
     else
         if Tsur<0
         flag=1;
         vlim0=v+dv;%上个时刻的速度
         break;
         end
     end
    Sb=-v^2/(2*MB);%制动距离
    x1=v^2/(2*a);%牵引距离
    t1=v/a;
    Tb=(s-Sb-x1)/v+t1;%剩余距离匀速所用时间
    Ts=-v/MB+Tb;%制动所用时间加上之前所用时间
    Tsur=Tplan-Ts;%富余时间
end
xb=s-Sb;
X=[0 t1 Tb Ts];
S=[0 x1 xb s];
Speed=[0 v v 0];
plot(S,Speed);
xlabel('距离');
ylabel('速度');
figure
plot(X,Speed);
xlabel('时间');
ylabel('速度');
fprintf('Tsur=%f\n',Tsur);
fprintf('v=%f\n',v);
fprintf('Ts=%f\n',Ts);
%% 二分法细化速度 
epsi=0.001;
n=1000;
 vlim1=v;%vlim1是 Tsur<0
while(flag&&n)
    
    v=(vlim0+vlim1)/2;%vlim0 是Tsur>0 %vlim1是 Tsur<0
    Sb=-v^2/(2*MB);%制动距离
    x1=v^2/(2*a);%牵引距离
    t1=v/a;
    Tb=(s-Sb-x1)/v+t1;%剩余距离匀速所用时间
    Ts=-v/MB+Tb;%制动所用时间加上之前所用时间
    Tsur=Tplan-Ts;%富余时间
    n=n-1;
    
    if Tsur<epsi&&Tsur>=0
        break;
    else 
        if Tsur<0 
            vlim1=v;
        else
            vlim0=v;
        end
    end  
end

figure
xb=s-Sb;
X=[0 t1 Tb Ts];
S=[0 x1 xb s];
Speed=[0 v v 0];
plot(S,Speed);
xlabel('距离');
ylabel('速度');
figure
plot(X,Speed);
xlabel('时间');
ylabel('速度');
figure
plot(X,S);
xlabel('时间');
ylabel('距离');

fprintf('Tsur=%f\n',Tsur);
fprintf('v=%f\n',v);
fprintf('Ts=%f\n',Ts);