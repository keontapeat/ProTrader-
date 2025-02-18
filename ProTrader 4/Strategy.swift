import Foundation

struct Strategy: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let timeframe: String
    let winRate: Int
}

// Sample data
let sampleStrategies = [
    Strategy(name: "Breakout Strategy", description: "Trading market breakouts with confirmation", timeframe: "H4", winRate: 65),
    Strategy(name: "Trend Following", description: "Following strong trends with pullbacks", timeframe: "H1", winRate: 72)
]

// End of file
