//
//  NetworkingMeneger.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation
import Networking

final class NetworkManager: INetworkManager {
    let baseURL = "https://openapiv1.coinstats.app/coins"
    
    private let headers = [
      "accept": "application/json",
      "X-API-KEY": "llph/mluJBiF5E7rFTY3/olGaidXD3Nq0FxDpFdo4iA="
    ]
    
    func sendGetRequest(parameters: HTTPParameters) async throws -> CoinResponse? {
        let urlSessionConfiguration = URLSessionConfiguration(url: baseURL,
                                                              parameters: parameters,
                                                              headers: headers,
                                                              method: .get)
        
        return try await URLSession.shared.execute(with: urlSessionConfiguration,
                                                   dataType: CoinResponse.self)
    }
}
