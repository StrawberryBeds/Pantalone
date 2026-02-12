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
    @StateObject var slideMenuViewModel: SlideMenuViewModel
    @Environment(\.colorScheme) var colorScheme
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    
    let cream = Color("Cream")
    
//    let columns = [
//        GridItem(.flexible(), spacing: 5),
//        GridItem(.flexible(), spacing: 5),
        //        GridItem(.flexible(), spacing: 5),
        //        GridItem(.flexible(), spacing: 5),
        //        GridItem(.flexible(), spacing: 5)
//    ]
    
    var body: some View {
        NavigationStack {
                Text("Slide!")
                    .font(customTitle)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                //                    .padding()
                Text("Choose a card to slide.")
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
//                    .padding()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(slideMenuViewModel.slideImages) { slideImage in
                            NavigationLink(
                                tag: slideImage,
                                selection: $slideMenuViewModel.navigationSelection,
                                destination: {
                                    SlideView()
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
