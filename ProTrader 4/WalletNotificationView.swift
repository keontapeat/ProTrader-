import SwiftUI

struct WalletNotificationView: View {
    @State private var showingWalletDetails = false
    
    var body: some View {
        Button(action: {
            showingWalletDetails = true
        }) {
            HStack(spacing: 4) {
                Image(systemName: "wallet.pass.fill")
                    .foregroundColor(.blue)
                Text("$124,350")
                    .fontWeight(.semibold)
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(20)
        }
        .sheet(isPresented: $showingWalletDetails) {
            WalletDetailsView()
        }
    }
}

struct WalletDetailsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("MT5 Accounts")) {
                    AccountRow(name: "MT5 Main", balance: "$85,230", profit: "+$1,250", isProfit: true)
                    AccountRow(name: "MT5 Demo", balance: "$24,120", profit: "-$320", isProfit: false)
                }
                
                Section(header: Text("MT4 Accounts")) {
                    AccountRow(name: "MT4 Pro", balance: "$12,500", profit: "+$450", isProfit: true)
                }
                
                Section(header: Text("TradeLocker")) {
                    AccountRow(name: "Main Account", balance: "$2,500", profit: "+$120", isProfit: true)
                }
            }
            .navigationTitle("Wallet Overview")
        }
    }
}

struct AccountRow: View {
    let name: String
    let balance: String
    let profit: String
    let isProfit: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(balance)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(profit)
                .foregroundColor(isProfit ? .green : .red)
                .font(.system(.body, design: .monospaced))
        }
    }
}

// End of file. No additional code.
