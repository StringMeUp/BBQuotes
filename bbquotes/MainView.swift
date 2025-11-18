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
                TabItemView(show: "Breaking Bad")
            }
                
            Tab("Better Call Saul", systemImage: "hammer") {
                TabItemView(show: "Better Call Saul")
            }
            
            Tab("El Camino", systemImage: "car") {
                TabItemView(show: "El Camino")
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
