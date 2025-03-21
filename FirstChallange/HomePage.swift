import SwiftUI
import CoreData

struct HomePage: View {
    @State private var showNewTransaction = false
    @State private var showHistory = false
    @State private var transactions: [FinancialTransaction] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Text("")
    }
}

struct HeaderView: View {
    @Binding var showHistory: Bool
    @Binding var showNewTransaction: Bool
    
    var body: some View {
        Text("")
    }
}

struct SpendingListView: View {
    var categories: [String]
    var categoryExpenses: [String: Int64]
    
    var body: some View {
        Text("")
    }
}

struct BalanceCard: View {
    var title: String
    var amount: Int64
    
    var body: some View {
        Text("")
    }
}

struct IncomeCard: View {
    var amount: Int64
    
    var body: some View {
        Text("")
    }
}

struct ExpenseCard: View {
    var amount: Int64
    
    var body: some View {
        Text("")
    }
}

struct SpendingRow: View {
    var category: String
    var amount: Int64
    var icon: String
    
    var body: some View {
        Text("")
    }
}

struct FormattedDate {
    static func getCurrentMonthYear() -> String {
        return ""
    }
}

func fetchTransactions() {
    //Logic Fetch Transactions
    //Just Call getTransactionsForCurrentMonth
}

func calculateTotalBalance() -> Int64 {
    //Logic calculateTotalBalance
    return 0 }

func calculateTotalIncome() -> Int64 {
    //Logic calculateTotalIncome
    return 0 }

func calculateTotalExpense() -> Int64 {
    //Logic calculateTotalExpense
    return 0 }


func calculateCategoryExpenses() -> [String: Int64] {
    //Logic calculateCategoryExpenses
    return [:] }

func getCategoryIcon(_ category: String) -> String {
    //Block of code to get list of icon
    return "" }
