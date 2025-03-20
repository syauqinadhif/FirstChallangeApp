import SwiftUI

struct HistoryModal: View {
    @Environment(\.presentationMode) var presentationMode
    let transactions = [
        TransactionItem(date: "18 Mar 2025", type: "Income", amount: 2000000),
        TransactionItem(date: "17 Mar 2025", type: "Expense", amount: 150000),
        TransactionItem(date: "16 Mar 2025", type: "Expense", amount: 50000)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Button("Close") { presentationMode.wrappedValue.dismiss() }
                Spacer()
                Text("Transaction History").bold()
                Spacer()
            }
            .padding()
            
            List(transactions) { transaction in
                HStack {
                    VStack(alignment: .leading) {
                        Text(transaction.date)
                            .font(.caption)
                        Text(transaction.type)
                            .bold()
                    }
                    Spacer()
                    Text("Rp \(transaction.amount.formatted())")
                        .foregroundColor(transaction.type == "Income" ? .green : .red)
                }
            }
        }
        .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all))
        .frame(height: 400)
    }
}

struct TransactionItem: Identifiable {
    let id = UUID()
    let date: String
    let type: String
    let amount: Int
}
