import Foundation



class MainTableViewModel: MainTableViewViewModelType {
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainTableViewCellViewModelType? {
        let assets = assets[indexPath.row]
        return MainTableViewCellViewModel(assets: assets) 
    }
    
    private var assets: [Asset] = []
    private var originalAssets: [Asset] = []
    private var sortOrder: SortOrder = .back

    func numberOfRows() -> Int {
        return assets.count
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
