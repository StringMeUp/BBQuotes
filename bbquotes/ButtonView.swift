//
//  ButtonView.swift
//  bbquotes
//
//  Created by Samir Ramic on 19.11.25.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    
    let action: () async -> Void
    var buttonLabel: ButtonConstants
    var show: String
    
    var body: some View {
        Button {
            Task {
               await action()
            }
        }
        label: {
            Text(buttonLabel.rawValue)
                .padding(8)
                .background(Color(show.removeSpaces()))
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 25))
                .shadow(
                    color: Color("\(show.removeSpaces())Shadowcolor"),
                    radius: 2
                )
        }
    }
}

#Preview(){
    ButtonView(action: {}, buttonLabel: ButtonConstants.characterButton, show: "Breaking Bad")
}
