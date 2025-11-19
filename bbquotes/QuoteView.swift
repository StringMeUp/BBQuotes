//
//  QuoteView.swift
//  bbquotes
//
//  Created by Samir Ramic on 18.11.25.
//
import SwiftUI

struct QuoteView: View {
    
    var vm: ViewModel = ViewModel()
    @Binding var showCharacter: Bool
    
    var body: some View {
        VStack {
            Text("\"\(vm.quote.quote)\"")
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.white)
                .padding()
                .background(.black.opacity(0.5))
                .clipShape(.rect(cornerRadius: 25))
                .padding(.horizontal)
            
            GeometryReader { geo in
                ZStack(alignment:.bottom) {
                    VStack(alignment: .leading) {
                        AsyncImage(url: vm.character.images[0]) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width / 1.1, height: geo.size.height)
           
                        } placeholder: {
                            ProgressView()
                        }
                        .clipShape(.rect(cornerRadius: 25))
                        .onTapGesture { showCharacter.toggle() }
                    }
                        
                    Text(vm.character.name)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .background(.ultraThinMaterial)
                        .foregroundStyle(.white)
                }
                .frame(width: geo.size.width / 1.1)
                .clipShape(.rect(cornerRadius: 25))
                .padding(.horizontal)
                      
            }
            .frame(maxWidth: .infinity)
            .clipShape(.rect(cornerRadius: 25))
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var showCharacter: Bool = false
    let vm = ViewModel()
    QuoteView(vm: vm, showCharacter: $showCharacter)
}
