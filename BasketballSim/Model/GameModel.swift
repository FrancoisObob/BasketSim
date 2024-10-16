//
//  GameModel.swift
//  BasketballSim
//
//  Created by Sean Allen on 11/6/22.
//

import Foundation
import ActivityKit

final class GameModel: ObservableObject, GameSimulatorDelegate {

    @Published var gameState = GameState(homeScore: 0,
                                          awayScore: 0,
                                          scoringTeamName: "",
                                          lastAction: "")
    
    var liveActivity: Activity<GameAttributes>? = nil
    let simulator = GameSimulator()

    init() {
        simulator.delegate = self
    }

    func startLiveActivity() {
        let attributes = GameAttributes(homeTeam: "warriors", awayTeam: "bulls")
        let currentGameState = GameAttributes.ContentState(gameState: gameState)
        let activityContent = ActivityContent(state: currentGameState, staleDate: Calendar.current.date(byAdding: .second, value: 10, to: Date())!)

        do {
            liveActivity = try Activity.request(attributes: attributes, content: activityContent)
        } catch {
            print(error.localizedDescription)
        }
    }

    func didUpdate(gameState: GameState) {
        self.gameState = gameState

        let currentGameState = GameAttributes.ContentState(gameState: gameState)
        let activityContent = ActivityContent(state: currentGameState, staleDate: Calendar.current.date(byAdding: .second, value: 10, to: Date())!)

        Task {
            await liveActivity?.update(activityContent)
        }
    }

    func didCompleteGame() {
        let currentGameState = GameAttributes.ContentState(gameState: gameState)
        let activityContent = ActivityContent(state: currentGameState, staleDate: Calendar.current.date(byAdding: .second, value: 10, to: Date())!)

        Task {
            await liveActivity?.end(activityContent, dismissalPolicy: .immediate)
        }
    }
}
