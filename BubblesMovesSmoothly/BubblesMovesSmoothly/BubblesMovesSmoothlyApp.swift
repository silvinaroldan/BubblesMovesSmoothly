//
//  BubblesMovesSmoothlyApp.swift
//  BubblesMovesSmoothly
//
//  Created by Silvina Roldan on 02/10/2024.
//

import SwiftUI

@main
struct BubblesApp: App {
    
    @State private var appModel = AppModel()
    
    var body: some Scene {
        WindowGroup {
           
                ContentView()
                    .environment(appModel)
            
        }
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
