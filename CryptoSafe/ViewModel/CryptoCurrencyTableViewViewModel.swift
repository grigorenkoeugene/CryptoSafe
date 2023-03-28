import Foundation

enum SortOrder {
    case ascending
    case descending
    case back
}

class CryptoCurrencyTableViewViewModel: CryptoCurrencyTableViewViewModelType {
    
    // MARK: - Properties

    private var assets: [Asset] = []
    private var originalAssets: [Asset] = []

    
    // MARK: - Methods for getting data

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
    
    // MARK: - Data sorting method

    func sortAssets(by sortOrder: SortOrder) {
        switch sortOrder {
        case .ascending:
            assets = assets.sorted { (asset1, asset2) -> Bool in
                return convertToDouble(asset1.priceUsd) ?? 0 < convertToDouble(asset2.priceUsd) ?? 0
            }
        case .descending:
            assets = assets.sorted { (asset1, asset2) -> Bool in
                return convertToDouble(asset1.priceUsd) ?? 0 > convertToDouble(asset2.priceUsd) ?? 0
            }
        case .back:
            assets = originalAssets
        }
    }
    
    // MARK: - Method

    func numberOfRows() -> Int {
        return assets.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CryptoCurrencyTableViewCellViewModelType? {
        let assets = assets[indexPath.row]
        return CryptoCurrencyTableViewCellViewModel(assets: assets)
    }
    
    func asset(atIndex index: Int) -> Asset? {
        guard index >= 0, index < assets.count else { return nil }
        return assets[index]
    }
    
    func cyrrencyDetailCellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyDetailViewModel? {
        guard let asset = asset(atIndex: indexPath.row) else { return nil }
        return CurrencyDetailViewModel(id: asset.id, name: asset.name, supply: asset.supply)
    }

    func cyrrencyDetailViewModel(forAsset asset: Asset) -> CurrencyDetailViewModel {
        return CurrencyDetailViewModel(id: "id: \(asset.id)", name: "name: \(asset.name)", supply: "supply: \(asset.supply)")
    }
    
    
    func formatPrice(_ price: String?) -> String {
        guard let priceString = price, let priceDouble = Double(priceString) else {
            return "$0.00"
        }
        return String(format: "$%.5f", priceDouble)
    }
    
    func convertToDouble(_ string: String?) -> Double? {
        guard let string = string else { return nil }
        return Double(string)
    }

}
