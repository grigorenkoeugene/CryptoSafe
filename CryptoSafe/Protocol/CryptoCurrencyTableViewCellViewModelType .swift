
import Foundation

protocol CryptoCurrencyTableViewCellViewModelType : AnyObject {
    var name: String { get }
    var price: String { get }
    func formatPrice(_ price: String?) -> String
}
