#include <stdio.h>
#include <string.h>
#include <math.h>
int power(int a,int b){
    int x=1;
    int i;
    for(i=0;i<b;i++) {
        x=x*a;
    }
    return x;
}
double sesi(double x){
    double a=1.8;
    return x*a+32;
}
double bmi(double x,double y){
    double z=x/100;
    return y/(z*z);
}
int fibo1(int n){
if (n == 1 || n == 2) {
return 1;
} else {
return fibo1(n-1) + fibo1(n-2);
}}
int sum_num(int n){
    int b;
    if(n==1){
        return 1;
    } else {
        return n+sum_num(n-1);
    }
}
int yugrid(int n, int k) {
    int a;
    while (k != 0) {
        a = n % k;
        n = k;
        k = a;
    }
    return n;
}
double kainokousiki(double a,double b,double c){
    double k=b*b-4*a*c;
    if (k<0){
        printf("解なし");
    }else{
        double j=sqrt(k);
        if (k==0){
            printf("%f\n",-b/(2*a));
        }else{
            printf("%f\n",(-b-j)/(2*a));
            printf("%f\n",(-b+j)/(2*a));
        }
    return 0;
}}
int magiccircle(void){
    int a[3][3];
    int val = 1;
    int i, j;
    for (i = 0; i < 3; i = i + 1) {
        for (j = 0; j < 3; j = j + 1) {
            a[(j*2+2*i)%3][(j+1+2*i)%3] = val;
            val = val + 1;
        }
    }
    for (i = 0; i < 3; i = i + 1) {
        for (j = 0; j < 3; j = j + 1) {
	    printf("%d ", a[i][j]);
        }
        printf("\n");
    }
    return 0;
}
int main(void){
    int y=power(2,4);
    printf("%d\n",y);
    int a=3;
    int b=4;
    if (a*b%2==0){
        printf("Even\n");
    } else{
        printf("Odd\n");
    }
    int c=1;
    int d=21;
    if (c*d%2==0){
        printf("Even\n");
    } else{
        printf("Odd\n");
    };
    printf("%2f\n",sesi(12.3));
    printf("%2f\n",bmi(169,60));
    printf("%d\n",fibo1(10));
    printf("%d\n",sum_num(10));
    printf("%d\n",yugrid(100,85));
    kainokousiki(2,9.2,5.1);
    int input = 0;

    printf("整数を入力して、改行キーを押してください\n");
    scanf("%d", &input);
    printf("入力した整数は%dです。\n", input);
    int i;
    int flag[1001];
    for (i = 0; i <= 1000; i = i + 1) {
        flag[i] = 1;
    }
    flag[0] = 0;
    flag[1] = 0;

    for (i = 0; i <= 1000; i = i + 1) {
        if (flag[i] == 1) {
            int j = i * 2;
            while (j <= 1000) {
                flag[j]=0;
                j+=i;
            }
        }
    }
    for (i = 0; i <= 1000; i = i + 1) {
        if (flag[i]==1)
        {
            printf("%d\n",i);
        }
    }
    char fox[]= "The quick brown fox jumps over the lazy dog.";
    for (i=0;i<44;i++){
        if(fox[i]=='o'){
           printf("%d\n", i);
        }
    }
    magiccircle();
    return 0;
 }