#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define N_TOWER 3

unsigned *tower[N_TOWER];
unsigned *top[N_TOWER];
unsigned n_input;
unsigned n_steps = 0;

void print_tower(unsigned i) {
  assert(0 <= i && i < N_TOWER);
  unsigned *p = tower[i];

  printf("%d|", i);
  while (p != top[i]) {
    printf("%d]", *p);
    p++;
  }
  printf("\n");
}

void print_towers() {
  int i;
  for (i = 0; i < N_TOWER; i++) {
    print_tower(i);
  }
}

void move(unsigned from, unsigned to) {
  printf("### move %d to %d\n", from, to);
  assert(top[from] > tower[from]); 
  assert(top[to] == tower[to] || *(top[to] - 1) > *(top[from] - 1)); 

  *(top[to]) = *(top[from] - 1); 
  top[to]++;
  top[from]--; 
  print_towers();
  n_steps++;
}

int verify_towers(unsigned i, unsigned *t0, unsigned *t1, unsigned *t2) {
  // ここに処理を追加する。関数の引数を変更しても良い。
  unsigned *towers[] = { t0, t1, t2 };
  for (int i = 0; i < N_TOWER; i++) {
    unsigned *p = tower[i];
    while (p < top[i] - 1) {
      if (*p < *(p + 1)) return 0; 
      p++;
    }
  }
  return 1;
}

void hanoi(unsigned n, unsigned cur_pos, unsigned dest_pos) {
  assert(0 < n);
  assert(0 <= cur_pos && cur_pos < N_TOWER);
  assert(0 <= dest_pos && dest_pos < N_TOWER);

  if (n == 1) {
    move(cur_pos, dest_pos);
  } else {
    unsigned aux = 3 - cur_pos - dest_pos;
    hanoi(n - 1, cur_pos, aux);
    move(cur_pos, dest_pos);
    hanoi(n - 1, aux, dest_pos);
  }
  if (verify_towers( /* ここに適切な引数を入れる */ 0,tower[0],tower[1],tower[2])) {
    puts("### verify: OK");
  } else {
    puts("### verify: FAILED");
    print_towers();
    exit(EXIT_FAILURE);
  }
}

int main(int argc ,char **argv) {
  int  i;

  assert(argc == 2);
  n_input = atoi(argv[1]);
  assert(n_input > 0);

  for (i = 0; i < N_TOWER; i++) {
    tower[i] = malloc(n_input * sizeof(unsigned));
    if (tower[i] == NULL) exit(EXIT_FAILURE);
    top[i] = tower[i];
  }
  for (i = 0; i < n_input; i++) {
    *top[0] = n_input - i;
    top[0]++;
  }

  puts("### start");
  print_towers();
  hanoi(n_input, 0, 2);
  printf("### %d steps to complete\n", n_steps);

  return 0;
}