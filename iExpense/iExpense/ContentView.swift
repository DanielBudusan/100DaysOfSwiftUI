//
//  ContentView.swift
//  iExpense
//
//  Created by Daniel Budusan on 20.02.2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ItemColor: ViewModifier {
    var amount: Double
    
    func body(content: Content) -> some View {
        if amount < 10 {
            content
                .foregroundStyle(Color(red: 89 / 255, green: 181 / 255, blue: 63 / 255))
        } else if amount < 100 {
            content
                .foregroundStyle(Color(red: 63 / 255, green: 79 / 255, blue: 181 / 255))
        } else {
            content
                .foregroundStyle(Color(red: 189 / 255, green: 49 / 255, blue: 77 / 255))
        }
    }
}

extension View {
    func itemColor(_ amount: Double) -> some View {
        modifier(ItemColor(amount: amount))
    }
}

struct ExpenseItemView: View {
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .itemColor(item.amount)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .itemColor(item.amount)
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(expenses.items.filter({$0.type == "Personal"})) { item in
                            ExpenseItemView(item: item)
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal").font(.headline)
                }
                
                Section {
                    ForEach(expenses.items.filter({$0.type == "Business"})) { item in
                            ExpenseItemView(item: item)
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Business").font(.headline)
                }
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense ", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
}

#Preview {
    ContentView()
}
