//
//  ProductDetailView.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 24.09.24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailView: View {
    
    let product: Product
    
    var body: some View {
        
        let imageURL = URL(string: product.thumbnail)
        
        VStack {
            WebImage(url: imageURL)
                .resizable()
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle(), style: FillStyle())
            Text(product.title)
            Text("\(product.price)")

        }
    }
}

struct ProductDetailView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let sampleProduct = Product(id: 1,
                                    title: "Sample product title",
                                    price: 0.99,
                                    thumbnail: "https://picsum.photos/200",
                                    rating: 4.44)
        
        ProductDetailView(product: sampleProduct)
    }
}
