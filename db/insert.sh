slug="how_to_build_a_website.md"
title="How to Build a Website: Part Two"
description="Being JS free with the HOT stack (htmx, Ocaml, Turso)."
file_path="./blogs/${slug}"
contents="$(cat "$file_path")"
contents="$(echo "$contents" | sed "s/'/''/g" | sed 's/"/\\"/g')"

sql="INSERT INTO blogs (title, slug, description, content, date) VALUES('${title}', '${slug}', '${description}', "
sql="${sql} '${contents}'"
sql="${sql}, date());"

sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 1);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 2);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 3);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 5);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 6);"

echo "$sql" | turso db shell my-db
