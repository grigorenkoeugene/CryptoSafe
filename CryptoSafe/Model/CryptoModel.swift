import Foundation


struct AssetsResponse: Codable {
    let data: Asset
}

struct Asset: Codable {
    let id: String
    let symbol: String
    let name: String
    let marketData: MarketData

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let percentChangeUSDLast1Hour: Double

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUSDLast1Hour = "percent_change_usd_last_1_hour"
    }
}

