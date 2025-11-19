//
//  CharacterView.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//

import SwiftUI

struct CharacterView: View {
    
    let character: BbCharacter
    let show: String
    let bottomID = 1
    var isDetail: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    if isDetail {
                        Image(
                            show
                            .lowercased()
                            .replacingOccurrences(of: " ", with: "")
                        )
                        .resizable()
                        .scaledToFit()
                    }
                    
                    ScrollView {
                        TabView {
                            ForEach(character.images, id: \.self) { url in
                                AsyncImage(url: url) { Image in
                                    Image.resizable()
                                        .scaledToFill()
                                       
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .frame(height: geo.size.height / 1.8)
                        .clipShape(.rect(cornerRadius: 25))
                        .tabViewStyle(PageTabViewStyle())
                        .padding(.horizontal, !isDetail ? 24 : 0)
                        .padding(.top, !isDetail ? 24 : 0)
                        
                        VStack(alignment: .leading) {
                            Spacer(minLength: 24)
                            
                            Text(character.name)
                                .font(.largeTitle)
                            
                            Text("Portrayed by:\(character.portrayedBy)")
                                .font(.subheadline)
                            Divider()
                            
                            Text("\(character.name) Character Info:")
                                .font(.title2)
                            Text("Born: \(character.birthday)")
                            Divider()
                            
                            Text("Occupations:")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.bottom, 5)
                            
                            ForEach(character.occupations, id: \.self) { occ in
                                Text("• \(occ)")
                            }
                            Divider()
                            
                            Text("Nicknames:")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.bottom, 5)
                            if character.aliases.isEmpty {
                                Text("• None")
                            }else{
                                ForEach(
                                    character.aliases,
                                    id: \.self
                                ) { alias in
                                    Text("• \(alias)")
                                }
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (spoiler alert)") {
                                VStack(alignment: .leading, spacing: 24) {
                                    Text("\(character.status)")
                                        .font(.title3)
                                    
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { Image in
                                            Image.resizable()
                                                .scaledToFill()
                                                .onAppear {
                                                    withAnimation {
                                                        proxy.scrollTo(
                                                            bottomID, anchor: .bottom)}
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .clipShape(.rect(cornerRadius: 25))
                                        
                                        Text("How: \(death.details)")
                                            .font(.default)
                                        
                                        Text("Last words: \(death.lastWords)")
                                            .font(.default)
                                           
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .tint(.primary)
                        }
                        .frame(
                            width: geo.size.width / 1.25,
                            alignment: .leading
                        )
                        .padding(.bottom, 50)
                        .id(bottomID)
                        
                    }
                    .scrollIndicators(.hidden)
                    .frame(
                        width: isDetail ? geo.size.width / 1.2 : geo.size.width
                    )
                    .padding(.top, 60)
                }
            }
        }
        .preferredColorScheme(ColorScheme.dark)
        .ignoresSafeArea()
    }
}

#Preview {
    let vm = ViewModel()
    CharacterView(character: vm.character, show: "Breaking Bad")
}
