//
//  ProductsListView.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 26.09.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductsListView: View {
    
    @StateObject private var viewModel = ProductsListViewModel()
    
    let layout = [
        GridItem(.flexible(minimum: 100)),
        GridItem(.flexible(minimum: 100)),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout, content: {
                    ForEach(viewModel.filteredProducts) { product in
                        
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            VStack {
                                
                                let imageURL = URL(string: product.thumbnail)
                                let formattedPrice = viewModel.formatter.string(from: product.price as NSNumber)!
                                
                                WebImage(url: imageURL)
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .aspectRatio(contentMode: .fit)
                                
                                Text(product.title)
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                
                                    
                                Text("\(formattedPrice) $")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.black)
                                
                                StarRatingView(rating: product.rating)
                                
                                Spacer()
                                
                                Button("Sepete ekle") {
                                    // butonun islevi eklenecek
                                }
                                .font(.headline)
                                .frame(maxWidth: .infinity, minHeight: 40)
                                .background(Color.white)
                                .foregroundStyle(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.black, lineWidth: 1)
                                }
                                
                                    
                            }
                            .padding()
                            .frame(height: 330)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 5)
                        }
                    }
                })
                .padding(.horizontal)
                .background(Color(white: 0.9))
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

struct StarRatingView: View {
    let rating: Double
    private let maxRating = 5
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= Int(rating) ? "star.fill" : "star")
                    .foregroundColor(star <= Int(rating) ? .yellow : .gray)
            }
        }
    }
}

#Preview {
    ProductsListView()
}
