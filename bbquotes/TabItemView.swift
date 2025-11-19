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
                
                HStack {
                    Button {
                        Task {
                            await vm.getQuoteData(for: show)
                        }
                    }
                    label: {
                        Text("Get Random\nQuote")
                            .padding(24)
                            .background(Color(show.removeSpaces()))
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding()
                            .shadow(
                                color: Color("\(show.removeSpaces())Shadowcolor"),
                                radius: 2
                            )
                    }
                    
                    Button {
                        Task {
                            await vm.getRandomEpisode()
                        }
                    }
                    label: {
                        Text("Get Random\nEpisode")
                            .padding(24)
                            .background(Color(show.removeSpaces()))
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding()
                            .shadow(
                                color: Color("\(show.removeSpaces())Shadowcolor"),
                                radius: 2
                            )
                    }
                }
                .frame(width: geo.size.width)
             
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
    TabItemView(show: "Breaking Bad")
}
