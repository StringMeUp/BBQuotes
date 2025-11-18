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
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
            }.frame(width: geo.size.width, height: geo.size.height)
            
            VStack {
                VStack {
                    Spacer(minLength: 60)
                    switch vm.status {
                    case .notStatrted:
                        EmptyView()
                    case .loading:
                        ProgressView()
                    case .success:
                        if vm.isEpisode {
                            EpisodeView(vm: vm)
                        } else {
                            QuoteView(
                                vm: vm,
                                showCharacter: $showCharacter
                            )
                        }
                    case .failure(let error):
                        Text(
                            "An error has occured: \(error.localizedDescription)"
                        )
                    }
                    Spacer()
                }
                
                HStack {
               
                    let backgroundColor: Color = switch show {
                    case "Breaking Bad":
                            .bbGreen
                    case "Better Call Saul":
                            .bcsBlue
                    default:
                            .camino
                    }
                    
                    let shadowColor: Color = switch show {
                    case "Breaking Bad":
                            .bbYellow
                    default:
                            .black
                    }
                    
                    Button {
                        Task {
                            await vm.getData(for: show, isEpisode: false)
                        }
                    }
                    label: {
                        Text("Get Random\nQuote")
                            .padding(24)
                            .background(backgroundColor)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding()
                            .shadow(
                                color: shadowColor,
                                radius: 2
                            )
                    }
                    
                    Button {
                        Task {
                            await vm.getData(for: show, isEpisode: true)
                        }
                    }
                    label: {
                        Text("Get Random\nEpisode")
                            .padding(24)
                            .background(backgroundColor)
                            .foregroundStyle(.white)
                            .clipShape(.rect(cornerRadius: 25))
                            .padding()
                            .shadow(
                                color: shadowColor,
                                radius: 2
                            )
                    }
                }
                .frame(width: geo.size.width)
             
                Spacer(minLength: 95)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .sheet(isPresented: $showCharacter) {
                CharacterView(character: vm.character, show: show)
            }
            
        }.ignoresSafeArea()
    }
}

#Preview {
    TabItemView(show: "Breaking Bad")
}
