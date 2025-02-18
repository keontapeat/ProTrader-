import SwiftUI

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
