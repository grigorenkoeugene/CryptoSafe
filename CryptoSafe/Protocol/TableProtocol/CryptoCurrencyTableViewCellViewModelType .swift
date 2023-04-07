
import Foundation
import UIKit

protocol CryptoCurrencyTableViewCellViewModelType : AnyObject {
    var name: String { get }
    var price: Double { get }
    var changeUSDLast1Hour: Double { get }
    var changeUSDLast1HourAttributedString: NSAttributedString { get }
    func formatPrice(_ price: Double?) -> Double
}
