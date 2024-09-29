//
//  MainViewModel.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 26.09.24.
//

import Foundation

final class ProductsListViewModel: ObservableObject {
    
    private var networkManager = ShoppingAppNM()
    
    // formatter viewModel'da olmamali extention olarak view'da olmali
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// The array that holds the decoded products received from the server
    @Published var products = [Product]()
    /// The text from SearchBar
    @Published var searchTerm = ""
    
    /// Filtered products from products array
    var filteredProducts: [Product] {
        guard !searchTerm.isEmpty else { return products }
        return products.filter({ $0 .title.localizedCaseInsensitiveContains(searchTerm) })
    }
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        Task {
            await networkManager.getAllProducts()
            products = networkManager.products
        }
    }
    
}
