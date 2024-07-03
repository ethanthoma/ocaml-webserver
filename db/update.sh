slug="how_to_build_a_website.md"
file_path="./blogs/${slug}"
contents="$(cat "$file_path")"
contents="$(echo "$contents" | sed "s/'/''/g")"

sql="UPDATE blogs SET content = "
sql="${sql} '"${contents}"'"
sql="${sql} WHERE slug = '${slug}'"

echo "$sql" | turso db shell $TURSO_DATABASE_NAME
