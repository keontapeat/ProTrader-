import SwiftUI

struct NewTradeView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var tradeStore: TradeStore
    
    @State private var symbol = ""
    @State private var entry = ""
    @State private var exit = ""
    @State private var type: Trade.TradeType = .long
    @State private var setup = ""
    @State private var notes = ""
    @State private var emotions = ""
    @State private var volume = ""
    @State private var tags = [String]()
    @State private var newTag = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Trade Details")) {
                    TextField("Symbol", text: $symbol)
                    TextField("Entry Price", text: $entry)
                        .keyboardType(.decimalPad)
                    TextField("Exit Price", text: $exit)
                        .keyboardType(.decimalPad)
                    Picker("Type", selection: $type) {
                        Text("Long").tag(Trade.TradeType.long)
                        Text("Short").tag(Trade.TradeType.short)
                    }
                    TextField("Volume", text: $volume)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Analysis")) {
                    TextField("Setup", text: $setup)
                    TextEditor(text: $notes)
                        .frame(height: 100)
                    TextField("Emotions", text: $emotions)
                }
                
                Section(header: Text("Tags")) {
                    HStack {
                        TextField("Add tag", text: $newTag)
                        Button(action: addTag) {
                            Image(systemName: "plus.circle.fill")
                        }
                        .disabled(newTag.isEmpty)
                    }
                    
                    FlowLayout(spacing: 8) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .font(.subheadline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                                .onTapGesture {
                                    tags.removeAll { $0 == tag }
                                }
                        }
                    }
                }
            }
            .navigationTitle("New Trade")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveTrade()
                }
                .disabled(!isValidForm)
            )
        }
    }
    
    private var isValidForm: Bool {
        !symbol.isEmpty &&
        !entry.isEmpty &&
        !exit.isEmpty &&
        !volume.isEmpty
    }
    
    private func addTag() {
        let tag = newTag.trimmingCharacters(in: .whitespaces)
        if !tag.isEmpty && !tags.contains(tag) {
            tags.append(tag)
            newTag = ""
        }
    }
    
    private func saveTrade() {
        guard let entryPrice = Double(entry),
              let exitPrice = Double(exit),
              let tradeVolume = Int(volume) else { return }
        
        let profit = type == .long ?
            (exitPrice - entryPrice) * Double(tradeVolume) :
            (entryPrice - exitPrice) * Double(tradeVolume)
        
        let trade = Trade(
            symbol: symbol,
            entry: entryPrice,
            exit: exitPrice,
            date: Date(),
            type: type,
            profit: profit,
            setup: setup,
            notes: notes,
            emotions: emotions,
            riskRewardRatio: 0.0, // Calculate this based on your requirements
            volume: tradeVolume,
            screenshots: [],
            tags: tags
        )
        
        tradeStore.trades.append(trade)
        presentationMode.wrappedValue.dismiss()
    }
}

// End of file
