//
//  IViewModel.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

protocol IViewModel {
    var networkManager: INetworkManager { get }
    func getCoins(parameters: HTTPParameters) async throws -> [Coin]?
    
    var coinsGet: (([Coin]?) -> Void)? { get set }
}
