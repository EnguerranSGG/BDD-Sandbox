## La requête SELECT 

La requête ***SELECT*** est une commande SQL permettant de récupérer des données spécifiques dans une base de données.

Dans l'exemple ci-dessous, on récupère toutes (*) les données d'une table : 

```sql
SELECT * FROM nom_table;
````

Si l'on veut selectionner une ou plusieurs colonnes de cette table, il suffit de le placer entre le SELECT et le FROM :

```sql
SELECT colonne1, colonne2 FROM nom_table;
````

### Filtrer avec WHERE 

Basiquement, ***WHERE*** consiste à apposer des conditions de filtrage à notre requêtes, par exemple :

```sql
SELECT nom, age FROM utilisateurs
WHERE age > 18;
````

### Chercher des correspondances avec LIKE

L'opérateur ***LIKE*** est utilisé pour rechercher un modèle spécifique dans une colonne de type texte. 

#### Les caractères génériques :
- % : représente zéro, un ou plusieurs caractères.
- _ : représente un seul caractère.

Si l'on veut rechercher tous les noms commençant par A :

`````sql
SELECT * FROM utilisateurs
WHERE nom LIKE 'A%';
``````
Si l'on veut rechercher tous les noms terminant par ia :

`````sql
SELECT * FROM utilisateurs
WHERE nom LIKE '%ia';
``````

Si l'on veut rechercher tous les noms contenant ra :

`````sql
SELECT * FROM utilisateurs
WHERE nom LIKE '%ra%';
``````

Si l'on veut rechercher tous les noms commençant par A et dont la troisème lettre est un o :

`````sql
SELECT * FROM utilisateurs
WHERE nom LIKE 'A_o%';
``````

### Trier avec ORDER BY

Comme son nom l'indique, ***ORDER BY*** va permettre d'ordonner le résultat de notre requête selon une certaine logique.

Ci-dessous, en se basant sur leur âge on va trier de manière décroissante (ici DESC sinon ASC pour l'inverse) les utilisateurs ayant plus de 18 ans :

```sql
SELECT nom, age FROM utilisateurs
WHERE age > 18
ORDER BY age DESC;
````

### Limiter notre nombre de résultats avec LIMIT

Ici, on va apposer une limite au nombre de résulat retournés par notre requête :

```sql
SELECT nom, age FROM utilisateurs
WHERE age > 18
ORDER BY age DESC
LIMIT 10;
````

### Retirer les doublons avec DISTINCT

L'opérateur ***DISTINCT*** permet de supprimer les doublons dans les résultats d'une requête, en ne renvoyant que des lignes uniques. Par exemple :

`````sql
SELECT DISTINCT nom
FROM utilisateur;
``````
### Regrouper des résulat avec GROUP BY

Parfois, on va vouloir regrouper nos résulats. Par exemple, on veut connaître le nombre de produits par catégories dans une table produit :

```sql
SELECT categorie, COUNT(*) AS nombre_produits
FROM produits
GROUP BY categorie;
````
### Les fonctions d'agrégation

Dans le précédent exemple, on utilise la fonction ***COUNT***(*) pour compter tous les produits présents dans chaque catégorie.

Il en existe d'autre comme ***SUM***(additionne les valeurs d'une colonne), ***AVG***(fais la moyenne des valeurs d'une colonne), ***MIN***(renvoie la valeur min d'une colonne), et ***MAX***(renvoie la valeur max d'une colonne).

### Joindre une autre table avec JOIN

Afin de combiner les résulats de plusieurs tables, on va utiliser les commandes JOIN. 

Ci-dessous, en utilisant leur id, on va chercher les noms des utilisateurs ainsi que leur numéro et date de commande :

````sql
SELECT utilisateurs.nom, commandes.id, commandes.date
FROM utilisateurs
JOIN commandes ON utilisateurs.id = commandes.utilisateur_id;
````



````sql
SELECT *
FROM contacts
INNER JOIN typeContacts ON contacts.id_type =  typeContacts.id
INNER JOIN villes ON contacts.id_ville =  villes.id
WHERE villes.nom = "Lille"
AND typeContacts.libelle = "client";
````


pg_dump permet de réinitailiser une base de donnée à l'identique. En gros, à partir de d'un fichier, on peut recréer une base de données à l'identique. 