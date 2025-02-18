import Foundation

enum TradeFilter: String, CaseIterable {
    case all = "All"
    case profitable = "Profitable"
    case losing = "Losing"
    case thisWeek = "This Week"
    case thisMonth = "This Month"
    case thisYear = "This Year"
}

// End of file
