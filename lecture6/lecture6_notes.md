# CONTROL VERSION SYSTEMS

#### Git terminology
Folder -> Tree

file -> blob

snapshot -> commit

### Git Staging Area:
Es donde se "guardan" los cambios que uno quiere que esten en el "snapshot" que vamos a hacer. Puede haber un caso de uso donde uno no quiera sacar un snapshot del estado actual del repositorio de todos los archivos, sino solo de algunos. Esos algunos se mandan a la staging area y luego se commitean.

para enviar a la staging area se usa `git add`

```sh
git add file.txt
```

para guardar la snapshot o el commit, `git commit`

```sh
git commit
```

### Git hashes
Cuando se hace un commit se printea un mensaje del siguiente estilo:

```sh
~$ git commit -m "notes: lecture6"
[master dd4e8ab] notes: lecture6
 2 files changed, 30 insertions(+)
 create mode 100644 lecture6/lecture6_notes.md
```
donde aparece `[master dd4e8ab]` que es la rama en la que estoy trabajando y algunos caracteres del hash de ese commit. Puedo conseguir algo de información usando esa info y el comando `git cat-file -p <hashnumbe>`, por ejemplo

```sh
git cat-file -p dd4e8ab
```
y eso va a devolverme lo siguiente
```sh
tree ae8b0764a757540c31bb665978be7fc1a094fec6
parent 6052df8efc8de9053e4267289d9fccd047bb7625
author Igna <ignaao@gmail.com> 1685315981 -0300
committer Igna <ignaao@gmail.com> 1685315981 -0300

notes: lecture6
```
donde está el hash del "tree", el hash del "parent" del commit, el autor de los cambios y el autor del commit. Además las notas que se agregaron al commit. Se puede repetir el commando con el hash del tree, ejemplo:
```sh
git cat-file -p ae8b0764a757540c31bb665978be7fc1a094fec6
```
y esto devuelve
```sh
100644 blob fa2efe76c8c1237206a30243e7fd63cf5204deb3	README.md
040000 tree 8ae93414a196335ab543a1fc7ae829751df158d0	lecture1
040000 tree 20b569dc3fd6ba7c8f685ed02affd916202537c4	lecture2
040000 tree 439b1b607beaa7cf6fa970170e609d4e17198b3b	lecture4
040000 tree 9edb78abb750c0019905f4a8288af7dd904aa490	lecture6
```
el contenido de ese "tree", que en este caso es un "blob" (file) que es el `README.md`, y los trees (folders) que son son las lectures.

Se puede seguir indagando, puedo printear lo que está en el hash del `README.md` o de cualquiera de los trees, por ejemplo para el `README.md`
```sh
~$ git cat-file -p fa2efe76c8c1237206a30243e7fd63cf5204deb3

# MIT - missing-semester-2020

Una serie de [11 Lectures](https://missing.csail.mit.edu/) para aprender a usar de forma más eficiente linux, que fue dictada por el M.I.T en 2020. Voy a usar este espacio para guardar los scripts o lo que crea necesario guardar.

```

o por ejemplo, del tree de la lecture6

```sh
~$ git cat-file -p 9edb78abb750c0019905f4a8288af7dd904aa490

100644 blob 64d698766db89e7707e955fbba876b21d3d34246	lecture6_notes.md
```

donde ahora hay otro blob con otro hash para poder explorar:

```sh
~$ git cat-file -p 64d698766db89e7707e955fbba876b21d3d34246

# CONTROL VERSION SYSTEMS

#### Git terminology
Folder -> Tree

file -> blob

snapshot -> commit

### Git Staging Area:
Es donde se "guardan" los cambios que uno quiere que esten en el "snapshot" que vamos a hacer. Puede haber un caso de uso donde uno no quiera sacar un snapshot del estado actual del repositorio de todos los archivos, sino solo de algunos. Esos algunos se mandan a la staging area y luego se commitean.

para enviar a la staging area se usa `git add`

\```sh
git add file.txt
\```

para guardar la snapshot o el commit, `git commit`

\```sh
git commit
\```

### Git hashes
```

printea todo el contenido actual del archivo.

# EJERCICIOS:
1. - [ ] If you don’t have any past experience with Git, either try reading the first couple chapters of [Pro Git](https://git-scm.com/book/en/v2) or go through a tutorial like [Learn Git Branching](https://learngitbranching.js.org/). As you’re working through it, relate Git commands to the data model.
2. - [ ] Clone the repository for the [class website](https://github.com/missing-semester/missing-semester)
	1. - [ ] Explore the version history by visualizing it as a graph.
	2. - [ ] Who was the last person to modify `README.md`? (Hint: use `git log` with an argument).
	3. - [ ] What was the commit message associated with the last modification to the `collections`: line of `_config.yml`? (Hint: use git blame and git show).
