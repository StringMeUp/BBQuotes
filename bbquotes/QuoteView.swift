//
//  QuoteView.swift
//  bbquotes
//
//  Created by Samir Ramic on 14.11.25.
//

import Foundation
import SwiftUI

struct QuoteView: View {
    let vm: ViewModel = ViewModel()
    var show: String
    
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
                        Text("\"\(vm.quote.quote)\"")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(.black.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .padding(.horizontal)
                        
                        ZStack(alignment: .bottom) {
                            AsyncImage(url: vm.character.images[0]) { Image in
                                Image.resizable()
                                    .scaledToFill()
                            } placeholder: {
                                ProgressView()
                            }.frame(
                                width: geo.size.width / 1.1,
                                height: geo.size.height / 1.8)
                            .clipShape(.rect(cornerRadius: 25))
                            
                            Text(vm.character.name)
                                .foregroundStyle(.white)
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                        }.frame(
                            width: geo.size.width / 1.1,
                            height: geo.size.height / 1.8)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding()
                        
                    case .failure(let error):
                        Text(
                            "An error has occured: \(error.localizedDescription)"
                        )
                    }
                    Spacer()
                }
             
                Button {
                    Task {
                        await vm.getData(for: show)
                    }
                } 
                label: {
                    Text("Get Random Quote")
                        .padding()
                        .background(
                            self.show == "Breaking Bad" ? .bbGreen: .bcsBlue
                        )
                        .foregroundStyle(.white)
                        .frame(width: geo.size.width / 2, height: 54)
                        .clipShape(.rect(cornerRadius: 25))
                        .shadow(color: .bbYellow,  radius: 2)
                }
                Spacer(minLength: 95)
            }.frame(width: geo.size.width, height: geo.size.height)
        }.ignoresSafeArea()
    }
}

#Preview {
    QuoteView(show: "Breaking Bad")
}
