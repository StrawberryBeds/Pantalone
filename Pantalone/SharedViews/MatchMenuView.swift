import SwiftUI

struct MatchMenuView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var viewModel: MenuViewModel
    let customTitle: Font
    let columns = [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: 16)]
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Match!")
                .font(customTitle)
                .foregroundColor(.black)
            Text("Match them all to win!")
                .bold()
                .foregroundColor(.black)
            
            if viewModel.cardSets.count == 1, let cardSet = viewModel.cardSets.first {
                // Single item — centre it explicitly
                NavigationLink(
                    tag: cardSet,
                    selection: $viewModel.navigationSelection,
                    destination: {
                        MatchGameView(
                            gameLogic: viewModel.gameLogic,
                            menuViewModel: viewModel,
                            selectedCardSet: viewModel.navigationSelection
                        )
                    },
                    label: {
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.cream)
                                .scaledToFit()
                                .frame(width: 160, height: 160)
                                .cornerRadius(16)
                            Image(cardSet.setImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 160, height: 160)
                                .cornerRadius(16)
                        }
                        .onTapGesture { viewModel.selectCardSet(cardSet) }
                    }
                )
            } else {
                // Multiple items — adaptive grid
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: 16)], spacing: 16) {
                    ForEach(viewModel.cardSets) { cardSet in
                        NavigationLink(
                            tag: cardSet,
                            selection: $viewModel.navigationSelection,
                            destination: {
                                MatchGameView(
                                    gameLogic: viewModel.gameLogic,
                                    menuViewModel: viewModel,
                                    selectedCardSet: viewModel.navigationSelection
                                )
                            },
                            label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.cream)
                                        .scaledToFit()
                                        .frame(width: 160, height: 160)
                                        .cornerRadius(16)
                                    Image(cardSet.setImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 160, height: 160)
                                        .cornerRadius(16)
                                }
                                .onTapGesture { viewModel.selectCardSet(cardSet) }
                            }
                        )
                    }
                }
                .frame(maxWidth: 700)
                .frame(maxWidth: .infinity)
            }
        }
    }
}
