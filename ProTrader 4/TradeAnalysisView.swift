import SwiftUI

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

// End of file
