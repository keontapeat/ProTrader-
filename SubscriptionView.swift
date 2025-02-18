import SwiftUI

struct SubscriptionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var subscriptionManager = SubscriptionManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Upgrade to Premium")
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading, spacing: 10) {
                    FeatureRow(text: "Unlimited trades")
                    FeatureRow(text: "Auto import")
                    FeatureRow(text: "Advanced analytics")
                    FeatureRow(text: "Priority support")
                }
                .padding()
                
                Button(action: {
                    subscriptionManager.upgrade()
                    dismiss()
                }) {
                    Text("Subscribe Now")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationBarItems(trailing: Button("Close") {
                dismiss()
            })
        }
    }
}

struct FeatureRow: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            Text(text)
        }
    }
}

// Preview provider
struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}

// End of file
