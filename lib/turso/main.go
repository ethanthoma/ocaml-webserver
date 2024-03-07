package main

// #cgo CFLAGS: -fpic
// #include <stdlib.h>
import "C"

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"os"
	"strings"
	"time"

	_ "github.com/tursodatabase/libsql-client-go/libsql"
)

var database = os.Getenv("TURSO_DATABASE")
var token = os.Getenv("TURSO_DATABASE_TOKEN")

var db *sql.DB

type Blog struct {
    Title       string
    Slug        string
    Description string
    Content     string
    Date        time.Time
    Tags        []string
}

//export Init
func Init() {
    url := fmt.Sprint("libsql://", database, ".turso.io?authToken=", token)

    var err error
    db, err = sql.Open("libsql", url)
    if err != nil {
        fmt.Fprintf(os.Stderr, "failed to open db %s: %s", url, err)
        os.Exit(1)
    }
}

//export GetBlogTable
func GetBlogTable() *C.char {
    rows, err := db.Query(`
    SELECT 
        b.title, 
        b.slug, 
        b.description, 
        b.content, 
        b.date,
    GROUP_CONCAT(t.tag_name) AS tags
    FROM 
        blogs b
    LEFT JOIN 
        blog_tags bt ON b.slug = bt.blog_id
    LEFT JOIN 
        tags t ON bt.tag_id = t.tag_id
    GROUP BY 
        b.slug;
    `)
    if err != nil {
        fmt.Fprintf(os.Stderr, "failed to execute query: %v\n", err)
        return C.CString("")
    }
    defer rows.Close()

    var blogs []Blog

    for rows.Next() {
        var blog Blog

        var tags sql.NullString

        if err := rows.Scan(
            &blog.Title, 
            &blog.Slug,
            &blog.Description,
            &blog.Content, 
            &blog.Date,
            &tags,
            ); err != nil {
            fmt.Println("Error scanning row:", err)
            return C.CString("")
        }

        if tags.Valid {
            blog.Tags = strings.Split(tags.String, ",")
        } else {
            blog.Tags = []string{}
        }

        blogs = append(blogs, blog)
    }

    if err := rows.Err(); err != nil {
        str := fmt.Sprint("Error during rows iteration:", err)
        fmt.Println(str)
        return C.CString(str)
    }

    jsonBlogs, err := json.Marshal(blogs)
    if err != nil {
        str := fmt.Sprint("Error marshaling blogs:", err)
        fmt.Println(str)
        return C.CString(str)
    }

    return C.CString(string(jsonBlogs))
}

//export GetBlogBySlug
func GetBlogBySlug(slugC *C.char) *C.char {
    slug := C.GoString(slugC)

    rows, err := db.Query(fmt.Sprint(`
    SELECT 
        b.title,
        b.slug,
        b.description,
        b.content,
        b.date,
    GROUP_CONCAT(t.tag_name) AS tags
    FROM 
        blogs b
    LEFT JOIN 
        blog_tags bt ON b.slug = bt.blog_id
    LEFT JOIN 
        tags t ON bt.tag_id = t.tag_id
    WHERE
        b.slug = '`,slug,`'
    GROUP BY 
        b.slug;
    `))
    if err != nil {
        fmt.Fprintf(os.Stderr, "failed to execute query: %v\n", err)
        return C.CString("")
    }
    defer rows.Close()

    var blog Blog

    for rows.Next() {
        var tags sql.NullString

        if err := rows.Scan(
            &blog.Title, 
            &blog.Slug,
            &blog.Description,
            &blog.Content, 
            &blog.Date,
            &tags,
            ); err != nil {
            fmt.Println("Error scanning row:", err)
            return C.CString("")
        }

        if tags.Valid {
            blog.Tags = strings.Split(tags.String, ",")
        } else {
            blog.Tags = []string{}
        }
    }

    if err := rows.Err(); err != nil {
        str := fmt.Sprint("Error during rows iteration:", err)
        fmt.Println(str)
        return C.CString(str)
    }

    jsonBlog, err := json.Marshal(blog)
    if err != nil {
        str := fmt.Sprint("Error marshaling blogs:", err)
        fmt.Println(str)
        return C.CString(str)
    }

    return C.CString(string(jsonBlog))
}


func main() {}
