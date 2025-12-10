#include <stdio.h>

int main(){
    char s1[] = "toyama";
    char s2[] = "ishikawa";
    char s3[] = "fukui";

    char *hokuriku1[3];
    hokuriku1[0] = s1;  // &s1[0]といっしょ。s1の先頭アドレスを代入
    hokuriku1[1] = s2;
    hokuriku1[2] = s3;
    
    printf("a");
    return 0;
}