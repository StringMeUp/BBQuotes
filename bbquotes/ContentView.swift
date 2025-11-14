//
//  ContentView.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        TabView() {
                
            Tab("Tab 1", systemImage: "tray.and.arrow.down.fill")
            {
                Text(viewModel.quote.quote)
                Text(viewModel.character.name)
                Image(systemName: "globe")
            }
                
            Tab("Tab 2", systemImage: "globe.fill")
            {
                Image(systemName: "globe.fill")
                    
            }
            
        }.task {
            await viewModel.getData(for: "Breaking Bad")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
