#include "calculatriceStat.h"
#include "calculatriceDyn.h"
#include <stdio.h>

int main() {
    double a, b;
    char operateur;

    printf("=== CALCULATRICE SIMPLE ===\n");
    printf("Opérations supportées: +, -, *, /\n");
    printf("Format: nombre opérateur nombre (ex: 5 + 3)\n");
    printf("Tapez 'q' pour quitter\n\n");

    while(1) {
        printf("> ");

        // Read input
        if(scanf("%lf %c %lf", &a, &operateur, &b) != 3) {
            // if user type 'q' ou another thing to quit
            char c;
            scanf("%c", &c);
            if(c == 'q' || c == 'Q') break;
            printf("Format invalide! Utilisez: nombre opérateur nombre\n");
            continue;
        }

        // Exécution of opération
        executerCalculStat(operateur, a, b);
        executerCalculDyn(operateur, a, b);
    }

    printf("Au revoir!\n");
    return 0;
}
