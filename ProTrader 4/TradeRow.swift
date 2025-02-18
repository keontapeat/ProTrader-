import SwiftUI

struct TradeRow: View {
    let trade: Trade
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(trade.symbol)
                    .font(.headline)
                Text(trade.type.rawValue)
                    .font(.subheadline)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(trade.type == .long ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                    .foregroundColor(trade.type == .long ? .green : .red)
                    .cornerRadius(8)
                Spacer()
                Text(String(format: "$%.2f", trade.profit))
                    .font(.headline)
                    .foregroundColor(trade.profit >= 0 ? .green : .red)
            }

            HStack {
                Text(trade.setup)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(trade.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            if !trade.tags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(trade.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// End of file
