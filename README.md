# Rapport TP - Calcul Numérique - Grégoire DOEBELE
## TP - 2
### Exercice 6.
#### n° 1. 2. 3.
```scilab
x = [1  4  8  16]
y = [8; 19; 2; 1]
s = x * y 	// 116
z = x + y
```
`z` ne passe pas car x et y n'ont pas la même dimension<br>
par contre `z = x' + y` ou `z = x + y'` fonctionne.
#### n° 4. 5. 6. 7.
```scilab
size(x) 	// 1.	4.
size(y) 	// 4.	1.
norm(x) 	// 18.357560
A = [1 9 8 ; 7 4 1 ; 2 6 8 ; 1 7 0]
A'
```
#### n° 8. 9.
```scilab
A = [7 1 11 10 ; 2 6 5 2 ; 8 11 3 8 ; 6 9 3 6]
B = [1 1 7 -6 ; 0 7 11 3 ; 2 4 7 0 ; 15 3 3 4]
A+B
A'*B
A*B
cond(A) // 1424.9503
```
Cette matrice (prise sur wikipedia) est mal conditionnée.

### Exercice 7.
#### n° 1. 2. 3. 4.
```scilab
A = rand(3,3)
xex = rand(3,1) 	// vecteur colonne
b = A*xex
x = A\b
```
`xex` possède 3 lignes et 1 colonne.

#### n° 5.
```scilab
err_avant = norm(xex-x)/norm(xex)		// 5.700D-16
err_arriere = norm(b-A*x)/(norm(A) * norm(x)) 	// 5.581D-17
```
Sur ces matrices rand, l'erreur avant est généralement plus grande que l'erreur arrière.

#### n° 6.
```scilab
function [] = fn_ex7(n)
	tic()
	A = rand(n,n); xex = rand(n,1)
	b = A*xex
	x = A\b
	err_av = norm(xex-x)/(norm(xex))
	err_ar = norm(b-A*x)/(norm(A) * norm(x))
	time = toc()
	disp("n = " + string(n) + "   time = " + string(time))
	disp("Erreur avant : " + string(err_av))
	disp("Erreur arrière : " + string(err_ar))
endfunction
 ```
 
| n    | temps exec. | err. avant | err. arrière |
| ---: | ----------: | ---------: | -----------: |
| 100  | 1.6 ms      | 1.910D-13  | 3.837D-16    |
| 1000 | 0.5 s       | 1.128D-12  | 1.531D-15    | 
| 2000 | 6.1 s       | 1.850D-11  | 2.035D-15    |

Pour `n = 10000` le calcul prend plus de 10 minutes.<br>
En moyenne l'*erreur avant* diminue quand n augmente.

### Exercice 8.
 - *matmat3b*
```scilab
function [C] = matmat3b(A,B)
	C = zeros(size(A)(1), size(B)(2))
	for i = 1:size(A)(1)
		for j = 1:size(A)(2)
			for k = 1: size(B)(2)
				C(i,j) = A(i,k) * B(k,j) + C(i,j)
			end
		end
	end
endfunction
```
 - *matmat2b*
```scilab
function [C] = matmat2b(A,B)
    C = zeros(size(A)(1), size(B)(2))
    for i = 1:size(A)(1)
        for j = 1:size(A)(2)
            C(i,j) = A(i,:) * B(:,j) + C(i,j)
        end
    end
endfunction
```
 - *matmat1b*
```scilab
function [C] = matmat1b(A,B)
    C = zeros(size(A)(1), size(B)(2))
    for i = 1:size(A)(1)
        C(i,:) = A(i,:) * B + C(i,:)
    end
endfunction
```
#### Performances
```scilab
function [m] = perf_matmat(n, nb_loop)
    times = zeros(nb_loop,1)
    for i=1:nb_loop
        A = rand(n,n);B = rand(n,n)
        tic(); matmat1b(A,B)
        times(i,1) = toc()
    end
    m = mean(times(1,:))
endfunction
```
| Algorithme | n = 10 | n = 100 | n = 1000 | n = 2000 |
| :--------- | -----: | ------: | -------: | -------: |
| matmat3b   | 5.27ms | 4.24s   | >5min    | >10min   |
| matmat2b   | 2.64ms | 0.21s   | 63s      | >5min    |
| matmat1b   | 0.39ms | 4.37ms  | 1.07s    | 7.34s    |
| scilab A*B | 0.09ms | 0.22ms  | 76.9ms   | 0.94s    |

> *Les résultats sont répété plusieurs fois puis moyennés.*<br>

