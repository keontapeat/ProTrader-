import SwiftUI

enum SubscriptionTier {
    case free
    case premium
}

class SubscriptionManager: ObservableObject {
    static let shared = SubscriptionManager()
    
    @Published var currentTier: SubscriptionTier = .free
    
    private init() {}
    
    func upgrade() {
        currentTier = .premium
    }
    
    func downgrade() {
        currentTier = .free
    }
}

// End of file
