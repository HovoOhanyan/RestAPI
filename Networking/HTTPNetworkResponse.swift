//
//  HTTPNetworkResponse.swift
//  Networking
//
//  Created by Hovo Ohanyan on 15.02.24.
//

import Foundation

struct HTTPNetworkResponse {
    
    // Properly checks and handles the status code of the response
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Error {
        
        guard let res = response else {
            return HTTPNetworkError.FragmentResponse
        }
        
        switch res.statusCode {
        case 401:
            return HTTPNetworkError.authenticationError
        case 400...499:
            return HTTPNetworkError.badRequest
        case 500...599:
            return HTTPNetworkError.serverSideError
        default:
            return HTTPNetworkError.failed
        }
    }
}


extension HTTPURLResponse {
    func log(data: Data?, error: Error?) {
        
        if CommandLine.arguments.contains("-disable-network-log") {
            return
        }
        
        let urlString = url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        
        var responseLog = "\n<<================= RESPONSE =================<<\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }
        
        let statusColorSign = (statusCode >= 200 && statusCode < 300) ? "🟢" : "🔴"
        responseLog += "HTTP \(statusColorSign) \(statusCode) \(path)?\(query)\n"
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in allHeaderFields {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data {
            responseLog += "\n>>=================DATA===================<<\n"
            responseLog += "\n\(body.prettyPrintedJSONString ?? "")\n"
        }
        if error != nil {
            responseLog += "\n 🔺 Error: \(error?.localizedDescription ?? "")\n"
        }
        
        responseLog += "<<===========================================<<\n";
        print(responseLog)
    }
}

//MARK: - This extension created for define the property prettyPrintedJSON String for print in the terminal information from data

public extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }
        
        return prettyPrintedString
    }
}
