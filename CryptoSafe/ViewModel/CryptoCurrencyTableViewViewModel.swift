import Foundation

enum SortOrder {
    case ascending
    case descending
    case down
    case up
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
            self?.assets.append(contentsOf: assets)
            self?.originalAssets.append(contentsOf: assets)
            completion(nil)
        }
    }
    
    // MARK: - Data sorting method

    func sortAssets(by sortOrder: SortOrder) {
        switch sortOrder {
        case .ascending:
            assets = assets.sorted(by: { asset1, asset2 in
                asset1.marketData.priceUsd ?? 0 < asset2.marketData.priceUsd ?? 0
            })
        case .descending:
            assets = assets.sorted(by: { asset1, asset2 in
                asset1.marketData.priceUsd ?? 0 > asset2.marketData.priceUsd ?? 0
            })
        case .down:
            assets = assets.sorted(by: { asset1, asset2 in
                asset1.marketData.percentChangeUSDLast1Hour > asset2.marketData.percentChangeUSDLast1Hour
            })
        case .up:
            assets = assets.sorted(by: { asset1, asset2 in
                asset1.marketData.percentChangeUSDLast1Hour < asset2.marketData.percentChangeUSDLast1Hour
            })        case .back:
            assets = originalAssets
        }
    }
    
    // MARK: - Method

    func numberOfRows() -> Int {
        assets.count
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
        return CurrencyDetailViewModel(id: asset.id, name: asset.name, symbol: asset.symbol)
    }

    func cyrrencyDetailViewModel(forAsset asset: Asset) -> CurrencyDetailViewModel {
        return CurrencyDetailViewModel(id: "id: \(asset.id))", name: "name: \(asset.name)", symbol: "supply: \(asset.symbol)")
    }
}
