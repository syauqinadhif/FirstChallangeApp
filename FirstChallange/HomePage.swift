import SwiftUI

struct HomePage: View {
    @State private var showNewTransaction = false
    @State private var showHistory = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("March 2025")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HStack {
                    BalanceCard(title: "Balance", amount: 3990000, icon: nil)
                    BalanceCard(title: "Income", amount: 5000000, icon: "+")
                    BalanceCard(title: "Expense", amount: 1010000, icon: "-")
                }
                
                Text("Total Spending")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                List {
                    SpendingRow(category: "Foods", amount: 510000, icon: "🍽")
                    SpendingRow(category: "Transports", amount: 70000, icon: "🚗")
                    SpendingRow(category: "Bills", amount: 230000, icon: "💳")
                    SpendingRow(category: "Shops", amount: 90000, icon: "🛍")
                    SpendingRow(category: "Others", amount: 110000, icon: "📦")
                }
                .listStyle(PlainListStyle())
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: { showHistory.toggle() }) {
                            Image(systemName: "calendar")
                        }
                        Button(action: { showNewTransaction.toggle() }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showNewTransaction) {
                NewTransactionModal()
            }
            .sheet(isPresented: $showHistory) {
                HistoryModal()
            }
        }
    }
}

struct BalanceCard: View {
    var title: String
    var amount: Int
    var icon: String?
    
    var body: some View {
        VStack {
            if let icon = icon {
                Text(icon)
                    .font(.largeTitle)
            }
            Text("Rp \(amount.formatted())")
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
        }
        .frame(width: 100, height: 80)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct SpendingRow: View {
    var category: String
    var amount: Int
    var icon: String
    
    var body: some View {
        HStack {
            Text(icon)
                .font(.title)
            Text(category)
            Spacer()
            Text("Rp \(amount.formatted())")
                .bold()
        }
        .padding(.vertical, 5)
    }
}
