slug="how_not_to_build_a_website.md"
title="How not to Build a Website: Part One"
description="How complicated can you make a static site?"
file_path="./blogs/${slug}"
contents="$(cat "$file_path")"
contents="$(echo "$contents" | sed "s/'/''/g" | sed 's/"/\\"/g')"
tags="Nix, htmx, webdev, Bazel, Pulumi"

sql="INSERT INTO blogs (title, slug, description, content, tags, date) VALUES('${title}', '${slug}', '${description}', '${contents}', '${tags}', date());"

echo "$sql" | turso db shell $TURSO_DATABASE_NAME
