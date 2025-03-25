#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>

float randomFloat(float min, float max) {
    float random = ((float)rand()) / RAND_MAX;
    return min + random * (max - min);
}

int main() {
    srand(time(NULL));
    float min = 0;
    float max = 1000000;
    int bit;
    float num = randomFloat(min, max);
    memcpy(&bit, &num, sizeof(float));
    int   sign     = bit >> 31;
    int   exponent = (bit >> 23) & 0xff;
    int   mantissa = bit & 0x007fffff;
    float numCalc = (1 + (float)mantissa / pow(2, 23)) * pow(2, (float)exponent - 127);
    printf("random number                  : %f\n", num);
    printf("bit                            : %x\n", bit);
    printf("sign                           : %x\n", sign);
    printf("mantissa                       : %x\n", mantissa);
    printf("exponent                       : %x\n", exponent);
    printf("(-1)^S * (1+M/2^23) * 2^(E-127): %f\n", numCalc);
    if (num != numCalc)
        printf("ERROR\n!");
    return 0;
}
