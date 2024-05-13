slug="how_to_build_a_website.md"
title="How to Build a Website: Part Two"
description="Combing Ocaml, HTMX, Go, NIx, etc to make a simple website."
file_path="./blogs/${slug}"
contents="$(cat "$file_path")"
contents="$(echo "$contents" | sed "s/'/''/g")"
tags="Nix, htmx, webdev, Ocaml, Go, C"

sql="INSERT INTO blogs (title, slug, description, content, tags, date) VALUES('${title}', '${slug}', '${description}', '${contents}', '${tags}', date());"

echo "$sql" | turso db shell $TURSO_DATABASE_NAME
