//
//  MainViewModel.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 26.09.24.
//

import Foundation

final class ProductsListViewModel: ObservableObject {
    
    private var networkManager = ShoppingAppNM()
    
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
    
//    init(products: [Product] = [Product](), searchTerm: String = "") {
//        self.products = products
//        self.searchTerm = searchTerm
//    }
    
    func fetchProducts() {
        Task {
            await networkManager.getAllProducts()
            products = networkManager.products
        }
    }
    
}
