LIB "tst.lib";
tst_init();
option(prot);
ring S = 32003,(e(1..6),s(1..9)),dp;
ideal I=
e(1)+e(2)+e(3)-s(1),
e(4)^2+e(5)^2+e(6)^2-s(2),
e(2)^2+e(2)*e(3)+e(3)^2-s(3),
e(4)*e(5)*e(6)-s(4),
e(2)*e(5)^2+2*e(3)*e(5)^2-e(2)*e(6)^2+e(3)*e(6)^2-s(5),
e(3)^3-s(6),
e(5)^4+e(5)^2*e(6)^2+e(6)^4-s(7),
e(2)*e(3)*e(6)^2+e(3)^2*e(6)^2-s(8),
e(2)*e(6)^4-s(9);
qhweight(I);
I[1]=I[1]+1;
qhweight(I);
I[1]=I[1]-1;
I[2]=I[2]+1;
qhweight(I);
 int d=100;
 int h=51;
 ring r=0,x(1..d),dp;
 ideal id;
 int j;
 id[d]=(x(1)+x(2))^3;
 for(j=2;j<d;j++)
 {
   id[j]=x(j+1)^2*x(j)+x(j)^2*x(j-1)-x(j)^3+1;
 }
 id[1]=x(d)+x(d-1);
 id=homog(id,x(1));
 for(j=d;j>1;j--)
 {
   id[j]=id[j]*id[j-1];
 }
 id[1]=id[1]^5;
 id=subst(id,x(h),x(h)^2);
 int s=size(id);
 int q=0;
 for(j=s;j>0;j--)
 {
   q=q+size(id[j]);
 }
 s;
 q;
 intvec vv=qhweight(id);
 vv;
 kill r;
 d=500;
 h=49;
 ring r=0,x(1..d),dp;
 ideal id;
 for(j=d-1;j>1;j--)
 {
   id[j]=x(j+1)+x(d-j);
 }
 id[1]=x(1)+x(2);
 id=subst(id,x(h),x(h)^2);
 vv=qhweight(id);
 vv;
tst_status(1);$
