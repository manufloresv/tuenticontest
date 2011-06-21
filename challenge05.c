// Challenge 5: The Milkman Problem - Tuenti Programming Contest
// Author: Manuel Flores <manuelfloresv[at]gmail[.]com>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// returns the maximum of a and b
int max(int a, int b) {
    return (a>b)?a:b;
}

// reads a lists of 'size' numbers separated by commas
void read_list(int size, int *list) {
    int i;
    char cad[500], *token, *comma=",";

    scanf("%s", &cad);
    token=strtok(cad, comma);
    for(i=0; i<size; i++) {
        list[i]=token?atoi(token):0; // 0 to fix the typo in sample input
        token=strtok(NULL, comma);
    }
}

void main() {
    // variables
    int num_cows, truck_weight, i, w;
    int *cow_weight, *cow_milk;
    int **truck;

    // main loop
    while (scanf("%d", &num_cows)!=EOF) { // read num_cows
        scanf("%d", &truck_weight); // read truck_weight
        
        // allocate memory
        cow_weight=malloc(num_cows*sizeof(int));
        cow_milk=malloc(num_cows*sizeof(int));
        // two-dimensional array
        truck=malloc((num_cows+1)*sizeof(int *));
        for (i=0; i<=num_cows; i++) {
            truck[i]=malloc((truck_weight+1)*sizeof(int));
        }

        // read lists
        read_list(num_cows, cow_weight);
        read_list(num_cows, cow_milk);

        // 0-1 Knapsack problem:
        // http://en.wikipedia.org/wiki/Knapsack_problem#0-1_knapsack_problem
        for(w=0; w<=truck_weight; w++) {
            truck[0][w]=0;
        }
        for(i=0; i<=num_cows; i++) {
            truck[i][0]=0;
        }
        for(i=1; i<=num_cows; i++) {
            for(w=1; w<=truck_weight; w++) {
                if (cow_weight[i-1]>w) {
                    truck[i][w]=truck[i-1][w];
                } else {
                    truck[i][w]=max(truck[i-1][w], truck[i-1][w-cow_weight[i-1]] + cow_milk[i-1]);
                }
            }
        }

        // output
        printf("%d\n", truck[num_cows][truck_weight]);

        // free all memory
        for(i=0; i<=num_cows; i++) {
            free(truck[i]);
        }
        free(truck);
        free(cow_weight);
        free(cow_milk);
    }
}
