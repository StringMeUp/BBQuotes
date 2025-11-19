//
//  EpisodeView.swift
//  bbquotes
//
//  Created by Samir Ramic on 18.11.25.
//
import SwiftUI

struct EpisodeView: View {
    
    var vm: ViewModel = ViewModel()
    @State private var isExpanded = false
    @State private var extraPadding: CGFloat = 0

    var body: some View {
        ScrollViewReader { proxy in
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
                
                VStack(alignment: .leading) {
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
                    
                    DisclosureGroup(
                        "Characters in this episode:",
                        isExpanded: $isExpanded
                    ) {
                        VStack(alignment: .leading) {
                            ForEach(
                                vm.episode.characters,
                                id: \.self
                            ){ character in
                                Text(character)
                                    .font(.caption)
                                    .id(character)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .tint(.primary)
                    .onChange(of: isExpanded) { oldValue, newValue in
                        if newValue {
                            if vm.episode.characters.last != nil {
                                withAnimation {
                                    proxy.scrollTo(vm.episode.characters.last!, anchor: .bottom)
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 24).border(.red, width: 1)
                }
            }
            .preferredColorScheme(.dark)
            .padding(.horizontal)
            .padding(.vertical)
            .background(.thinMaterial)
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    let vm = ViewModel()
    EpisodeView(vm: vm)
}
