#include <stdio.h>
#define DIM 3  
void printMatrix(double A[DIM][DIM]) {
    for (int i = 0; i < DIM; i++) {
        for (int j = 0; j < DIM; j++) {
            printf("%6.1f ", A[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}
int main(void) {
    double A[DIM][DIM] = {
        {1.0, 2.0, 3.0},
        {4.0, 5.0, 6.0},
        {7.0, 8.0, 9.0}
    };
    double T[DIM][DIM];
    double R[DIM][DIM];
    int i, j;
    printMatrix(A);
    for (i = 0; i < DIM; i++) {
        for (j = 0; j < DIM; j++) {
            T[j][i] = A[i][j];
        }
    }
    printMatrix(T);
    for (i = 0; i < DIM; i++) {
        for (j = 0; j < DIM; j++) {
            R[j][DIM - 1 - i] = T[i][j];
        }
    }
    printMatrix(R);
    return 0;
}


