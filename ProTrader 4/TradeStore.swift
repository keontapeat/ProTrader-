import Foundation

class TradeStore: ObservableObject {
    @Published var trades: [Trade] = []
    
    init() {
        // Load sample data
        trades = [
            Trade(symbol: "AAPL", entry: 150.0, exit: 155.0, date: Date(), type: .long, profit: 500.0, setup: "Break and Retest", notes: "Strong momentum", emotions: "Confident", riskRewardRatio: 3.0, volume: 100, screenshots: [], tags: ["Trend"]),
            Trade(symbol: "TSLA", entry: 200.0, exit: 195.0, date: Date().addingTimeInterval(-86400), type: .short, profit: -500.0, setup: "Reversal", notes: "Weak market", emotions: "Hesitant", riskRewardRatio: 2.0, volume: 50, screenshots: [], tags: ["Reversal"])
        ]
    }
}

// End of file
