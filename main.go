package main

import (
	"fmt"
	"net/http"
)

// Exposes key-value pairs which are separeted by a semicolon
func kvp(w http.ResponseWriter, req *http.Request) {

	m := make(map[string]string)
	m["k1"] = "v1"
	m["k2"] = "v2"
	m["k3"] = "v3"

	l := ""
	for k, v := range m {

		l += k + ":" + v + "\n"
	}
	fmt.Fprintf(w, "%v", l)
}

func main() {

	http.HandleFunc("/kvp", kvp)
	http.ListenAndServe(":8080", nil)
}
