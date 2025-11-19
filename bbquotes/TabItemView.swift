//
//  QuoteView.swift
//  bbquotes
//
//  Created by Samir Ramic on 14.11.25.
//

import Foundation
import SwiftUI

struct TabItemView: View {
    
    let vm: ViewModel = ViewModel()
    var show: String
    @State var showCharacter: Bool = false
    @Binding var tabSelection: Int
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.removeCaseAndSpaces())
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
            VStack {
                VStack {
                    Spacer(minLength: 60)
                    switch vm.status {
                    case .notStatrted:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .successQuote:
                        QuoteView(
                            vm: vm,
                            showCharacter: $showCharacter
                        )
                    case .successEpisode:
                        EpisodeView(vm: vm)
                    case .failure(let error):
                        Text(
                            "An error has occured: \(error.localizedDescription)"
                        )
                    }
                    Spacer()
                }
                
                HStack(alignment: .center, spacing: 18) {
                    ButtonView(
                    action: { await vm.getQuoteData(for: show) },
                    buttonLabel: ButtonConstants.quotesButton,
                    show: show)
                    
                    ButtonView(
                        action: { await vm.getRandomEpisode()},
                        buttonLabel: ButtonConstants.episodeButton,
                        show: show
                    )
                    
                    ButtonView(
                        action: { await vm.getQuoteData(for: show) },
                        buttonLabel: ButtonConstants.characterButton,
                        show: show
                    )
                    
                }
                .frame(width: geo.size.width)
                .padding(.horizontal, 4)
            
                Spacer(minLength: 95)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear(perform: {
                Task {
                    await vm.getQuoteData(for: show)
                }
            })
            .sheet(isPresented: $showCharacter) {
                CharacterView(character: vm.character, show: show)
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    @Previewable @State var tabSelection: Int = 1
    TabItemView(show: "Breaking Bad", tabSelection: $tabSelection)
}
