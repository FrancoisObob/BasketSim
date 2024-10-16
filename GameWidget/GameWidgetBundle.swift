//
//  GameWidgetBundle.swift
//  GameWidget
//
//  Created by Francois Lambert on 5/14/24.
//

import WidgetKit
import SwiftUI

@main
struct GameWidgetBundle: WidgetBundle {
    var body: some Widget {
        GameWidget()
        GameLiveActivity()
    }
}
