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
                
            Tab(Constants.bbName, systemImage: "cooktop") {
                TabItemView(show: Constants.bbName)
            }
                
            Tab(Constants.bcsName, systemImage: "hammer") {
                TabItemView(show: Constants.bcsName)
            }
            
            Tab(Constants.ecName, systemImage: "car") {
                TabItemView(show: Constants.ecName)
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
