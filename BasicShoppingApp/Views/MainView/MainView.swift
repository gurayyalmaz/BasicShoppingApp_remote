//
//  ContentView.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 22.09.24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var shoppingAppNM = ShoppingAppNM()
    
    var body: some View {
        Group {
            if shoppingAppNM.isLoading {
                LoadingView()
            } else {
                ProductsListView()
            }
        }
        .task {
            await shoppingAppNM.getAllProducts()
        }
    }
    
}

#Preview {
    MainView()
}
