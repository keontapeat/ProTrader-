import SwiftUI

struct RecentActivityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Recent Activity")
                .font(.headline)
                .padding(.horizontal)

            ForEach(1...3, id: \.self) { _ in
                ActivityCard()
            }
        }
    }
}

// End of file
