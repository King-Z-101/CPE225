#include <stdio.h>

void readstring(char str[]){
    int ch, i = 0;
    do
    {
        ch = getchar();
        str[i] = ch;
        i++;
    } while (ch != '\n');
    str[i++] = '\0';
    
}

void printsort(char str[]){
    int i;
    int j;
    for (i = 48; i < 123; i++){
        for (j = 0; j < 20; j++){
            if (str[j] == '\n'){
                break;
            }
            else if ((int) str[j] == i) {
                printf("%c", str[j]);
            }
        }
    }
    printf("\n");
}

int main(){
    char str[20];
    int loopcontinue = 1;
    while (loopcontinue == 1){
        printf("Enter word: ");
	    readstring(str);
        if (str[0] == '\n'){
            loopcontinue = 0;
            continue;
        }
	    printf("Original word: %s", str);
	    printf("Alphabetized word: ");
	    printsort(str);
    }
	printf("\nExiting\n");
    return 0;
}