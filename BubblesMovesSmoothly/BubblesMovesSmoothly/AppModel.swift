//
//  AppModel.swift
//  BubblesMovesSmoothly
//
//  Created by Silvina Roldan on 02/10/2024.
//

import SwiftUI

@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
}
