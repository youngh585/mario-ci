#include <cs50.h>
#include <stdio.h>

void print_row(int spaces, int bricks);

int main(void)
{
    // Prompt user for input
    int height;
    do
    {
        height = get_int("Height:\n");
    }
    while (height < 1);

    // Print a pyramid of that height
    for (int i = 0; i < height; i++)
    {
        int spaces = height - i - 1;
        int bricks = i + 1;
        print_row(spaces, bricks);
    }
}

void print_row(int spaces, int bricks)
{
    for (int i = 0; i < spaces; i++)
    {
        printf(" ");
    }

    for (int i = 0; i < bricks; i++)
    {
        printf("#");

    }

    printf("\n");
}
