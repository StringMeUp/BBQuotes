//
//  QuoteSuccessItem.swift
//  bbquotes
//
//  Created by Samir Ramic on 18.11.25.
//
import SwiftUI

struct EpisodeSuccessItem: View {
    
    var vm: ViewModel = ViewModel()

    var body: some View {

        ScrollView() {
            Spacer()
            Text(vm.episode.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.white)
     
                
            AsyncImage(url: vm.episode.image) { Image in
                Image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .clipShape(.rect(cornerRadius: 25))
                
            Text("Air date: \(vm.episode.synopsis)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.default)
                .foregroundStyle(.white)
                .padding(.top, 10)
                
            VStack {
                Text("Air date: \(vm.episode.airDate)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundStyle(.white)
                    
                Text("Production: \(vm.episode.production)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundStyle(.white)
                    
                Text("Written by: \(vm.episode.writtenBy)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
                    .foregroundStyle(.white)
            }.padding(.vertical, 10)
        }
        .preferredColorScheme(.dark)
        .padding(.horizontal)
        .padding(.vertical)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 25))
        .padding(.bottom, 60)
        .padding(.horizontal, 25)

    }
}

#Preview {
    let vm = ViewModel()
    EpisodeSuccessItem(vm: vm)
}
