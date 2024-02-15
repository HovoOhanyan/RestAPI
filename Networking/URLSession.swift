//
//  URLSession.swift
//  Networking
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

public extension URLSession {
    @discardableResult
    func execute<T: Codable>(with configuration: URLSessionConfiguration, dataType: T.Type? = nil) async throws -> T? {
        
        do {
            let request = try HTTPNetworkRequest.mekaHTTPRequest(from: configuration.url,
                                                                 parameters: configuration.parameters,
                                                                 headers: configuration.headers,
                                                                 accessToken: configuration.accessToken,
                                                                 body: configuration.body,
                                                                 method: configuration.method)
            
#if DEBUG
            request.log()
#endif
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPNetworkError.responseFailed
            }
            
#if DEBUG
            (response as? HTTPURLResponse)?.log(data: data, error: nil)
#endif
            
            if (200..<300).contains(httpResponse.statusCode) {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } else {
                throw HTTPNetworkResponse.handleNetworkResponse(for: httpResponse)
            }
            
        } catch {
            throw HTTPNetworkError.badRequest
        }
    }
}

