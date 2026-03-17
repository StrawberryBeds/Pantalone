//
//  CardDataSource.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//


struct CardSet: Identifiable, Equatable, Hashable {
    let id: Int
    let setName: String
    let setImage: String
    let cardImages: [String]
    let cardNames: [String]
    let leaderboardIDs: [String]
//    let achievementIDs: [String]
    
    // Generate slide-specific leaderboard IDs for each card image
    var slideLeaderboardIDs: [String] {
        cardImages.map { imageName in
            "com.pantalone.slide.\(setName.lowercased()).\(imageName).lb.com"
        }
    }
}

struct CardDataSource {
    static let cardSets: [CardSet] = [
        CardSet(
            id: 2,
            setName: "Birds",
            setImage: "mallard",
            cardImages: ["barn_owl", "blackbird", "cockerel", "cormorant", "goose", "kingfisher", "mallard", "red_kite", "robin", "sea_gull"],
            cardNames: ["Barn Owl", "Blackbird", "Cockerel", "Cormorant", "Goose", "Kingfisher", "Mallard", "Red Kite", "Robin", "Sea Gull"],
            leaderboardIDs: ["com.pantalone.match.lb.birds"]
//            achievementIDs: ["com.pantalone.match.ac.birds"]
        )
    ]
}

//        CardSet(
//            id: 1,
//            setName: "Emojis",
//            setImage: "smiley_1F60A",
//            cardImages: ["balloon_1F388", "cake_1F382", "cat_1F431", "dog_1F436", "dragon_1F409", "octopus_1F419", "pheonix_1F426-200D-1F525", "rofl_1F923", "smiley_1F60A", "unicorn_1F984"],
//            leaderboardIDs: ["com.pantalone.match.lb.emojis"],
//            achievementIDs: ["com.pantalone.match.ac.emojis"]
//        ),

