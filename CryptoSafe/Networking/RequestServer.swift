//
//  File.swift
//  CryptoSafe
//
//  Created by admin on 06.03.2023.
//

import Foundation

class RequestServer {
    func fetchAssets(completion: @escaping ([Asset]?) -> Void) {
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let assets = try? decoder.decode(AssetsResponse.self, from: data) else {
                completion(nil)
                return
            }
            
            completion(assets.data)
        }.resume()
    }
}
