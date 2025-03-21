import SwiftUI
import CoreData

struct HomePage: View {
    
    // State Nampilin Modal View - surya
    @State private var showNewTransaction = false
    @State private var showHistory = false
    @State private var transactions: [FinancialTransaction] = []
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // State Segmented Control Income or Expense - surya
    @State var incomeOrExpense: Int = 0
    
    // Tanggal yang di pilih user pas input Expense/Income - Surya
    @State private var tanggal = Date()
    
    // Total Semua Expense - Surya
    @AppStorage("hasilHitung") var expense: Int = 0
    
    // Total semua Income - Surya
    @AppStorage("hasilIncome") var income: Int = 0
    
    // List Kategori yang di pilih (Food, Bill, Shopping, Transport, Others) di Modal View Expense
    @State var selectedKategori: Int = 0
    
    // MARK: TextField
    @State var textFieldText: String = ""
    
    // MARK: Variabel untuk menyimpan total berdasarkan tiap kategori
    @AppStorage("Food") var totalFood: Int = 0
    @AppStorage("bill") var totalBill: Int = 0
    @AppStorage("shopping") var totalShopping: Int = 0
    @AppStorage("Transport") var totalTransport: Int = 0
    @AppStorage("other") var totalOther: Int = 0
    
    var body: some View {
        List {
            Button("Show Sheet", action: {
                showNewTransaction = true
            })
            
            // MARK: Expense
            HStack {
                Text("Expense")
                Spacer()
                Text("Rp \(expense)")
            }
            
            // MARK: Income
            HStack {
                Text("Income: ")
                Spacer()
                Text("Rp \(income)")
            }
            
            // MARK: Makan
            HStack {
                Text("Makan: ")
                Spacer()
                Text("Rp: \(totalFood)")
            }
            
            // MARK: Bill
            HStack {
                Text("Bill: ")
                Spacer()
                Text("Rp: \(totalBill)")
            }
            
            //MARK: Shopping
            HStack {
                Text("Shopping: ")
                Spacer()
                Text("Rp: \(totalShopping)")
            }
            
            // MARK: Transport
            HStack {
                Text("Transport: ")
                Spacer()
                Text("Rp: \(totalTransport)")
            }
            
            // MARK: Others
            HStack {
                Text("Others: ")
                Spacer()
                Text("Rp: \(totalOther)")
            }
            
            // MARK: BOTTOM SHEET DISINI
        }.sheet(isPresented: $showNewTransaction) {
            
            NewTransactionModal(showNewTransaction: $showNewTransaction, incomeOrExpense: $incomeOrExpense, textFieldText: $textFieldText, tanggal: $tanggal, selectedKategori: $selectedKategori, expense: $expense, income: $income, totalFood: $totalFood, totalBill: $totalBill, totalShopping: $totalShopping, totalTransport: $totalTransport, totalOther: $totalOther)
            
            Spacer()
        }
        .presentationDetents([.medium, .large])
        .presentationBackgroundInteraction(.automatic)
        .presentationBackground(.regularMaterial)
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
