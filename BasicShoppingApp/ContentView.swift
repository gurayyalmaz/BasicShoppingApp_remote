//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 22.09.24.
//

import SwiftUI

struct ContentView: View {
    
    /// The array that holds the decoded products received from the server
    @State var products = [Product]()
    /// The variable that holds the loading state of the products
    @State var isLoading = false
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
            } else {
                NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: layout, content: {
                            ForEach(products) { product in
                                VStack {
                                    
                                    let imageURL = URL(string: product.thumbnail)
                                    
                                    AsyncImage(url: imageURL) { image in
                                        image
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle(), style: FillStyle())
                                    } placeholder: {
                                        Circle()
                                            .frame(width: 120, height: 120)
                                            .foregroundStyle(.secondary)
                                    }

                                    
                                    Text(product.title)
                                    Text("\(product.price)")
                                }
                            }
                        })
                    }
                }
            }
        }
        .task {
            await getAllProducts()
        }
    }
    
    /// The method that fetches and decodes the products from server
    func getAllProducts() async {
        isLoading = true
        let endPoint = "https://dummyjson.com/products"
        guard let url = URL(string: endPoint) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let productsResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
            products = productsResponse.products
            isLoading = false
        } catch {
            print("getAllProducts error!")
        }
    }
    
}

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
}

struct ProductsResponse: Codable {
    let products: [Product]
}

#Preview {
    ContentView()
}
