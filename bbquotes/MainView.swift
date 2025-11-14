//
//  ContentView.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView() {
                
            Tab("Breaking Bad", systemImage: "tray.and.arrow.down.fill") {
                QuoteView(show: "Breaking Bad")
            }
                
            Tab("Better Call Saul", systemImage: "globe.fill") {
                QuoteView(show: "Better Call Saul")
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
