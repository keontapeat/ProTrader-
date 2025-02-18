import SwiftUI

struct MyTradeDetailView: View {
    let trade: Trade
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                TradeHeaderView(trade: trade)
                
                // Trade Details
                TradeDetailsView(trade: trade)
                
                // Notes and Analysis
                TradeAnalysisView(trade: trade)
                
                // Tags
                if !trade.tags.isEmpty {
                    TradeTagsView(tags: trade.tags)
                }
            }
            .padding()
        }
        .navigationTitle("Trade Details")
        .background(Color(.systemGroupedBackground))
    }
}

// Supporting Views
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

struct TradeDetailsView: View {
    let trade: Trade
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Trade Details")
                .font(.headline)
            
            Group {
                DetailRow(title: "Entry Price", value: String(format: "$%.2f", trade.entry))
                DetailRow(title: "Exit Price", value: String(format: "$%.2f", trade.exit))
                DetailRow(title: "Volume", value: "\(trade.volume)")
                DetailRow(title: "Risk:Reward", value: String(format: "%.1f", trade.riskRewardRatio))
            }
        }
    }
}

struct TradeAnalysisView: View {
    let trade: Trade
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Analysis")
                .font(.headline)
            
            Group {
                Text("Setup")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(trade.setup)
                    .padding(.bottom, 10)
                
                Text("Notes")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(trade.notes)
                    .padding(.bottom, 10)
                
                Text("Emotions")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(trade.emotions)
            }
        }
    }
}

struct TradeTagsView: View {
    let tags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tags")
                .font(.headline)
            
            FlowLayout(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                }
            }
        }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        return rows.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        rows.place(in: bounds)
    }
    
    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> Rows {
        let maxWidth = proposal.width ?? 0
        var currentX = 0.0
        var currentRow = 0
        var rows: [Row] = []
        var row = Row()
        
        for subview in subviews {
            let size = subview.sizeThatFits(proposal)
            if currentX + size.width > maxWidth, !row.items.isEmpty {
                rows.append(row)
                row = Row()
                currentX = 0
                currentRow += 1
            }
            
            row.items.append(RowItem(view: subview, size: size))
            currentX += size.width + spacing
        }
        
        if !row.items.isEmpty {
            rows.append(row)
        }
        
        return Rows(rows: rows)
    }
    
    private struct Row {
        var items: [RowItem] = []
    }
    
    private struct RowItem {
        let view: LayoutSubview
        let size: CGSize
    }
    
    private struct Rows {
        let rows: [Row]
        
        var size: CGSize {
            var height = 0.0
            var width = 0.0
            
            for row in rows {
                var rowWidth = 0.0
                var rowHeight = 0.0
                
                for item in row.items {
                    rowWidth += item.size.width
                    rowHeight = max(rowHeight, item.size.height)
                }
                
                height += rowHeight
                width = max(width, rowWidth)
            }
            
            return CGSize(width: width, height: height)
        }
        
        func place(in bounds: CGRect) {
            var y = bounds.minY
            
            for row in rows {
                var x = bounds.minX
                var rowHeight = 0.0
                
                for item in row.items {
                    rowHeight = max(rowHeight, item.size.height)
                    item.view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(item.size))
                    x += item.size.width + 8
                }
                
                y += rowHeight + 8
            }
        }
    }
}

// End of file
