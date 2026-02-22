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
    let imageName: String
}

struct SlideSource {
    static let slideImages: [SlideImage] = [
        SlideImage(id: 1,imageName: "barn_owl"),
        SlideImage(id: 2, imageName: "blackbird"),
        SlideImage(id: 3, imageName: "cockerel"),
        SlideImage(id: 4, imageName: "cormorant"),
        SlideImage(id: 5, imageName: "goose"),
        SlideImage(id: 6, imageName: "kingfisher"),
        SlideImage(id: 7, imageName: "mallard"),
        SlideImage(id: 8, imageName: "red_kite"),
        SlideImage(id: 9, imageName: "robin"),
        SlideImage(id: 10, imageName: "sea_gull")
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