Les performances sont fortement dégradées par les boucles imbriquées.<br>
La complexité temporelle des algorithmes est théoriquement la même pour tous de l'ordre de *O(n<sup>3</sup>)*, cependant Scilab gère mieux nativement les produits de matrices/scalaire que lorsqu'on le fait soit même.<br>
Il faut prioriser l'usage des `:` plutôt que faire de multiples boucles, quand c'est possible.

## TP - 3
### Exercice 2.

 - *usolve*
```scilab
function [x] = usolve(U,b)
    n = size(b)(1)
    x = zeros(n,1)
    x(n) = b(n)/U(n,n)
    for i=n-1:-1:1
        x(i) = (b(i) - U(i, (i+1):n) * x((i+1):n) )/U(i,i)
    end
endfunction
```
 - *lsolve*
```scilab
function [x] = lsolve(L,b)
    n = size(b)(1)
    x = zeros(n,1)
    x(1) = b(1)/L(1,1)
    for i=2:n        
        x(i) = (b(i) - L(i, 1:(i-1)) * x(1:(i-1)) )/L(i,i)
    end
endfunction
```

| n    | Δtemps exec. | temps exec. | err. avant | err. arrière |
| ---: | -----------: | ----------- | ---------: | -----------: |
| 4    | 0.07ms       | 0.08ms      | 6.065D-17  | 1.453D-17    |
| 10   | 0.17ms       | 0.18ms      | 3.957D-16  | 1.555D-17    |
| 30   | 0.53ms       | 0.54ms      | instable   | 9.577D-18    |
| 50   | 48.7ms       | 48.8ms      | instable   | 2.953D-15    |
| 100  | 1.12s        | 1.12s       | 2.377D+10  | 4.284D-15    |
> *Les résultats sont répété plusieurs fois puis moyennés.*<br>

Pour `n < 30` les deux algorithmes converge très souvent vers le vecteur de référence `x = A\b`.<br>
L'erreur avant est généralement de l'ordre de 10<sup>-15</sup> mais atteint occasionnelement 10<sup>+9</sup>.<br>
L'erreur arrière est de l'ordre de 10<sup>-18</sup>.<br>
La différence de temps d'éxecution entre `usolve` (ou `lsolve`) et `\` est de l'ordre de `+0.01ms`.<br>

La moyenne classique n'est pas très pratique pour calculer l'*erreur avant* quand elle est instable, 
les gros nombres *fausse* le resultat, <br>
On peut à la place moyenné le `log` de l'erreur puis prendre l'`exp` :

| n    | err. avant |
| ---: | ---------: |
| 30   | 1.013D-15  |
| 50   | 2.120D-13  |
| 70   | 0.1171643  |
| 90   | 6.628D+3   |
| 100  | 5.356D+10  |

On remarque que le résultat donné n'est plus vraiment fiable pour `n > 70`, 
c'est à cause de la division par `U(i,i)` *(ou `L(i,i)`)*, 
les chances qu'un nombre aléatoire proche de 0 soit rencontré sur la diagonale augmente avec n.<br>
Pour `n > 100` les deux algorithmes l'erreur avant explose.


### Exercice 3.

```scilab
function [x] = gausskij3b(A,b)
    n = size(A)(1)
    for k=1:n-1
        for i = k+1:n
            m = A(i,k)/A(k,k)
            b(i) = b(i) - m*b(k)
            for j = k+1:n
                A(i,j) = A(i,j) - m*A(k,j)
            end
        end
    end
    x = usolve(A,b)
endfunction
```

| n    | Δtemps exec. | temps exec. | err. avant | err. arrière |
| ---: | -----------: | ----------- | ---------: | -----------: |
| 4    | 0.020ms      | 0.21ms      | 3.516D-15  | 3.838D-16    |
| 10   | 2.03ms       | 2.04ms      | 2.464D-14  | 6.275D-16    |
| 30   | 48.7ms       | 48.8ms      | 3.591D-13  | 2.953D-15    |
| 100  | 1.12s        | 1.12s       | 1.361D-12  | 4.284D-15    |

> *`Δtemps exec.` : différence de temps d'execution entre la fonction `gausskij3b` et `\`*<br>
> *Les résultats sont répété plusieurs fois puis moyennés.*<br>

Même pour `n = 100`, l'erreur avant ne diverge généralement pas (pour des matrices aléatoires).
On remarque le temps d'execution de `\` est négligeable devant celui de `gausskij3b`.

### Exercice 4.

 - *mylu3b*
