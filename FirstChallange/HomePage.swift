import SwiftUI
import CoreData

struct HomePage: View {
    @State private var showNewTransaction = false
    @State private var showHistory = false
    @State private var transactions: [FinancialTransaction] = []
    
    @Environment(\.managedObjectContext) private var viewContext

    private let staticCategories = ["Foods", "Transports", "Bills", "Shops", "Other"]

    private var totalBalance: Double {
        transactions.reduce(0) { $0 + ($1.isExpense ? -$1.amount : $1.amount) }
    }
    
    private var totalIncome: Double {
        transactions.filter { !$0.isExpense }.reduce(0) { $0 + $1.amount }
    }

    private var totalExpense: Double {
        transactions.filter { $0.isExpense }.reduce(0) { $0 + $1.amount }
    }

    // Menghitung total pengeluaran berdasarkan kategori
    private var categoryExpenses: [String: Double] {
        var categoryTotals: [String: Double] = [:]
        for category in staticCategories {
            categoryTotals[category] = 0 // Pastikan semua kategori tetap ada
        }
        
        for transaction in transactions where transaction.isExpense {
            let category = transaction.category ?? "Other"
            categoryTotals[category, default: 0] += transaction.amount
        }
        
        return categoryTotals
    }

    private func fetchTransactions() {
        transactions = PersistenceController.shared.getTransactionsForCurrentMonth()
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Header: Bulan + Icons
                    HStack {
                        Text(FormattedDate.getCurrentMonthYear())
                            .font(.body)
                        
                        Spacer()
                        
                        Button(action: { showHistory.toggle() }) {
                            Image(systemName: "calendar")
                        }
                        
                        Button(action: { showNewTransaction.toggle() }) {
                            Image(systemName: "plus")
                        }
                    }
                    .padding(.horizontal)
                    
                    // Balance Card
                    BalanceCard(title: "Balance", amount: totalBalance)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Income & Expense Cards
                    HStack {
                        IncomeCard(amount: totalIncome)
                        Spacer(minLength: 16)
                        ExpenseCard(amount: totalExpense)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Total Spending Section
                    Text("Total Spending")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Static List of Spending
                    List {
                        ForEach(staticCategories, id: \.self) { category in
                            SpendingRow(
                                category: category,
                                amount: categoryExpenses[category] ?? 0,
                                icon: getCategoryIcon(category)
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                .blur(radius: showNewTransaction ? 3 : 0) // Blur saat modal muncul
                
                // Overlay saat modal tampil
                if showNewTransaction {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
            }
            .onAppear {
                fetchTransactions()
            }
            .sheet(isPresented: $showNewTransaction) {
                NewTransactionModal()
                    .environment(\.managedObjectContext, viewContext)
                    .onDisappear {
                        fetchTransactions()
                    }
            }
            .sheet(isPresented: $showHistory) {
                HistoryModal()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

// Helper untuk mendapatkan ikon kategori
func getCategoryIcon(_ category: String) -> String {
    switch category {
    case "Foods": return "fork.knife.circle.fill"
    case "Transports": return "car.circle.fill"
    case "Bills": return "creditcard.circle.fill"
    case "Shops": return "bag.circle.fill"
    default: return "ellipsis.circle.fill"
    }
}

// MARK: - Balance Card
struct BalanceCard: View {
    var title: String
    var amount: Double
    
    var body: some View {
        VStack {
            Text("Rp \(amount, specifier: "%.2f")")
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.vertical, 10)
        .background(Color(.shadedGrey))
        .cornerRadius(10)
    }
}

struct IncomeCard: View {
    var amount: Double

    var body: some View {
        VStack {
            Text("Rp \(amount, specifier: "%.2f")")
                .font(.title2)
                .bold()
            Text("Income")
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color(.shadedGrey))
        .cornerRadius(10)
    }
}

struct ExpenseCard: View {
    var amount: Double

    var body: some View {
        VStack {
            Text("Rp \(amount, specifier: "%.2f")")
                .font(.title2)
                .bold()
            Text("Expense")
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 20)
        .background(Color(.shadedGrey))
        .cornerRadius(10)
    }
}

// MARK: - Spending Row
struct SpendingRow: View {
    var category: String
    var amount: Double
    var icon: String  // SF Symbol name

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue) // Bisa diubah sesuai tema
            Text(category)
            Spacer()
            Text("Rp \(amount.formatted())")
                .bold()
        }
        .padding(.vertical, 5)
    }
}


// Helper untuk mendapatkan nama bulan saat ini
struct FormattedDate {
    static func getCurrentMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: Date())
    }
}
