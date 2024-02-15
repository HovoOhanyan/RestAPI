//
//  HTTPNetworkRequest.swift
//  Networking
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

public typealias HTTPParameters = [String: Any]?
public typealias HTTPHeaders = [String: Any]?


public struct HTTPNetworkRequest {
    
    @discardableResult
    
    static func mekaHTTPRequest(from url: String,
                                parameters: HTTPParameters,
                                headers: HTTPHeaders,
                                accessToken: String? = nil,
                                body: Any?,
                                method: HTTPMethod) throws -> URLRequest {
        guard let url = URL(string: url) else {
            fatalError("URL not found")
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 10.0)
        
        urlRequest.httpMethod = method.rawValue
        
        if let body = body {
            do {
                try URLEncoder.encodeBody(for: &urlRequest, body: body)
            }
        }
        
        if let accessToken {
            URLEncoder.setHeaders(for: &urlRequest, withAccessToken: accessToken)
        }
        
        if method == .post {
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("ios", forHTTPHeaderField: "X-platform")
        } else if method == .get && accessToken != nil {
            urlRequest.setValue("\(accessToken!)", forHTTPHeaderField: "X-API-KEY")
            urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        }
        
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &urlRequest)

        return urlRequest
    }
    
    static func configureParametersAndHeaders(parameters: HTTPParameters,
                                              headers: HTTPHeaders,
                                              request: inout URLRequest) throws {
        
        do {
            if let parameters {
                try URLEncoder.encodeParameters(for: &request, parameters: parameters)
            }
            
            if let headers {
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
        } catch {
            
        }
    }
}

extension URLRequest {
    func log(){
        
        if CommandLine.arguments.contains("-disable-network-log") {
            return
        }
        
        let urlString = url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)
        
        let method = httpMethod != nil ? "\(httpMethod ?? "")" : ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"
        
        var requestLog = "\n>>================= REQUEST =================>>\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key, value) in allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = httpBody {
            requestLog += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        
        requestLog += "\n>>===========================================>>\n";
        print(requestLog)
    }
}
