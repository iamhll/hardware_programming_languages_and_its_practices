#include <stdio.h>

void main() {
    FILE *fp_a, *fp_b, *fp_c;
    fp_a = fopen("DATA_A.txt", "w");
    fp_b = fopen("DATA_B.txt", "w");
    fp_c = fopen("DATA_C.txt", "w");
    for (int a = -128; a <= 127; ++a) {
        for (int b = -128; b <= 127; ++b) {
            int c = a + b;
            fprintf(fp_a, "%d\n", a);
            fprintf(fp_b, "%d\n", b);
            fprintf(fp_c, "%d\n", c);
        }
    }
    fclose(fp_a);
    fclose(fp_b);
    fclose(fp_c);
}
