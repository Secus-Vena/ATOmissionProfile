%% ����·��s Ԥ��ʱ��T ����f ǣ����F
%�������� �ܹ���ʱ������·�̣�
%�����������ƶ�ʲôʱ��ʼ���Լ�ATO�㷨�����׼���

%% ������
%a ���ٶ� M �г����� v �г��ٶ�km/h tʱ������ slope �µ�ǧ���� 
%g �������ٶ�
slope=0;
Distance=50;%�ܾ���
M=0.1;
g=10;
Time=15;%��ʱ��
dt=0.1;%ÿһ����һ��
L=0:dt:Time;
S=zeros(length(L),1);
V=zeros(length(L),1);
T=zeros(length(L),1);

%% �г�ǣ��������������
% F1=300-0.285*v;%v 0-199
% F2=31500/v;%v >199
% f1=0.775+0.0062367*v+0.000113*(v^2); %��λ�������� N/kN
% f2=slope;%��λ�µ�����
% fb=;%�ƶ���
F1=1.775;
F2=-0.225;
f1=0.775;
f2=slope;
fb=0.225;

j=0;
%% �ж� �� �����л�
for L=0:dt:Time
    j=j+1;
if V(j)>199
    F=F2;
else
    F=F1;
end
f=f1+f2;%��λ����
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