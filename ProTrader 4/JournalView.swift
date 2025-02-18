
import SwiftUI

struct JournalView: View {
    // MARK: - Properties
    @StateObject private var tradeStore = TradeStore()
    @State private var showingNewTradeSheet = false
    @State private var searchText = ""
    @State private var selectedFilter: TradeFilter = .all
    @State private var sortOption: SortOption = .dateDescending
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var showingDateFilter = false
    
    // MARK: - Enums
    enum SortOption: String, CaseIterable {
        case dateDescending = "Latest First"
        case dateAscending = "Oldest First"
        case profitDescending = "Highest Profit"
        case profitAscending = "Lowest Profit"
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack(spacing: 10) {
                    SearchBar(text: $searchText)
                    FilterSection(selectedFilter: $selectedFilter)
                }
                .padding()
                .background(Color.white)

                List {
                    ForEach(filteredTrades) { trade in
                        NavigationLink(destination: MyTradeDetailView(trade: trade)) {
                            TradeRow(trade: trade)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Trade Journal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingNewTradeSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewTradeSheet) {
                NewTradeView()
            }
        }
    }
    
    // MARK: - Computed Properties
    private var filteredTrades: [Trade] {
        var result = tradeStore.trades

        if !searchText.isEmpty {
            result = result.filter { trade in
                trade.symbol.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch selectedFilter {
        case .profitable:
            result = result.filter { $0.profit > 0 }
        case .losing:
            result = result.filter { $0.profit < 0 }
        case .thisWeek:
            // Add this week filter implementation
            break
        case .thisMonth:
            // Add this month filter implementation
            break
        case .thisYear:
            // Add this year filter implementation
            break
        case .all:
            break
        }

        switch sortOption {
        case .dateDescending:
            result.sort { $0.date > $1.date }
        case .dateAscending:
            result.sort { $0.date < $1.date }
        case .profitDescending:
            result.sort { $0.profit > $1.profit }
        case .profitAscending:
            result.sort { $0.profit < $1.profit }
        }

        return result
    }
}
