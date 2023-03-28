
import Foundation

class CurrencyDetailViewModel: CurrencyDetailViewModelType {
    let id: String
    let name: String
    let supply: String
    
    init(id: String, name: String, supply: String) {
        self.id = id
        self.name = name
        self.supply = supply
    }
}
