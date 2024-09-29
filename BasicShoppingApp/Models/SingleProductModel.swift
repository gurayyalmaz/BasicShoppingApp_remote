//
//  File.swift
//  BasicShoppingApp
//
//  Created by Gyuray Yalmaz on 26.09.24.
//

import Foundation

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let thumbnail: String
    let rating: Double
}

