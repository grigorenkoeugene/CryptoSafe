import Foundation

final class RequestServer {
    
    enum Crypto: String {
        case bitcoin
        case ethereum
        case tron
        case terra
        case polkadot
        case dogecoin
        case tether
        case stellar
        case cardano
        case xrp
    }

    func fetchAssets(completion: @escaping ([Asset]?) -> Void) {
        let cryptos = [Crypto.bitcoin, Crypto.ethereum, Crypto.tron, Crypto.terra, Crypto.polkadot, Crypto.dogecoin, Crypto.tether, Crypto.stellar, Crypto.cardano, Crypto.xrp]
        var assets: [Asset] = []

        let dispatchGroup = DispatchGroup()

        for crypto in cryptos {
            guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(crypto.rawValue)/metrics") else {
                completion(nil)
                return
            }

            dispatchGroup.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { dispatchGroup.leave() }

                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
//                print(response)
                let decoder = JSONDecoder()
                do {
                    let assetsResponse = try decoder.decode(AssetsResponse.self, from: data)
                    assets.append(assetsResponse.data)
                } catch let error {
                    print("Error decoding JSON \(crypto): \(error.localizedDescription)")
                }
            }.resume()
        }

        dispatchGroup.notify(queue: .main) {
            completion(assets)
        }
    }
}
