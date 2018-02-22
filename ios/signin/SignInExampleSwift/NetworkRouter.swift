//
//  NetworkRouter.swift
//  JSONTutorial
//
//  Created by 2B on 2/18/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//

import Foundation
import Alamofire


enum NetworkRouter: URLRequestConvertible {
    
    static let baseURLPath = "https://www.googleapis.com/oauth2/v3/"
    
    case tokenInfo(String)
    
    var method: HTTPMethod {
        switch self {
        case .tokenInfo:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .tokenInfo:
            return "tokeninfo"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let params: [String: Any] = {
            switch self {
            case .tokenInfo(let tokenID):
                return ["id_token": tokenID]
            }
        }()
        
        let url = try NetworkRouter.baseURLPath.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        
        return try URLEncoding.default.encode(request, with: params)
    }
    
}

