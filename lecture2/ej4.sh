#!/usr/bin/env bash

#si existe, elimino el zip.tar
rm htmls_using_zip.zip htmls_using_tar.tar.gz

# encuentra todos los .html recursivamente en los directorios y haceun zip (solchagpt)
find . -name "*.html" -print0 | xargs -0 -r zip -r htmls_using_zip.zip

# lo mismo pero en vez de usar zip, usa tar
find . -name '*.html' -print0 | xargs -0 tar -czvf htmls_using_tar.tar.gz