```scilab
function [L,U] = mylu3b(A)
    n = size(A)(1)
    for k = 1 : n-1
        for i = k+1 : n
            A(i,k) = A(i,k)/A(k,k)
        end
        for i = k+1 : n
            for j = k+1 : n
                A(i,j) = A(i,j) - A(i,k) * A(k,j)
            end
        end
    end
    U = triu(A)
    L = A - U + eye(n,n)
endfunction
```

| n    | temps exec.  | `norm(A-LU)` |
| ---: | -----------: | ------------ |
| 4    | 0.16ms       | 1.332D-16    |
| 10   | 2.27ms       | 1.837D-15    |
| 30   | 61.2ms       | 9.462D-14    |
| 50   | 0.27s        | 4.661D-14    |
| 100  | 1.74s        | 1.239D-13    |

> *Les résultats sont répété plusieurs fois puis moyennés.*<br>

 - *mylu1b*

```scilab
function [L,U] = mylu1b(A)
    n = size(A)(1)
    for k = 1 : n-1
        A(k+1:n, k) = A(k+1:n, k)/A(k,k)
        A(k+1:n, k+1:n) = A(k+1:n,k+1:n) - A(k+1:n,k) * A(k,k+1:n)
    end
    U = triu(A)
    L = A - U + eye(n,n)
endfunction
```

| n    | temps exec. , `3b` | `norm(A-LU)` , `3b` |  temps exec. , `1b`  | `norm(A-LU)` , `1b` |
| ---: | -----------------: | ------------------- | -------------------- | ------------------- |
| 4    | 0.16ms             | 1.332D-16           | 0.11ms               | 1.558D-16           |
| 10   | 2.27ms             | 1.837D-15           | 0.31ms               | 1.679D-14           |
| 30   | 61.2ms             | 9.462D-14           | 1.26ms               | 2.803D-14           |
| 50   | 0.27s              | 4.661D-14           | 2.68ms               | 4.524D-14           |
| 100  | 1.74s              | 1.239D-13           | 11.5ms               | 1.625D-13           |

> *Les résultats sont répété plusieurs fois puis moyennés.*<br>

 - *mylu*
 
```scilab
function [L,U,P] = mylu(A)
    n = size(A)(1)
    P = eye(A)
    for k = 1 : n-1
        [piv, ind] = max(abs(A(k:n,k)))
        ind = k - 1 + ind
        if ind ~= k then
            new = A(ind,:)
            A(ind,:) = A(k,:)
            A(k,:) = new
            tmp = P(:, ind)
            P(:, ind) = P(:, k)
            P(:, k) = tmp
        end
        A(k+1:n, k) = A(k+1:n, k)/A(k,k)
        A(k+1:n, k+1:n) = A(k+1:n,k+1:n) - A(k+1:n,k) * A(k,k+1:n)
    end
    U = triu(A)
    L = A - U + eye(n,n)
endfunction
```

 - *fonction de test*
 
 ```scilab
 function [] = perf_mylu(n, nb_loop)
    time = 0; err = 0;
    for i=1:nb_loop
        A = rand(n,n);
        tic(); [L, U, P] = mylu(A)
        time = time + toc()
        err = err + norm(A-P*L*U)/norm(A)
    end
    disp("Erreur : " + string(err/nb_loop))
    disp("Temps exec. : " + string(time/nb_loop))
endfunction
 ```

| n    | `mylu`, temps exec.  | `mylu`, `norm(A-LU)/norm(A)` |  `lu`, temps exec. | `lu`, `norm(A-LU)/norm(A)` |
| ---: | -------------------: | ---------------------------- | ------------------ | -------------------------- |
| 4    | 0.26ms               | 1.962D-17                    | 0.01ms             | 0.3479102                  |
| 10   | 0.88ms               | 6.185D-17                    | 0.01ms             | 0.4571869                  |
| 30   | 3.12ms               | 9.030D-17                    | 0.02ms             | 0.3075666                  |
| 50   | 6.32ms               | 1.036D-16                    | 0.06ms             | 0.2460342                  |
| 100  | 19.8ms               | 1.235D-16                    | 0.25ms             | 0.1789988                  |

> *Les résultats sont répété plusieurs fois puis moyennés.*<br>

On remarque que la fonction `lu` est beaucoup plus rapide mais elle est moins précise. (?) <br>
Cependant lorsque l'on ne demande pas _la matrice de permutation_ à `lu`, les erreurs redeviennent correctes (exemple pour *n = 100* : `erreur = 1.241D-16`).<br>
Comparé à la méthode `1b`, `mylu` ne demande que 2 fois plus de temps mais gagne jusqu'à 3 chiffres significatifs sur l'erreur grâce aux pivots bien choisis.

## Annexe

code source : https://github.com/ggdoe/tp-cn-2-3-ggdoe
