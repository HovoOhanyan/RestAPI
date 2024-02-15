//
//  URLEncoder.swift
//  Networking
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

public struct URLEncoder {
    static func encodeParameters(for urlRequest: inout URLRequest, parameters: HTTPParameters) throws {
        guard let url = urlRequest.url else { throw HTTPNetworkError.missingURL}
        guard let parameters = parameters else { return }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
    }
    
    static func encodeBody(for urlRequest: inout URLRequest, body: Any?) throws {
        if let body = body as? Codable {
            guard let data = try? JSONEncoder().encode(body) else {
                throw HTTPNetworkError.encodingFailed
            }
            
            urlRequest.httpBody = data
        }
    }
    
    static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders) throws {
        guard let headers = headers else { return }
        
        for (key, value) in headers {
            urlRequest.setValue("\(value)", forHTTPHeaderField: key)
        }
    }
    
    static func setHeaders(for urlRequest: inout URLRequest, withAccessToken accessToken: String) {
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
}
