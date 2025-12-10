#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char *mreadline(FILE *fp) {
  char *mem = NULL;
  size_t memsize = 8;
  mem = malloc(memsize);
  if (mem == NULL) exit(EXIT_FAILURE);
  size_t offset = 0;
   while (1) {
        if (fgets(mem + offset, memsize - offset, fp) == NULL) {
          break;
        }
        offset = strlen(mem);
        if (offset > 0 && mem[offset - 1] == '\n') {
            break;
        }
        if (feof(fp)) {
            break;
        }
        memsize *= 2; 
        char *temp = realloc(mem, memsize);
        if (temp == NULL) {
            free(mem);
            exit(EXIT_FAILURE);
        }
        mem = temp;
    }
  return mem;
}
int main(int argc, char **argv) {
  char *line;
  while (1) {
    line = mreadline(stdin);
    if (line == NULL) {
      free(line);
      break;
    }
    puts(line);  
    free(line);
  }
}
