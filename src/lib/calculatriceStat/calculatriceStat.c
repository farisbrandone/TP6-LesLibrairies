#include "calculatriceStat.h"
#include <stdio.h>

double addition(double a, double b) {
    return a + b;
}

double soustraction(double a, double b) {
    return a - b;
}

double multiplication(double a, double b) {
    return a * b;
}

double division(double a, double b) {
    if(b != 0.0) {
        return a / b;
    } else {
        printf("Erreur: Division par zéro!\n");
        return 0.0;
    }
}

void executerCalculStat(char operateur, double a, double b) {
    double resultat;

    switch(operateur) {
        case '+':
            resultat = addition(a, b);
            printf("Résultat: %.2f + %.2f = %.2f\n", a, b, resultat);
            break;
        case '-':
            resultat = soustraction(a, b);
            printf("Résultat: %.2f - %.2f = %.2f\n", a, b, resultat);
            break;
        case '*':
            resultat = multiplication(a, b);
            printf("Résultat: %.2f * %.2f = %.2f\n", a, b, resultat);
            break;
        case '/':
            resultat = division(a, b);
            if(b != 0.0) {
                printf("Résultat: %.2f / %.2f = %.2f\n", a, b, resultat);
            }
            break;
        default:
            printf("Opérateur invalide! Utilisez +, -, *, /\n");
            return;
    }
}
