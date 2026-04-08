import SwiftUI

struct MatchMenuView: View {
    let viewModel: MenuViewModel
    let customTitle: Font
    let columns: [GridItem]

    var body: some View {
        VStack {
            Text("Match!")
                .font(customTitle)
                .foregroundColor(.black)
            Text("Match them all to win!")
                .bold()
                .foregroundColor(.black)
            
            LazyVGrid(columns: columns, spacing: 5) {
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
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(16)
                            }
                            .onTapGesture {
                                viewModel.selectCardSet(cardSet)
                            }
                        }
                    )
                }
            }
        }
    }
}
