import SwiftUI

struct StatisticsGridView: View {
    let winRate: Double
    let profitFactor: Double
    let totalTrades: Int
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 15) {
            StatCard(title: "Win Rate", value: String(format: "%.1f%%", winRate), trend: "+2.5%", trendUp: true)
            StatCard(title: "Profit Factor", value: String(format: "%.2f", profitFactor), trend: "+0.3", trendUp: true)
            StatCard(title: "Total Trades", value: "\(totalTrades)", trend: "12 today", trendUp: true)
            StatCard(title: "Net P&L", value: "$2,450", trend: "+$350 today", trendUp: true)
        }
        .padding(.horizontal)
    }
}

// End of file
