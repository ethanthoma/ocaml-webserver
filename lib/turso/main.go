package main

// #cgo CFLAGS: -fpic 
// #include <stdlib.h>
import "C"

import (
    "database/sql"
    "encoding/json"
	"fmt"
    "os"
    _ "github.com/tursodatabase/libsql-client-go/libsql"
)

var db *sql.DB

type Blog struct {
    ID      int
    Content sql.NullString
    Title   sql.NullString
    Release sql.NullString
}

//export Init
func Init() {
    database := os.Getenv("TURSO_DATABASE")
    token := os.Getenv("TURSO_TOKEN")
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

        if err := rows.Scan(&blog.ID, &blog.Content, &blog.Title, &blog.Release); err != nil {
            fmt.Println("Error scanning row:", err)
            return C.CString("")
        }

        blogs = append(blogs, blog)
    }

    if err := rows.Err(); err != nil {
        fmt.Println("Error during rows iteration:", err)
        return C.CString("")
    }

    jsonBlogs, err := json.Marshal(blogs)
    if err != nil {
        fmt.Println("Error marshaling blogs:", err)
        return C.CString("")
    }

    return C.CString(string(jsonBlogs))
}

func main() {}
