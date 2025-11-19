//
//  ContentView.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            TabItemView(show: ShowConstants.bbName, tabSelection: $tabSelection)
                .tabItem {
                    Text(ShowConstants.bbName)
                    Image(systemName: "cooktop")
                }.tag(1)
            
            TabItemView(show: ShowConstants.bcsName, tabSelection: $tabSelection)
                .tabItem {
                    Text(ShowConstants.bbName)
                    Image(systemName: "hammer")
                }.tag(2)
            
            TabItemView(show: ShowConstants.ecName, tabSelection: $tabSelection)
                .tabItem {
                    Text(ShowConstants.bbName)
                    Image(systemName: "car")
                }.tag(3)
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    MainView()
}
