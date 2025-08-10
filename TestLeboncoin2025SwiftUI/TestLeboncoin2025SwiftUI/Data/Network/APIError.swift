//
//  APIError.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/08/2025.
//

enum APIError: Error, Sendable {
    case errorMessage(String)
        
    var errorMessageString: String {
        switch self {
        case .errorMessage(let message):
            return message
        }
    }
}
