//
//  GameLiveActivity.swift
//  GameWidget
//
//  Created by Francois Lambert on 5/14/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct GameLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: GameAttributes.self) { context in
            // Lock screen/banner UI goes here
            LiveActivityView(context: context)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Image(context.attributes.homeTeam)
                            .teamLogoModifier(frame: 40)

                        Text("\(context.state.gameState.homeScore)")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        Text("\(context.state.gameState.awayScore)")
                            .font(.title)
                            .fontWeight(.semibold)

                        Image(context.attributes.awayTeam)
                            .teamLogoModifier(frame: 40)
                    }
                }
//                DynamicIslandExpandedRegion(.center) {
//                    Text("4:24 3Q")
//                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Image(context.state.gameState.scoringTeamName)
                            .teamLogoModifier(frame: 20)

                        Text(context.state.gameState.lastAction)
                    }
                }
            } compactLeading: {
                HStack {
                    Image(context.attributes.homeTeam)
                        .teamLogoModifier()

                    Text("\(context.state.gameState.homeScore)")
                        .fontWeight(.semibold)
                }
            } compactTrailing: {
                HStack {
                    Text("\(context.state.gameState.awayScore)")
                        .fontWeight(.semibold)

                    Image(context.attributes.awayTeam)
                        .teamLogoModifier()
                }
            } minimal: {
                Image(context.state.gameState.winningTeamName)
                    .teamLogoModifier()
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
        .contentMarginsDisabled()
    }
}

extension GameAttributes {
    fileprivate static var preview: GameAttributes {
        GameAttributes(homeTeam: "warriors", awayTeam: "bulls")
    }
}

#Preview("Live Activity", as: .content, using: GameAttributes.preview) {
   GameLiveActivity()
} contentStates: {
    GameAttributes.ContentState(gameState: .init(homeScore: 10, awayScore: 12, scoringTeamName: "warriors", lastAction: "scored a 3"))
}
