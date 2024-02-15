//
//  INetworkManager.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

typealias HTTPParameters = [String: Any]?

protocol INetworkManager {
    func sendGetRequest(parameters: HTTPParameters) async throws -> CoinResponse?
}
