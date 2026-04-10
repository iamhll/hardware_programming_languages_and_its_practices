#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define NUMB_TEST   1024

typedef unsigned int uint32_t;

uint32_t bin2gray(uint32_t dat_b_i) {
    return dat_b_i ^ (dat_b_i>>1) ;
}

void main(int numArg, char *strArg[]) {
    time_t dat_t;
    srand((unsigned) time(&dat_t));
    FILE *fp_b, *fp_g;
    fp_b = fopen("DATA_B.txt", "w");
    fp_g = fopen("DATA_G.txt", "w");
    int siz;
    if (numArg == 2) {
        siz = atoi(strArg[1]);
    }
    else {
        siz = 32;
    }
    FILE *fp = fopen("dut_settings.vh", "w");
    fprintf(fp, "parameter DATA_WD = 'd%d;\n", siz);
    fclose(fp);
    if ((long)1<<siz <= NUMB_TEST) {
        for (int i = 0; i < (long)1<<siz; ++i) {
            uint32_t dat_b = i;
            uint32_t dat_g = bin2gray(dat_b);
            fprintf(fp_b, "%x\n", dat_b);
            fprintf(fp_g, "%x\n", dat_g);
        }
    }
    else {
        for (int i = 0; i < 16; ++i) {
            uint32_t dat_b = i;
            uint32_t dat_g = bin2gray(dat_b);
            fprintf(fp_b, "%x\n", dat_b);
            fprintf(fp_g, "%x\n", dat_g);
        }
        for (int i = 0; i < 16; ++i) {
            uint32_t dat_b = ((long)1<<siz) - 16 + i;
            uint32_t dat_g = bin2gray(dat_b);
            fprintf(fp_b, "%x\n", dat_b);
            fprintf(fp_g, "%x\n", dat_g);
        }
        for (int i = 0; i < NUMB_TEST; ++i) {
            uint32_t dat_b = rand() & (((long)1<<siz)-1);
            uint32_t dat_g = bin2gray(dat_b);
            fprintf(fp_b, "%x\n", dat_b);
            fprintf(fp_g, "%x\n", dat_g);
        }
    }
    fclose(fp_b);
    fclose(fp_g);
}
