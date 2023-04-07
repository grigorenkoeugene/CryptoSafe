//
//  CryptoCurrencyTableViewModel.swift
//  CryptoSafe
//
//  Created by admin on 03.04.2023.
//

import Foundation

protocol CryptoCurrencyTableViewModel {
    func fetchAssets(completion: @escaping (Error?) -> Void)
    func sortAssets(by sortOrder: SortOrder)
}
