slug="how_not_to_build_a_website.md"
title="How not to Build a Website: Part One"
description="How complicated can you make a static site?"
file_path="./blogs/${slug}"
contents="$(cat "$file_path")"
contents="$(echo "$contents" | sed "s/'/''/g" | sed 's/"/\\"/g')"

sql="INSERT INTO blogs (title, slug, description, content, date) VALUES('${title}', '${slug}', '${description}', "
sql="${sql} '${contents}'"
sql="${sql}, date());"

sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 1);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 3);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 4);"
sql="${sql} INSERT INTO blog_tags VALUES('${slug}', 5);"

echo "$sql" | turso db shell $TURSO_DATABASE
