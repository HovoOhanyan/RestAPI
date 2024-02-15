//
//  TodoViewModel.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

final class CoinViewModel: IViewModel {
    let networkManager: INetworkManager
    
    var coinsGet: (([Coin]?) -> Void)?
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func getCoins(parameters: HTTPParameters) async -> [Coin]? {
        do {
//            coinsGet?(try await networkManager.sendGetRequest(parameters: parameters)?.result)
            return try await networkManager.sendGetRequest(parameters: parameters)?.result
        } catch {
            print("Error")
        }
        
        return nil
    }
}
