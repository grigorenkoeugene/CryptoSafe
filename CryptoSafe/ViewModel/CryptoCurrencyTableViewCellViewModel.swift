
import Foundation


class CryptoCurrencyTableViewCellViewModel: CryptoCurrencyTableViewCellViewModelType  {

    private var assets: Asset
    
    var name: String {
        return assets.name
    }
    
    var price: String {
        return formatPrice(assets.priceUsd)
    }
    
    init(assets: Asset) {
        self.assets = assets
    }
    
    func formatPrice(_ price: String?) -> String {
        guard let priceString = price, let priceDouble = Double(priceString) else {
            return "$0.00"
        }
        return String(format: "$%.5f", priceDouble)
    }
}
