package blog

import (
    "database/sql"
    "encoding/json"
    "fmt"
    "strings"

    db "github.com/ethanthoma/webserver/lib/turso/pkg/database"
)

func rowsToBlogs (rows *sql.Rows) ([]Blog, error) {
    var blogs []Blog

    for rows.Next() {
        var blog Blog

        var tags string

        if err := rows.Scan(
            &blog.Slug,
            &blog.Title, 
            &blog.Description,
            &blog.Content, 
            &blog.Date,
            &tags,
            ); err != nil {
            fmt.Println("Error scanning row:", err)
            return nil, err
        }

        blog.Tags = strings.Split(tags, ",")

        blogs = append(blogs, blog)
    }

    if err := rows.Err(); err != nil {
        str := fmt.Sprint("Error during rows iteration:", err)
        fmt.Println(str)
        return nil, err
    }

    return blogs, nil
}

func GetBlogTable() (string, error) {
    rows, err := db.DB.Query(`
        SELECT
            *
        FROM
            blogs
        ORDER BY
            date
        DESC;
    `)
    if err != nil {
        return "", err
    }
    defer rows.Close()

    blogs, err := rowsToBlogs(rows)
    if err != nil {
        return "", err
    }

    jsonBlogs, err := json.Marshal(blogs)
    if err != nil {
        return "", err
    }

    return string(jsonBlogs), nil
}

func GetBlogBySlug(slug string) (string, error) {
    rows, err := db.DB.Query(fmt.Sprint(`
        SELECT 
            *
        FROM 
            blogs
        WHERE
            slug = '`,slug,`'
        ;
    `))
    if err != nil {
        return "", err
    }
    defer rows.Close()

    blogs, err := rowsToBlogs(rows)
    if err != nil {
        return "", err
    }

    if len(blogs) == 0 {
        return "", err
    }

    blog := blogs[0]

    jsonBlog, err := json.Marshal(blog)
    if err != nil {
        return "", err
    }

    return string(jsonBlog), nil
}
