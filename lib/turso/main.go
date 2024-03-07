package main

// #cgo CFLAGS: -fpic 
// #include <stdlib.h>
import "C"

import (
    "database/sql"
    "encoding/json"
	"fmt"
    "os"
    "time"

    _ "github.com/tursodatabase/libsql-client-go/libsql"
)

var database = os.Getenv("TURSO_DATABASE")
var token = os.Getenv("TURSO_DATABASE_TOKEN")

var db *sql.DB

type Blog struct {
    ID          int
    Title       string
    Slug        string
    Description string
    Content     string
    Date        time.Time
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

//export QueryBlogs
func QueryBlogs() *C.char {
    rows, err := db.Query("SELECT * FROM blogs")
    if err != nil {
        fmt.Fprintf(os.Stderr, "failed to execute query: %v\n", err)
        return C.CString("")
    }
    defer rows.Close()

    var blogs []Blog

    for rows.Next() {
        var blog Blog

        if err := rows.Scan(
            &blog.ID, 
            &blog.Title, 
            &blog.Slug,
            &blog.Description,
            &blog.Content, 
            &blog.Date,
            ); err != nil {
            fmt.Println("Error scanning row:", err)
            return C.CString("")
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

func main() {}
