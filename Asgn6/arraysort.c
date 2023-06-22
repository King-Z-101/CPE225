#include <stdio.h>
#define SIZE 10

void swap(int arr[], int i, int j);
void selectionSort(int arr[], int i, int n);
void printArray(int arr[], int n);


int main()
{
    int arr[SIZE] = { 3, 5, 8, 4, 1, 9, -2, 2, 0, 6 };
    int n = SIZE;

    selectionSort(arr, 0, n);
    printArray(arr, n);

    return 0;
}

/* Utility function to swap values at two indices in an array*/
void swap(int arr[], int i, int j)
{
    int temp = arr[i];
    arr[i] = arr[j];
    arr[j] = temp;
}

/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
void selectionSort(int arr[], int i, int n)
{
    /* find the minimum element in the unsorted subarray `[i…n-1]`
    // and swap it with `arr[i]`  */
    int j;
    int min = i;
    for (j = i + 1; j < n; j++)
    {
        /* if `arr[j]` is less, then it is the new minimum */
        if (arr[j] < arr[min]) {
            min = j;    /* update the index of minimum element */
        }
    }

    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
    swap(arr, min, i);

    if (i + 1 < n) {
        selectionSort(arr, i + 1, n);
    }
}

/* Function to print `n` elements of array `arr` */
void printArray(int arr[], int n)
{
    int i;
    for (i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
}
