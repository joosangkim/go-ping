package main

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Routes
	e.GET("/", hello)
	e.GET("/ping", ping)
	e.GET("/echo/:keyword", echoFunc)

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}

// Handler
func hello(c echo.Context) error {
	return c.String(http.StatusOK, "Hello, World!")
}

func ping(c echo.Context) error {
	return c.String(http.StatusOK, "pong")
}

func echoFunc(c echo.Context) error {
	return c.String(http.StatusOK, c.Param("keyword"))
}
