//
//  CryptoCurrencyDetailViewModel.swift
//  CryptoSafe
//
//  Created by admin on 03.04.2023.
//

import Foundation

protocol CryptoCurrencyDetailViewModel {
    func cyrrencyDetailViewModel(forAsset asset: Asset) -> CurrencyDetailViewModel
}
