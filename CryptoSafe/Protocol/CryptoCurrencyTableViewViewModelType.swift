
import Foundation

protocol CryptoCurrencyTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CryptoCurrencyTableViewCellViewModelType?
    func fetchAssets(completion: @escaping (Error?) -> Void)
    func sortAssets(by sortOrder: SortOrder)
    func asset(atIndex index: Int) -> Asset?
    func basicCellViewModel(forIndexPath indexPath: IndexPath) -> CurrencyDetailViewModel?
    func basicViewModel(forAsset asset: Asset) -> CurrencyDetailViewModel
}
