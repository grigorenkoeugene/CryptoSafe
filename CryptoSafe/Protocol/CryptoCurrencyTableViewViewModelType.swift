
import Foundation

protocol CryptoCurrencyTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CryptoCurrencyTableViewCellViewModelType?
    func fetchAssets(completion: @escaping (Error?) -> Void)
    func sortAssets(by sortOrder: SortOrder)
    func asset(atIndex index: Int) -> Asset?
    func cyrrencyDetailCellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyDetailViewModel?
    func cyrrencyDetailViewModel(forAsset asset: Asset) -> CurrencyDetailViewModel
}
