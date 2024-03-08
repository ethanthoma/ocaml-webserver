package blog

import "time"

type Blog struct {
    Slug        string
    Title       string
    Description string
    Content     string
    Date        time.Time
    Tags        []string
}
