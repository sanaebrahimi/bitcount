#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <ctype.h>

/**
 * Converts a string into a real signed 64 bit integer.
 */
int64_t myatoi(char *s)
{
  int64_t v = 0;
  int neg = 0;

  if (*s == '-') {
    neg = 1;
    s++;
  }
  while (isdigit(*s)) {
    v = v * 10;
    v = v + (*s - '0');
    s++;
  }
  if (neg) v = -v;
  return v;
}

/**
 * Converts a string into a 64 bit integer and counts the number of 1 bits
 * in the resulting binary number.  In ASM, argc is [rsp], argv[0] is at
 * [rsp+8], argv[1] is at [rsp+16] and so on.
 */
int main(int argc, char **argv)
{
  uint64_t n;
  int c = 0;

  if (argc < 2) {
    fprintf(stderr,"Usage: %s <int>\n", argv[0]);
    return 1;
  }
  n = (uint64_t)myatoi(argv[1]);

  do {
    if (n & 1) c++;
    n >>= 1;
  } while (n);

  printf("%d\n", c);
  return 0;
}
