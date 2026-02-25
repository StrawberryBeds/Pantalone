//
//  SlideMenuView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-12.
//

import SwiftUI
import GameKit
import Combine

struct SlideMenuView: View {
    @StateObject private var slideMenuViewModel: SlideMenuViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    let cream = Color("Cream")
    
    init(cardSet: CardSet) {
        _slideMenuViewModel = StateObject(wrappedValue: SlideMenuViewModel(cardSet: cardSet))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Slide!")
                    .font(customTitle)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                Text("Choose a card to slide.")
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(slideMenuViewModel.slideImages) { slideImage in
                            NavigationLink(
                                tag: slideImage,
                                selection: $slideMenuViewModel.navigationSelection,
                                destination: {
                                    SlideView(selectedImage: slideImage)
                                },
                                label: {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(Color.cream)
                                            .scaledToFit()
                                            .frame(width: 160, height: 160)
                                            .cornerRadius(16)
                                        Image(slideImage.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(16)
                                    }
                                    .onTapGesture {
                                        slideMenuViewModel.selectSlideImage(slideImage)
                                    }
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}
