import SwiftUI

struct NewTransactionModal: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var amount: String = ""
    @State private var selectedDate = Date()
    @State private var selectedCategory = "Other"
    @State private var isExpense = true
    
    let categories = ["Foods", "Transports", "Bills", "Shops", "Others"]
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") { presentationMode.wrappedValue.dismiss() }
                Spacer()
                Text("New Transaction").bold()
                Spacer()
                Button("Add") {
                    // Handle transaction saving
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            
            Picker(selection: $isExpense, label: Text("")) {
                Text("Expense").tag(true)
                Text("Income").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Rp")
                    TextField("Nominal", text: $amount)
                        .keyboardType(.numberPad)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                Picker("Select Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all))
        .frame(height: 400)
    }
}
