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

