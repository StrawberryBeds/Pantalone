//
//  MenuViewModel.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-04.
//


import SwiftUI
import GameKit
import Combine

var sortedCardSets: [CardSet] {
    CardDataSource.cardSets.sorted(by: { $0.id > $1.id })
}


class MenuViewModel: ObservableObject {
    let cardSets = sortedCardSets
    @Published var selectedCardSet: CardSet? = nil
    @Published var navigationSelection: CardSet? = nil
    let gameLogic: GameLogic
    
    init(gameLogic: GameLogic) {
        self.gameLogic = gameLogic
    }
    
    func selectCardSet(_ cardSet: CardSet) {
        selectedCardSet = cardSet
        gameLogic.selectedCardSet = cardSet
        gameLogic.handleReset()
        navigationSelection = cardSet
    }
}


struct SlideImage: Identifiable, Equatable, Hashable {
    let id: Int
    let cardSet: String
    let leaderboardID: String
    let imageName: String

}

struct SlideSource {
    static let slideImages: [SlideImage] = [
        SlideImage(id: 1, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.barn_owl.lb.com", imageName: "barn_owl"),
        SlideImage(id: 2, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.blackbird.lb.com", imageName: "blackbird"),
        SlideImage(id: 3, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.cockerel.lb.com", imageName: "cockerel"),
        SlideImage(id: 4, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.cormorant.lb.com", imageName: "cormorant"),
        SlideImage(id: 5, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.goose.lb.com", imageName: "goose"),
        SlideImage(id: 6, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.kingfisher.lb.com", imageName: "kingfisher"),
        SlideImage(id: 7, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.mallard.lb.com", imageName: "mallard"),
        SlideImage(id: 8, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.red_kite.lb.com", imageName: "red_kite"),
        SlideImage(id: 9, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.robin.lb.com", imageName: "robin"),
        SlideImage(id: 10, cardSet: "birds", leaderboardID: "com.pantalone.slide.birds.sea_gull.lb.com", imageName: "sea_gull")
    ]
}

class SlideMenuViewModel: ObservableObject {
    let slideImages = SlideSource.slideImages
    @Published var selectedSlideImage: SlideImage? = nil
    @Published var navigationSelection: SlideImage? = nil
//    let slideGameLogic = slideGameLogic
//    
//    init (slideGameLogic: SlideGameLogic) {
//        self.slideGameLogic = slideGameLogic
//    }
    func selectSlideImage (_ slideImage: SlideImage) {
        selectedSlideImage = slideImage
//        slideGameLogic.selectedSlideImage = slideImage
//        slideGameLogic.handleReset()
        navigationSelection = slideImage
    }
}


