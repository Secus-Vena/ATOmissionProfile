%% Ѳ���ٶȹ滮 ATO2.0�汾 
%���������ļ��㣬�����ٶȡ����롢ʱ��İ���
%��������֪����s �滮��ʱ��Tplan ʵ���õ�ʱ����Ts �����ٶ�MA �����ٶ�MB 
%�ٶ�Ѳ���㷨�滮 ������  �汾0614
%% �㷨˼��
%1 ��������ʱ�������ٶ��������ƶ���ʱ�������ٶ��ƶ���ҪѰ������ٶ�V
%2 �������ٶ�V������ȫ�̣�ʱ��ΪTs�����㸻��ʱ�� Tsur=Tplan-Ts
%3 �ж� �����ղ���dv(��Ϊ�趨��
%���Tsur>0 ��ô��ζ�ų��������ˣ��ٶ�Ӧ���µ�
%���Tsur<0 ��ô��ζ�ų��ڹ涨ʱ�仹û�����ٶ�Ӧ���ϵ�
%4 �ɵ������õ���һ��Tsur<0���ٶ� ���ö��ַ�ϸ��������ʱ���������Χepsi
%ϸ��ԭ��
%�趨vlim0 ������Tsur>0 vlim1������ Tsur<0
%��Tsur>0֮�󣬸���vlim0ֵΪ��ʱ��v;Tsur<0֮�󣬸���vlim1��ֵΪ��ʱ��v
%v=(vlim0+vlim1)/2;
%����0<Tsur<epsiʱ���õ��������v
%% ������
%a ���ٶ�  v �г��ٶ�m/s T ��ʱ��
%MA �����ٶ� MB �����ٶ� ����VMAX
s=50;%�ܾ���
Tplan=10;%��ʱ��
VMAX=15;
MB=-3;
MA=3;

%% Ѳ���ٶ��������
a=MA;
dv=0.1;%����
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
         vlim0=v+dv;%�ϸ�ʱ�̵��ٶ�
         break;
         end
     end
    Sb=-v^2/(2*MB);%�ƶ�����
    x1=v^2/(2*a);%ǣ������
    t1=v/a;
    Tb=(s-Sb-x1)/v+t1;%ʣ�������������ʱ��
    Ts=-v/MB+Tb;%�ƶ�����ʱ�����֮ǰ����ʱ��
    Tsur=Tplan-Ts;%����ʱ��
end
xb=s-Sb;
X=[0 t1 Tb Ts];
S=[0 x1 xb s];
Speed=[0 v v 0];
plot(S,Speed);
xlabel('����');
ylabel('�ٶ�');
figure
plot(X,Speed);
xlabel('ʱ��');
ylabel('�ٶ�');
fprintf('Tsur=%f\n',Tsur);
fprintf('v=%f\n',v);
fprintf('Ts=%f\n',Ts);
%% ���ַ�ϸ���ٶ� 
epsi=0.001;
n=1000;
 vlim1=v;%vlim1�� Tsur<0
while(flag&&n)
    
    v=(vlim0+vlim1)/2;%vlim0 ��Tsur>0 %vlim1�� Tsur<0
    Sb=-v^2/(2*MB);%�ƶ�����
    x1=v^2/(2*a);%ǣ������
    t1=v/a;
    Tb=(s-Sb-x1)/v+t1;%ʣ�������������ʱ��
    Ts=-v/MB+Tb;%�ƶ�����ʱ�����֮ǰ����ʱ��
    Tsur=Tplan-Ts;%����ʱ��
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
xlabel('����');
ylabel('�ٶ�');
figure
plot(X,Speed);
xlabel('ʱ��');
ylabel('�ٶ�');
figure
plot(X,S);
xlabel('ʱ��');
ylabel('����');

fprintf('Tsur=%f\n',Tsur);
fprintf('v=%f\n',v);
fprintf('Ts=%f\n',Ts);