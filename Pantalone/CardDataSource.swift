//
//  CardDataSource.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//


struct CardDataSource {
    static let cardSets: [CardSet] = [
        CardSet(
            id: 1,
            setName: "Emojis",
            cardImages: ["balloon_1F388", "cake_1F382", "cat_1F431", "dog_1F436", "dragon_1F409", "octopus_1F419", "pheonix_1F426-200D-1F525", "rofl_1F923", "smiley_1F60A", "unicorn_1F984"],
            leaderboardIDs: ["retention.lb.emojis"]
        ),
        CardSet(
            id: 2,
            setName: "Constellations",
            cardImages: ["Carina", "Cassiopeia", "Centaurus", "Crux", "Cygnus", "Leo", "Orion", "Scorpius", "UrsaMajor", "UrsaMinor"],
            leaderboardIDs: ["retention.lb.constellations"]
        )
    ]
}