//
//  ProductsListView.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 26.09.24.
//

import SwiftUI

struct ProductsListView: View {
    
    @StateObject private var viewModel = ProductsListViewModel()
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout, content: {
                    ForEach(viewModel.filteredProducts) { product in
                        
                        NavigationLink(destination: ProductDetailView(product: product)) {
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
                                    .foregroundStyle(Color.black)
                                    .bold()
                                Text("\(product.price)")
                                    .foregroundStyle(Color.black)
                            }
                        }
                    }
                })
            }
            .navigationTitle("Products")
            .searchable(text: $viewModel.searchTerm, prompt: "Search Products")
            .overlay {
                if !viewModel.searchTerm.isEmpty && viewModel.filteredProducts.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchTerm)
                }
            }
        }
    }
}

#Preview {
    ProductsListView()
}
