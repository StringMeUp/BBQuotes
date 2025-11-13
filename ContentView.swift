//
//  ContentView.swift
//  bbquotes
//
//  Created by Samir Ramic on 13.11.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
                
            Tab("Tab 1", systemImage: "tray.and.arrow.down.fill")
            {
                Image(systemName: "globe")
                    
            }
                
            Tab("Tab 2", systemImage: "globe.fill")
            {
                Image(systemName: "globe.fill")
                    
            }
            
        }.preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
