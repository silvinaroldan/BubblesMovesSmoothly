//
//  ContentView.swift
//  BubblesMovesSmoothly
//
//  Created by Silvina Roldan on 02/10/2024.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    var body: some View {
        VStack {
            ToggleImmersiveSpaceButton()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
