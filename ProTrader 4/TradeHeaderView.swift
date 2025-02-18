import SwiftUI

struct TradeHeaderView: View {
    let trade: Trade
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(trade.symbol)
                    .font(.title)
                    .bold()
                Spacer()
                Text(String(format: "$%.2f", trade.profit))
                    .font(.title2)
                    .bold()
                    .foregroundColor(trade.profit >= 0 ? .green : .red)
            }
            
            HStack {
                Text(trade.type.rawValue)
                    .font(.headline)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(trade.type == .long ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .foregroundColor(trade.type == .long ? .green : .red)
                    .cornerRadius(8)
                Spacer()
                Text(trade.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

// End of file
