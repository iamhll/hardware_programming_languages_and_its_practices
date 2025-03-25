#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>

double randomDouble(double min, double max) {
    double random = ((double)rand()) / RAND_MAX;
    return min + random * (max - min);
}

int main() {
    srand(time(NULL));
    double min = 0;
    double max = 1000000;
    long   bit;
    double num = randomDouble(min, max);
    memcpy(&bit, &num, sizeof(double));
    long   sign     = bit >> 63;
    long   exponent = (bit >> 52) & 0x7ff;
    long   mantissa = bit & 0xfffffffffffff;
    double numCalc = (1 + (double)mantissa / pow(2, 52)) * pow(2, (double)exponent - 1023);
    printf("random number                   : %f\n", num);
    printf("bit                             : %lx\n", bit);
    printf("sign                            : %lx\n", sign);
    printf("mantissa                        : %lx\n", mantissa);
    printf("exponent                        : %lx\n", exponent);
    printf("(-1)^S * (1+M/2^52) * 2^(E-1023): %f\n", numCalc);
    if (num != numCalc)
        printf("ERROR\n!");
    return 0;
}
