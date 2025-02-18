import SwiftUI

struct TradeDetailView: View {
    let trade: Trade
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Trade Header
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
                            .padding(.horizontal,
