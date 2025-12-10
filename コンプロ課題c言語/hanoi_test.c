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

// 機能A: 円盤の移動処理
void move(unsigned from, unsigned to) {
  printf("### move %d to %d\n", from, to);
  // --- ここから追加 ---
  assert(top[from] > tower[from]); // 移動元のタワーが空でないことを確認
  
  // 移動元のタワーから円盤を1つ取り出す (ポインタをデクリメント)
  top[from]--;
  unsigned disk = *top[from]; // 取り出した円盤の番号

  // 移動先のタワーに円盤を置く (ポインタをインクリメント)
  *top[to] = disk;
  top[to]++;
  // --- ここまで追加 ---

  print_towers();
  n_steps++;
}

// 機能B: 整合性検証 (再帰)
// ヘルパー関数: i番目以降のタワーの整合性を再帰的に検証する
int verify_recursive(int i) {
    // ベースケース: 全てのタワーを検証し終えたら成功
    if (i >= N_TOWER) {
        return 1;
    }
    // 現在のタワーiのtopポインタが、確保したメモリの範囲内にあるか検証
    if (top[i] < tower[i] || top[i] > tower[i] + n_input) {
        return 0; // 範囲外なら失敗
    }
    // 次のタワーを再帰的に検証
    return verify_recursive(i + 1);
}

// mainから呼び出すためのラッパー関数
int verify_towers() {
  return verify_recursive(0); // 0番目のタワーから検証を開始
}

// 機能C: ハノイの塔の再帰アルゴリズム
void hanoi(unsigned n, unsigned cur_pos, unsigned dest_pos) {
  assert(0 < n);
  assert(0 <= cur_pos && cur_pos < N_TOWER);
  assert(0 <= dest_pos && dest_pos < N_TOWER);

  // --- ここから追加 ---
  // ベースケース: 円盤が1枚なら、単に移動する
  if (n == 1) {
    move(cur_pos, dest_pos);
    return;
  }

  // 再帰ステップ
  // 1. 補助の杭を計算 (0, 1, 2の合計は3)
  unsigned aux_pos = 3 - cur_pos - dest_pos;

  // 2. n-1個の円盤を、現在の杭から補助の杭へ移動
  hanoi(n - 1, cur_pos, aux_pos);

  // 3. 残った最大の円盤nを、現在の杭から目的の杭へ移動
  move(cur_pos, dest_pos);

  // 4. n-1個の円盤を、補助の杭から目的の杭へ移動
  hanoi(n - 1, aux_pos, dest_pos);
  // --- ここまで追加 ---
};

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
  
  // 最終状態の検証
  if (verify_towers()) {
    puts("### verify: OK");
  } else {
    puts("### verify: FAILED");
    print_towers();
    exit(EXIT_FAILURE);
  };
  
  printf("### %d steps to complete\n", n_steps);

  return 0;
}