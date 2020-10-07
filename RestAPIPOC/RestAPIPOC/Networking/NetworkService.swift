//
//  NetworkService.swift
//  RestAPIPOC
//
//  Created by Siddharth Kumar on 07/10/20.
//  Copyright © 2020 MyOrganisation. All rights reserved.
//

import Foundation

import Foundation

class NetworkService {
    
    private static var successCodes: CountableRange<Int> = 200..<299
    private static var failureCodes: CountableRange<Int> = 400..<499
    
    enum Method: String {
        case GET, POST
    }
    
    enum NetworkError: Error {
        case inValidURLString
        case noNetworkConnectivity
        
        var localizedDescription: String {
            switch self {
            case .inValidURLString:
                return "The URL String is incorrect."
            case .noNetworkConnectivity:
                return "The internet Connectivity is Lost"
            }
        }
    }
    
    static func makeRequest(for urlString: String, method: Method, success: ((Data?) -> Void)? = nil,
                            failure: ((_ data: Data?, _ error: Error?, _ responseCode: Int) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            failure?(nil, NetworkError.inValidURLString, 0)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let defaultSession = URLSession(configuration: .default)
        
        let task = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure?(data, error, 0)
                return
            }
            
            if let error = error {
                failure?(data, error, httpResponse.statusCode)
                return
            }
            
            if self.successCodes.contains(httpResponse.statusCode) {
                success?(data)
            } else if self.failureCodes.contains(httpResponse.statusCode) {
                failure?(data, error as NSError?, httpResponse.statusCode)
            } else {
                let info = [
                    NSLocalizedDescriptionKey: "Request failed with code \(httpResponse.statusCode)",
                    NSLocalizedFailureReasonErrorKey: "Some went wrong."
                ]
                let error = NSError(domain: "NetworkService", code: 0, userInfo: info)
                failure?(data, error, httpResponse.statusCode)
            }
        })
        task.resume()
    }
    
}
