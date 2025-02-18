import SwiftUI

struct FilterSection: View {
    @Binding var selectedFilter: TradeFilter
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(TradeFilter.allCases, id: \.self) { filter in
                    FilterChip(title: filter.rawValue,
                              isSelected: selectedFilter == filter,
                              action: { selectedFilter = filter })
                }
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

// End of file
