package main

import (
	"log"
	"os"

	"github.com/rumblefrog/go-a2s"
)

func main() {
	host := "localhost"
	port := getEnv("SRCDS_PORT", "27015")
	addr := host + ":" + port

	client, err := a2s.NewClient(addr)
	if err != nil {
		log.Print(err)
		os.Exit(1)
	}

	info, err := client.QueryInfo()
	if err != nil {
		log.Print(err)
		os.Exit(1)
	}

	log.Printf("GAME: %s, HOSTNAME: %s, MAP: %s, PLAYERS: %d/%d", info.Game, info.Name, info.Map, info.Players, info.MaxPlayers)
	os.Exit(0)
}

func getEnv(key string, def string) string {
	value, ok := os.LookupEnv(key)
	if !ok {
		return def
	}
	return value
}
