//Panggil function saveTransaction disini
//
//  ModalView.swift
//  BindingCoreData
//
//  Created by Surya on 22/03/25.
//

import SwiftUI

struct NewTransactionModal: View {
    
    @Binding var showNewTransaction: Bool
    
    // MARK: income / expense
    @Binding var incomeOrExpense: Int
    
    // MARK: ???
    @Binding var textFieldText: String
    @Binding var tanggal: Date
    
    // SELECTED ITEM == KATEGORI YANG DI PILIH
    @Binding var selectedKategori: Int
    
    @Binding var expense: Int
    @Binding var income: Int
    
    // MARK: KONEK KE CORE DATA
    // @StateObject var vm = CoreDataViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    
    // MARK: var di content view
    @Binding var totalFood: Int
    @Binding var totalBill: Int
    @Binding var totalShopping: Int
    @Binding var totalTransport: Int
    @Binding var totalOther: Int
    
    var body: some View {
        
        NavigationView() {
            
            List {
                Picker("Expense or Income", selection: $incomeOrExpense) {
                    Text("Expense").tag(0)
                    Text("Income").tag(1)
                }
                .pickerStyle(.segmented)
                
                // MARK: TextDisini
                
                TextField("Rp...", text: $textFieldText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                // Date Picker Disini...
                DatePicker(selection: $tanggal, in: ...Date(),displayedComponents: .date,
                           label: {
                    Text("Select Date")
                })
                
                // MARK: Error disini karna Picker
                
               
                    if incomeOrExpense == 0 {
                        HStack {
                        Picker("Pilih Kategori", selection: $selectedKategori) {
                            
                            // MARK: COBA IF ELSE DISINI
                            
                            Text("Food").tag(0)
                            Text("Bill").tag(1)
                            Text("Shopping").tag(2)
                            Text("Transport").tag(3)
                            Text("Other").tag(4)
                        }
                    }
                }
            }
            
            .navigationBarItems(leading: Button("Cancel",
                                                action: {presentationMode.wrappedValue.dismiss()}),
                                trailing: Button("Submit", action: {
                guard !textFieldText.isEmpty else { return }
                
                // add ke core data
                //vm.addList(text: textFieldText, kategori: String(selectedItem))
                
                
                
                if incomeOrExpense == 0 {
                    
                    if selectedKategori == 0 {
                        totalFood += Int(textFieldText) ?? 0
                    } else if selectedKategori == 1 {
                        totalBill += Int(textFieldText) ?? 0
                    } else if selectedKategori == 2 {
                        totalShopping += Int(textFieldText) ?? 0
                    } else if selectedKategori == 3 {
                        totalTransport += Int(textFieldText) ?? 0
                    } else {
                        totalOther += Int(textFieldText) ?? 0
                    }
                    
                    expense += Int(textFieldText) ?? 0
                } else {
                    income += Int(textFieldText) ?? 0
                }
                
            }))
            .navigationTitle("Input")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var value = false
    @Previewable @State var teks = ""
    @Previewable @State var dua = 0
    @Previewable @State var date = Date.now
    @Previewable @State var hitung = 0
    NewTransactionModal(showNewTransaction: $value, incomeOrExpense: $dua, textFieldText: $teks, tanggal: $date, selectedKategori: $dua, expense: $hitung, income: $dua, totalFood: $dua, totalBill: $dua, totalShopping: $dua, totalTransport: $dua, totalOther: $dua)
}
