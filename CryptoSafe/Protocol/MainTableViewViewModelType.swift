//
//  MainTableViewViewModelType.swift
//  CryptoSafe
//
//  Created by admin on 27.03.2023.
//

import Foundation

enum SortOrder {
    case ascending
    case descending
    case back
}

protocol MainTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainTableViewCellViewModelType?
    func fetchAssets(completion: @escaping (Error?) -> Void)
    func sortAssets(by sortOrder: SortOrder)
}
