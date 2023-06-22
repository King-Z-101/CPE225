#include<stdlib.h>
#include<stdio.h>
#define SIZE 10

typedef struct Node studentNode;
void swapNodes(struct Node** head_ref, struct Node* currX,
                struct Node* currY, struct Node* prevY);
studentNode * selectionSort(studentNode * head);
void printList(studentNode *head);
studentNode *addStudent(studentNode * head, studentNode newstudent );
studentNode *createList(studentNode *Arr, int n);
void sort(struct Node** head_ref);

struct Node {
        char name[6];
        int studentid;
        int coursenum;
        studentNode * next;
};

studentNode studentArr[SIZE] = {
        {"Dougy", 13, 2122, NULL},
        {"Timmy", 15, 2122, NULL},
        {"Emily", 18, 2123, NULL},
        {"Jimmy", 14, 2120, NULL},
        {"Kimmy", 11, 2123, NULL},
        {"Carlo", 19, 2123, NULL},
        {"Vicky", 22, 2120, NULL},
        {"Anton", 12, 2322, NULL},
        {"Brady", 10, 2120, NULL},
        {"Sonya", 16, 2123, NULL}
};

int main()
{
        studentNode * studentlist;
        studentlist = createList(studentArr, SIZE);
        sort(&studentlist);
        printList(studentlist);

        return 0;
}

studentNode *createList(studentNode Arr[], int n) {
        studentNode * list = NULL;
        int i;
        for(i=0; i<n; i++) {
                list = addStudent(list, Arr[i]);
        }
        return list;
}

studentNode *addStudent(studentNode * head, studentNode newstudent ) {
        studentNode * temp=NULL;
        temp = (studentNode *) malloc (sizeof(studentNode));
        *temp = newstudent;
        if (head == NULL) {
                head = temp;
                head->next=NULL;
        }
        else {
                temp->next=head;
                head = temp;
        }
        return head;
}


void printList(studentNode *head) {
        if (head != NULL) {
                printf("%d ", head->studentid);
                printf("%s ", head->name);
                printf("%d\n", head->coursenum);
                printList (head->next);
        }
}


/* swapping nodes in a singly linked list is a pain. You need to swap the nodes themselves, and the references to those nodes. */
void swapNodes(struct Node** head_ref, struct Node* currX,
                struct Node* currY, struct Node* prevY)
{
        studentNode* temp;
        /* make 'currY' as new head*/
        *head_ref = currY;

        /* adjust links*/
        prevY->next = currX;

        /* Swap next pointers*/
        temp = currY->next;
        currY->next = currX->next;
        currX->next = temp;
}

/* function to sort the linked list using */
/* recursive selection sort technique*/
struct Node* recurSelectionSort(struct Node* head)
{
        struct Node* min;
        struct Node* ptr;
        struct Node* beforeMin;


        /* if there is only a single node */
        if (head->next == NULL)
                return head;

        /* 'min' - pointer to store the node having */
        /* minimum data value */
        min = head;

        /* 'beforeMin' - pointer to store node previous */
        /* to 'min' node */
        beforeMin = NULL;

        /* traverse the list till the last node  */
        for (ptr = head; ptr->next != NULL; ptr = ptr->next) {

                /* if true, then update 'min' and 'beforeMin' */
                if (ptr->next->studentid < min->studentid ) {
                        min = ptr->next;
                        beforeMin = ptr;
                }
        }

        /* if 'min' and 'head' are not same, */
        /* swap the head node with the 'min' node */
        if (min != head)
                swapNodes(&head, head, min, beforeMin);

        /* recursively sort the remaining list */
        head->next = recurSelectionSort(head->next);

        return head;
}

/* function to sort the given linked list */
void sort(struct Node** head_ref)
{
        /* if list is empty */
        if ((*head_ref) == NULL)
                return;

        /* sort the list using recursive selection */
        /* sort technique  */
        *head_ref = recurSelectionSort(*head_ref);
}