# Réponses — Évaluation Séance 3

## Développement d'applications mobiles — Bachelor 2 Informatique

> **Nom / Prénom :**  Riviere Julien
> **Date :** 14 avril 2026

---

## Question 1 — StatefulWidget vs StatelessWidget

> Pourquoi l'écran de la todo list est-il un `StatefulWidget` et non un `StatelessWidget` ?  
> Que se passerait-il concrètement si on avait utilisé un `StatelessWidget` à la place ?

_Votre réponse (3 à 5 lignes) :_

L'ecran de la todo list est un StatefulWidget et non un Statelesswidget car Statefulwidget est concy pour car il possede un objet state qui peut evolué , on peut aussi utiliser setstate pour recree l'ui avec des nouvelle information.

si on avait utilise un statelesswidget a la place il ne peut pas stocker d'etat qui change et il ne se reconstrui que si ses perametrer externe changent.

---

## Question 2 — Le rôle de setState

> Que fait exactement `setState` dans le cycle de vie d'un widget Flutter ?  
> Que se passe-t-il si on modifie la liste de tâches (ajout, suppression, toggle) **sans** appeler `setState` ?

_Votre réponse (3 à 5 lignes) :_

<!-- Écrivez votre réponse ici -->

setstate fait a modifier des donnes ex d'une liste de tache et il permet de reconstruire avec les nouvelle donné rapidement 

si on modifie la liste de tache esans appeller setstate il ce passe que les donnée changent en mémoire mais l'interface ne changera pas car flutter n'est pas au ourant du changement donc il ne vas pas pouvoir mettre a jour l'interface 

---

## Question 3 — La pile de navigation

> Expliquez le mécanisme de la pile de navigation Flutter.  
> Quand on navigue vers l'écran Statistiques, puis qu'on revient : que se passe-t-il en mémoire avec les écrans ? L'écran principal est-il reconstruit ?

_Votre réponse (3 à 5 lignes) :_

<!-- Écrivez votre réponse ici -->

le mecanisme de la pile de navigation flutter est de gere par le widget navigator on a nabigator?push qui permet d'ajoouté un nouvel ecran au sommet de la pile et navigator.pop qui vas enlever l'ecrant actuel.

Quand on navigue vers l'ecran statistique flutter ajoute cet ecrant au sommet de la pile de navigation l'ecran principal la todo list reste en memoir il n est pas supprime il est simplement mit en arriere plan et ensuite quand on revient avec navigator.pop l'ecrant statistique est retré de ka ouke et detruit

---

## Question 4 — Bug de déclaration

> Un étudiant déclare son `TextEditingController` **à l'intérieur** de la méthode `build()` au lieu de le déclarer comme variable d'instance dans le `State`. Son champ de texte semble se comporter bizarrement.
>
> Expliquez le problème que cela pose et pourquoi.

_Votre réponse (3 à 5 lignes) :_

<!-- Écrivez votre réponse ici -->

c'est un probleme car  perte du texte saiso a chaque reconstructin un nouveau controller vide est cree l'ancien est perdu resultat le texte peut disparitre ou revenir a une ancienne valeur comportement bizzare a l ecrant ou meme fuite de memoir car les anien texteditingcontroller ne sont jamais disposée 

---

## Question 5 — Choix de conception

> Votre application gère les tâches avec une simple `List` en mémoire. Quand l'utilisateur ferme l'application, toutes les tâches disparaissent.
>
> — Nommez une approche ou un package Flutter qui permettrait de persister les données entre deux lancements de l'app.  
> — Sans écrire de code, expliquez où dans l'architecture de l'app vous feriez les modifications.

_Votre réponse (3 à 5 lignes) :_

On peut utiliser **sqflite** ou **Hive** pour persister les tâches (base de données locale), ou **shared_preferences** si la liste reste petite.

Architecturalement, il faut créer une couche **Repository** ou **TaskService** qui gère la communication avec la base de données. Au lieu de modifier directement la List en mémoire, le State du TodoListScreen appelle les méthodes du repository. Au démarrage dans initState(), charger les tâches existantes. Chaque action (ajout, suppression, toggle) passe par le repository qui met à jour la base de données avant de mettre à jour l'UI avec setState().