#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#define READLINE_BUFSIZ 256


typedef struct list {
  char *key;
  int value;
  struct list *next;
} list_t;

// 文字数制限ありの簡易版。自分で実装した readline に置き換えても良い。
char *readline(FILE *fp) {  
  static char buf[READLINE_BUFSIZ];

  if (fgets(buf, READLINE_BUFSIZ, fp) == NULL) return NULL;
  unsigned len = strlen(buf);
  if (len >= READLINE_BUFSIZ - 1) exit(EXIT_FAILURE); 
  if (buf[len - 1] == '\n') buf[len - 1] = '\0';

  return buf;
}

char *tokenize(char *init) { 
  char *p, *ret;
  static char *head = NULL;

  if (head == NULL && init == NULL) return NULL;
  if (init != NULL) head = init;
  if (*head == '\0') return NULL;

  p = head; ret = head;
  while (*p != '\0' && *p != ' ') { p++; }
  if (*p == '\0') {
    head = p;
  } else {
    *p = '\0';
    head = p + 1;
  }

  return ret; 
}

void canonicalize(char *p) {
  while (*p != '\0') {
    *p = tolower(*p);
    p++;
  } 
  return;
}

list_t *new_item(char *key) {
  unsigned len = strlen(key);
  if (len == 0) return NULL;

  list_t *list = malloc(sizeof(list_t));
  if (list == NULL) { exit(EXIT_FAILURE); }

  list->key = malloc((len + 1) * sizeof(char));
  if (list->key == NULL) { exit(EXIT_FAILURE); } 

  strncpy(list->key, key, len);
  list->value = 0;
  list->next = NULL;

  return list;
}

list_t *search(char *key, list_t *list) {
  if (list == NULL) return NULL;
  if (strcmp(key, list->key) == 0) {
    return list;
  } else {
    return search(key, list->next);
  }
}

list_t *append(list_t *new_one, list_t *list) {
  // ここに、new_one をリストの末尾に追加する処理を記述せよ。
  // なお、処理の記述には再帰呼び出しを使うこと。つまり、繰り返し(for, while, do-while 等)は使わずに実現せよ。
  // 返戻値は、new_one が末尾に追加されたリストの先頭要素へのポインタとなる。list として NULL が与えられた場合でも失敗にはならないことに注意せよ。
  if (list == NULL) {
    return new_one;
  } else {
    list->next = append(new_one, list->next);
    return list;
  }
}

list_t *delete(char *key, list_t *list) {
  // ここに、key で指定された文字列を保持する構造体をリストから削除する処理を記述せよ。
  // append と同様、再帰呼び出しを使うこと。
  // 返戻値は、リストの先頭要素へのポインタとなる。削除に失敗（削除対象が存在しなかった）場合も同様。もしもリストが空になった場合はNULLを返すこと。
  // また、削除に伴って不要になった動的メモリは必ず解放すること。
  if (list == NULL) return NULL;

  if (strcmp(key, list->key) == 0) {
    list_t *next = list->next;
    free(list->key);
    free(list);
    return next;
  } else {
    list->next = delete(key, list->next);
    return list;
  }
}

void dump_list(list_t *list) {
  if (list == NULL) return;
  printf("%d\t%s\n", list->value, list->key);
  dump_list(list->next);
}

int main(int argc, char **argv) {
  list_t *list = NULL;
  char *line, *tok;

  FILE *fp = fopen(argv[1], "r");
  if (fp == NULL) { exit(EXIT_FAILURE); }

  while((line = readline(fp)) != NULL) {
    if (strlen(line) == 0) continue;
    tok = tokenize(line);
    while (tok != NULL) {
      canonicalize(tok);
      if (strlen(tok) != 0) { 
        list_t *target = search(tok, list);
        if (target == NULL) {
          target = new_item(tok); 
          list = append(target, list);
        }
        target->value += 1;
      }
      tok = tokenize(NULL);
    }
  } 

  list = delete("the", list);
  list = delete("a", list);

  dump_list(list);
} 
