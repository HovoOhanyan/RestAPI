//
//  TodoResponseStruct.swift
//  WorkWithRestAPI
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

struct CoinResponse: Codable {
    let meta: Meta
    let result: [Coin]
}

struct Meta: Codable {
    let page: Int
    let limit: Int
    let itemCount: Int
    let pageCount: Int
    let hasPreviousPage: Bool
    let hasNextPage: Bool
}

struct Coin: Codable {
    let id: String?
    let icon: String?
    let name: String?
    let symbol: String?
    let rank: Int?
    let price: Double?
    let priceBtc: Double?
    let volume: Double?
    let marketCap: Double?
    let availableSupply: Double?
    let totalSupply: Double?
    let priceChange1h: Double?
    let priceChange1d: Double?
    let priceChange1w: Double?
    let websiteUrl: String?
    let redditUrl: String?
    let twitterUrl: String?
    let contractAddress: String?
    let decimals: Int?
    let explorers: [String]?
}
