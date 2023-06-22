#include "operations.h"



int main(void)
{
    int choice;
    char toContinue = 'y';
    int firstnum;
    int secondnum;
    int opnum = 0;

    printf("Welcome to the Calculator program.");
    printf("\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift");
    printf("\nNumber of operations performed: %d", opnum);
    while (toContinue != 'n'){
        
        printf("\nEnter number: ");
        scanf("%d", &firstnum);
        
        printf("Enter second number: ");
        scanf("%d", &secondnum);
        
        printf("Select operation: ");
        scanf("%d", &choice);
        if (choice == 1){
            printf("Result: %d", addnums(firstnum, secondnum));
        }
        else if (choice == 2)
        {
            printf("Result: %d", subnums(firstnum, secondnum));
        }
        else if (choice == 3)
        {
            printf("Result: %d", multnums(firstnum, secondnum));
        }
        else if (choice == 4)
        {
            printf("Result: %d", divnums(firstnum, secondnum));
        }
        else if (choice == 5)
        {
            printf("Result: %d", andnums(firstnum, secondnum));
        }
        else if (choice == 6)
        {
            printf("Result: %d", ornums(firstnum, secondnum));
        }
        else if (choice == 7)
        {
            printf("Result: %d", xornums(firstnum, secondnum));
        }
        else if (choice == 8)
        {
            printf("Result: %d", lshiftnums(firstnum, secondnum));
        }
        else if (choice == 9)
        {
            printf("Result: %d", rshiftnums(firstnum, secondnum));
        }
        else{
            printf("Result: Invalid Operation");
        }
        opnum += 1;
        
        
        printf("\nContinue (y/n)?: ");
        
        scanf("%s", &toContinue);
        printf("\nNumber of operations performed: %d", opnum);
    }
    printf("\nExiting");

    return 0;
}