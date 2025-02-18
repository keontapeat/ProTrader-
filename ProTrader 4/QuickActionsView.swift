import SwiftUI

struct QuickActionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.horizontal)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                QuickActionButton(icon: "plus.circle.fill", title: "New Trade")
                QuickActionButton(icon: "note.text", title: "Trading Plan")
                QuickActionButton(icon: "chart.bar.fill", title: "Analysis")
            }
            .padding(.horizontal)
        }
    }
}

// End of file
