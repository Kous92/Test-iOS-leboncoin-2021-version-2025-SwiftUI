//
//  StringExtensions.swift
//  TestLeboncoin2025SwiftUI
//
//  Created by Koussaïla Ben Mamar on 06/07/2025.
//

import Foundation

func formatPriceInEuros(with price: Int) -> String {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.numberStyle = .currency
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.currencyCode = "EUR"
    numberFormatter.locale = Locale(identifier: "fr_FR")
    numberFormatter.minimumFractionDigits = 0
    numberFormatter.maximumFractionDigits = 2
    
    return numberFormatter.string(from: NSNumber(value: price)) ?? "Prix inconnu"
}

extension String {
    // Convertit la chaîne de date du format "yyyy-MM-dd'T'HH:mm:ss+0000Z" au format "dd/MM/yyyy à HH:mm"
    func stringToFullDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        guard let date = formatter.date(from: self) else {
            return String(localized: "unknownDate")
        }
        
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .short
        
        let dateString = formatter.string(from: date) // Jour, mois, année
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        let timeString = formatter.string(from: date) // Heures, minutes
        
        return "Le " + dateString + " à " + timeString
    }
    
    // Convertit la chaîne de date du format "yyyy-MM-dd" au format "dd/MM/yyyy"
    func stringToDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: self) else {
            return String(localized: "unknownDate")
        }
        
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateStyle = .long
        let dateString = formatter.string(from: date) /// Jour, mois, année
        
        return dateString
    }
}
