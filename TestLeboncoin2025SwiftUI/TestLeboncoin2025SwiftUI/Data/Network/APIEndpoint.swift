//
//  APIEndpoint.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//

import Foundation

nonisolated enum APIEndpoint {
    case fetchItems
    case fetchItemCategories
    
    var baseURL: String {
        return "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    }
    
    var path: String {
        switch self {
        case .fetchItems:
            return "listing.json"
        case .fetchItemCategories:
            return "categories.json"
        }
    }
}
