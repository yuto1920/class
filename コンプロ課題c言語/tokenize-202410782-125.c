#include <stdio.h>
#include <string.h>
char *tokenize_r(char *str, const char *delims, char **saveptr) {
    char *head;
    char *p;
    if (str != NULL) {
        head = str;
    } else {
        head = *saveptr;
    }
    if (*head == '\0') {
        return NULL;
    }
    while (strchr(delims, *head) != NULL) {
        if (*head == '\0') {
            return NULL;
        }
        head++;
    }
    p = head;
    while (*p != '\0') {
        if (strchr(delims, *p) != NULL) {
            *p = '\0';
            *saveptr = p + 1;
            return head;
        }
        p++;
    }
    *saveptr = p;
    return head;
}
int main(void) {
    char s1[] = "  cmd1, cmd2;  cmd3. final_arg   ";
    const char *delimiters = " ,;."; 
    char *p;
    char *saveptr1; 

    printf("■■■ 1回目のテスト ■■■\n");
    printf("元の文字列: \"%s\"\n", s1);
    printf("区切り文字: \"%s\"\n\n", delimiters);
    printf("--- 切り出したトークン ---\n");

    p = tokenize_r(s1, delimiters, &saveptr1);

    while (p != NULL) {
        puts(p);
        p = tokenize_r(NULL, delimiters, &saveptr1);
    }
    printf("--------------------------\n\n");
    printf("■■■ 2回目のテスト（再入可能性の確認）■■■\n");
    char s2[] = "path=//usr/bin:./local";
    const char *delims2 = "=:/";
    char *saveptr2; 

    printf("元の文字列: \"%s\"\n", s2);
    printf("区切り文字: \"%s\"\n\n", delims2);
    printf("--- 切り出したトークン ---\n");

    p = tokenize_r(s2, delims2, &saveptr2);
    while (p != NULL) {
        puts(p);
        p = tokenize_r(NULL, delims2, &saveptr2);
    }
    printf("--------------------------\n");

    return 0;
}