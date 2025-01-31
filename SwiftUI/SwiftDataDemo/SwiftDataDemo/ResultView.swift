//
//  ResultView.swift
//  SwiftDataDemo
//
//  Created by 강보현 on 1/16/25.
//

import SwiftUI
import SwiftData

struct ResultView: View {
    var name: String
    @Environment(\.modelContext) private var modelContext
    @State private var matches: [Product] = []
    var body: some View {
        VStack {
            List {
                ForEach(matches) { product in
                    HStack {
                        Text(product.name ?? "Not found")
                        Spacer()
                        Text(product.quantity ?? "Not found")
                    }
                }
            }
            .navigationTitle("Result")
        }
        .task {
            let descriptor = FetchDescriptor<Product>(predicate: #Predicate<Product> { product in
                product.name?.contains(name) ?? false})
            do {
                matches = try modelContext.fetch(descriptor)
            }
            catch {
                print("Error fetching products: \(error)")
                matches = []
            }
        }
        Text("ResultView")
    }
}


