//
//  SwiftUIView.swift
//  GameWidgetExtension
//
//  Created by Francois Lambert on 5/14/24.
//

import SwiftUI
import WidgetKit

struct LiveActivityView: View {
    @Environment(\.isActivityFullscreen) var isStandBy
    let context: ActivityViewContext<GameAttributes>

    var body: some View {
        ZStack {
            if !isStandBy {
                Image("activity-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        ContainerRelativeShape()
                            .fill(.black.opacity(0.3).gradient)
                    }
            }

            VStack(spacing: 12) {
                HStack {
                    Image(context.attributes.homeTeam)
                        .teamLogoModifier(frame: 50)
                    Text("\(context.state.gameState.homeScore)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.white.opacity(0.9))

                    Spacer()

                    Text("\(context.state.gameState.awayScore)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(isStandBy ? . white : .black.opacity(0.7))
                    Image(context.attributes.awayTeam)
                        .teamLogoModifier(frame: 50)
                }

                HStack {
                    Image(context.state.gameState.winningTeamName)
                        .teamLogoModifier(frame: 20)
                    Text(context.state.gameState.lastAction)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            .padding()
        }
    }
}

//struct LiveActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        LiveActivityView()
//            .previewLayout(.fixed(width: 300, height: 150))
//    }
//}
