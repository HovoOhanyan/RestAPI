//
//  URLSessionConfiguration.swift
//  Networking
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

public struct URLSessionConfiguration {
    public var url: String
    public var parameters: HTTPParameters
    public var headers: HTTPHeaders
    public var accessToken: String?
    public var body: Any?
    public var method: HTTPMethod
    public var deliverQueue: DispatchQueue
    
    public init(url: String,
                parameters: HTTPParameters = nil,
                headers: HTTPHeaders = nil,
                accessToken: String? = nil,
                body: Any? = nil,
                method: HTTPMethod,
                deliverQueue: DispatchQueue = DispatchQueue.main) {
        self.url = url
        self.parameters = parameters
        self.headers = headers
        self.body = body
        self.method = method
        self.deliverQueue = deliverQueue
        self.accessToken = accessToken
    }
}
