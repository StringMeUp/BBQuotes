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
                
            Tab("Breaking Bad", systemImage: "cooktop") {
                QuoteView(show: "Breaking Bad")
            }
                
            Tab("Better Call Saul", systemImage: "hammer") {
                QuoteView(show: "Better Call Saul")
            }
            
            Tab("El Camino", systemImage: "car") {
                QuoteView(show: "El Camino")
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
