package database

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/tursodatabase/libsql-client-go/libsql"
)

var DB *sql.DB

func Init(database string, token string) {
    url := fmt.Sprintf("libsql://%s.turso.io?authToken=%s", database, token)

    var err error
    DB, err = sql.Open("libsql", url)
    if err != nil {
        fmt.Fprintf(os.Stderr, "failed to open db %s: %s", url, err)
        os.Exit(1)
    }
}
