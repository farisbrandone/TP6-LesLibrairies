# 🧮 Projet Calculatrice

Dans ce projet nous avons mis en place un programme écrit en C qui permet de faire des opérations suivantes :
- **Arithmétique simple** (+, -, *, /)
---

## Introduction aux librairies statique et dynamique
Un fichier .so est une bibliothèque d'objets partagés dynamiques utilisée par les systèmes d'exploitation comme Linux et Unix, \
tandis qu'un fichier .a (bibliothèque statique) est une collection de fichiers objets statiques. \
La principale différence réside dans la manière dont les bibliothèques sont liées aux applications : les fichiers .so sont chargés à l'exécution,\
permettant le partage des fonctionnalités entre plusieurs programmes, \
tandis que les fichiers .a sont inclus directement dans l'exécutable final lors de la compilation.\

### Fichiers .so (Bibliothèques partagées)
- Liaison dynamique : Les fonctions de la bibliothèque sont appelées à l'exécution, ce qui permet à\ plusieurs programmes d'utiliser la même copie de la bibliothèque en mémoire.
- Format : Elles sont compilées en utilisant la structure ELF (Executable and Linkable Format).\
Utilisation : Courantes dans les systèmes de type Unix/Linux, \
elles permettent une gestion plus efficace de la mémoire et des mises à jour plus simples des bibliothèques sans avoir à recompiler tous les programmes qui les utilisent.

### Fichiers .a (Bibliothèques statiques)
- Liaison statique : Le code de la bibliothèque est directement copié dans le fichier exécutable de\ l'application lors de la compilation.
- Taille : Cela augmente la taille du fichier exécutable car il contient tout le code de la bibliothèque.
- Dépendances : L'application ne dépend plus de la bibliothèque externe après la compilation, car tout le code est intégré.

## 🚀 Commande manuelle pour la compilation associée aux librairies

```bash
# Fichier objet principal
gcc -g -Wall -Wextra -fPIC -I src/lib/calculatriceStat -I src/lib/calculatriceDyn -c src/app/main.c -o src/build/main.o

# Fichier objet de la bibliothèque statique
gcc -g -Wall -Wextra -fPIC -c src/lib/calculatriceStat/calculatriceStat.c -o src/build/calculatriceStat.o

# Fichier objet de la bibliothèque dynamique
gcc -g -Wall -Wextra -fPIC -c src/lib/calculatriceDyn/calculatriceDyn.c -o src/build/calculatriceDyn.o

# Bibliothèque statique (.a)
ar rcs src/lib/calculatriceStat/libcalculatriceStat.a src/build/calculatriceStat.o

# Bibliothèque dynamique (.so)
gcc -shared -o src/lib/calculatriceDyn/libcalculatriceDyn.so src/build/calculatriceDyn.o

gcc -g -Wall -Wextra -o src/bin/exe src/build/main.o \
    -Lsrc/lib/calculatriceStat -lcalculatriceStat \
    -Lsrc/lib/calculatriceDyn -lcalculatriceDyn \
    -Wl,-rpath,src/lib/calculatriceDyn

 ./src/bin/exe

 # Vérifier les bibliothèques liées
ldd src/bin/exe

# Vérifier le contenu de la bibliothèque statique
ar -t src/lib/calculatriceStat/libcalculatriceStat.a

```

## 🚀 Image associée a l'éxécution des Commandes manuelles pour compilation
![Second Branch](./image/CaptureCommandeManuelle.png)

## 🚀 Image montrant la taille des exécutable associée au librairie statique et dynamique
![Second Branch](./image/CaptureTailleExe.png)

On constate que sur l'Image que:
- La taille de l'Exécutable intégrant la lib statique est de 19ko et celle associé à \
la lib Dynamique est de 18Ko ce qui démontre que les exécutable utilisant une lib dynamique \
sont plus legère car celle n'integre pas dans leur exécutable la lib dynamique contrairement \
au cas statique qui integre dans son exécutable la lib statique


## 🚀 Résultat
![Second Branch](./image/ResultatStat.png)

![Second Branch](./image/ResultatDyn.png)

