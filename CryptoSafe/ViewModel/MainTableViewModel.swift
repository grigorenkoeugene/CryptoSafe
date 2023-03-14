//
//  MainViewModel.swift
//  CryptoSafe
//
//  Created by admin on 13.03.2023.
//

import Foundation

class MainTableViewModel {
    
    enum SortOrder {
        case ascending
        case descending
        case back
    }
    
    private var assets: [Asset] = []
    private var originalAssets: [Asset] = []
    private var sortOrder: SortOrder = .back

    var numberOfRows: Int {
        return assets.count
    }

    func asset(atIndex index: Int) -> Asset {
        return assets[index]
    }

    func fetchAssets(completion: @escaping (Error?) -> Void) {
        RequestServer().fetchAssets { [weak self] assets in
            guard let assets = assets else {
                completion(NSError(domain: "Ошибка получения данных", code: 0, userInfo: nil))
                return
            }
            self?.assets = assets
            self?.originalAssets = assets
            completion(nil)
        }
    }

    func sortAssets(by sortOrder: SortOrder) {
        switch sortOrder {
        case .ascending:
            assets = assets.sorted { (asset1, asset2) -> Bool in
                guard let priceUsd1 = asset1.priceUsd, let priceUsd2 = asset2.priceUsd else {
                    return false
                }
                return Double(priceUsd1) ?? 0 < Double(priceUsd2) ?? 0
            }
        case .descending:
            assets = assets.sorted { (asset1, asset2) -> Bool in
                guard let priceUsd1 = asset1.priceUsd, let priceUsd2 = asset2.priceUsd else {
                    return false
                }
                return Double(priceUsd1) ?? 0 > Double(priceUsd2) ?? 0
            }
        case .back:
            assets = originalAssets
        }
    }
    
    func formatPrice(_ price: Double?) -> String {
        guard let price = price else {
            return "$0.00"
        }
        return String(format: "$%.5f", price)
    }
    
    func convertToDouble(_ string: String?) -> Double? {
        guard let string = string else { return nil }
        return Double(string)
    }

}
