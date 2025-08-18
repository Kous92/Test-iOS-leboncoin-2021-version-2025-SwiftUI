//
//  TestLeboncoin2025SwiftUITests.swift
//  TestLeboncoin2025SwiftUITests
//
//  Created by Koussaïla Ben Mamar on 28/06/2025.
//

import Testing
import Foundation
@testable import TestLeboncoin2025SwiftUI

private func normalizeFRSpaces(_ s: String) -> String {
    s.replacingOccurrences(of: "\u{202F}", with: " ")
     .replacingOccurrences(of: "\u{00A0}", with: " ")
     .replacingOccurrences(of: "\u{2009}", with: " ") // fine space éventuelle
}

struct FormattersTests {
    
    /*
    // Possibilité de faire plusieurs tests unitaires avec plusieurs arguments en une seule fonction de test. Attention tout de même à proposer un élément concret pour tous les arguments en entrée pour éviter tout problème lors de l'exécution du test unitaire.
    @Test("Formattage de différents prix en euros", arguments: [0, 50, 12500, 700000])
    func formatPrice(with price: Int) {
        let result = formatPriceInEuros(with: price)
        #expect(normalizeFRSpaces(result) == "50 €")
    }
    */
    
    @Test("Format d'un prix simple en euros")
    func testFormatPriceSimple() {
        let result = formatPriceInEuros(with: 50)
        #expect(normalizeFRSpaces(result) == "50 €") // espace insécable en FR
    }
    
    @Test("Format d'un grand nombre avec séparateur de milliers")
    func testFormatPriceLarge() {
        let result = formatPriceInEuros(with: 12500)
        #expect(normalizeFRSpaces(result) == "12 500 €") // séparateur + insécable
    }
    
    @Test("Format avec valeur zéro")
    func testFormatPriceZero() {
        let result = formatPriceInEuros(with: 0)
        #expect(normalizeFRSpaces(result) == "0 €")
    }
    
    // MARK: - stringToFullDateFormat
    @Test("Conversion date ISO valide en format complet FR")
    func testStringToFullDateFormatValid() {
        let input = "2025-08-18T14:30:00+0000"
        let result = input.stringToFullDateFormat()
        
        // Ex attendu: "Le 18/08/2025 à 16:30" (décalage local FR)
        #expect(result.contains("18/08/2025"))
        #expect(result.contains("à"))
    }
    
    @Test("Conversion date ISO invalide retourne unknownDate")
    func testStringToFullDateFormatInvalid() {
        let input = "invalid-date"
        let result = input.stringToFullDateFormat()
        
        #expect(result == String(localized: "unknownDate"))
    }
    
    // MARK: - stringToDateFormat
    @Test("Conversion yyyy-MM-dd en format long FR")
    func testStringToDateFormatValid() {
        let input = "2025-12-25"
        let result = input.stringToDateFormat()
        
        // Ex attendu: "25 décembre 2025"
        #expect(result.contains("25"))
        #expect(result.contains("2025"))
        #expect(result.contains("décembre"))
    }
    
    @Test("Conversion date invalide retourne unknownDate")
    func testStringToDateFormatInvalid() {
        let input = "25-12-2025"
        let result = input.stringToDateFormat()
        
        #expect(result == String(localized: "unknownDate"))
    }
    
    // MARK: - Tests Localisation
    @Test("Vérifie que le format reste correct même si Locale est en_US")
    func testLocalizationWithUSLocale() {
        let input = "2025-07-04"
        
        // Force une locale différente
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "yyyy-MM-dd"
        
        // Comparaison avec la fonction qui force le fr_FR
        let result = input.stringToDateFormat()
        #expect(result.contains("juillet")) // devrait rester en français
    }
}

