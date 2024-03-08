package main

// #cgo CFLAGS: -fpic
import "C"

import (
	"fmt"
	"os"

	"github.com/ethanthoma/webserver/lib/turso/pkg/blog"
	db "github.com/ethanthoma/webserver/lib/turso/pkg/database"
)

var database    = os.Getenv("TURSO_DATABASE")
var token       = os.Getenv("TURSO_DATABASE_TOKEN")

//export Init
func Init() {
    db.Init(database, token)
}

//export GetBlogTable
func GetBlogTable() *C.char {
    blogs, err := blog.GetBlogTable()
    if err != nil {
        fmt.Println("tb error")
        return nil
    }
    return C.CString(blogs)
}

//export GetBlogBySlug
func GetBlogBySlug(slug *C.char) *C.char {
    blog, err := blog.GetBlogBySlug(C.GoString(slug))
    if err != nil {
        return nil
    }
    return C.CString(blog)
}

func main() { }
