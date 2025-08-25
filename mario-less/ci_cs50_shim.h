#pragma once
#include <stdio.h>
#include <stdlib.h>

// Minimal replacement for get_int in CI builds.
// Prompts are ignored; it just reads an int from stdin.
static inline int get_int(const char *prompt) {
    (void)prompt;   // ignore prompt
    int x;
    if (scanf("%d", &x) != 1) exit(1);
    return x;
}
