
import Foundation
import UIKit

class CryptoCurrencyTableViewCellViewModel: CryptoCurrencyTableViewCellViewModelType  {
    
    private var assets: Asset
    
    var name: String {
        assets.name
    }
    
    var price: Double {
        formatPrice(assets.marketData.priceUsd)
    }
    
    var changeUSDLast1Hour: Double {
        formatPrice(assets.marketData.percentChangeUSDLast1Hour)
    }
    
    var changeUSDLast1HourAttributedString: NSAttributedString {
        let changeUSDLast1HourValue = changeUSDLast1Hour
        let changeUSDLast1HourAttributedString = NSMutableAttributedString(string: "Change price to USD last 1 hour: ")
        let color: UIColor = changeUSDLast1HourValue < 0 ? .red : .green
        let valueAttributedString = NSAttributedString(string: String(changeUSDLast1HourValue), attributes: [.foregroundColor: color])
        changeUSDLast1HourAttributedString.append(valueAttributedString)
        return changeUSDLast1HourAttributedString
    }
    
    init(assets: Asset) {
        self.assets = assets
    }
    
    func formatPrice(_ price: Double?) -> Double {
        guard let priceValue = price else {
            return 0.00
        }
        return Double(String(format: "%.5f", priceValue)) ?? 0.00
    }
}
