//
//  ShoppingAppNM.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 26.09.24.
//

import Foundation

class ShoppingAppNM: ObservableObject {
    
    /// The variable that holds the loading state of the products
    @Published var isLoading = false
    /// The variable holds decoded products from API
    @Published var products = [Product]()
    
    /// The method that fetches and decodes the products from server
    func getAllProducts() async {
        let endPoint = "https://dummyjson.com/products"
        let url = URL(string: endPoint)
        
        do {
            isLoading = true
            let (data, _) = try await URLSession.shared.data(from: url!)
            let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
            products = productsResponse.products
            isLoading = false
        } catch {
            print("getAllProducts error!")
        }
    }
}
