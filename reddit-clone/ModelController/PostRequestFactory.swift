//
//  Router.swift
//  reddit-clone
//
//  Created by Daniel Torres on 1/23/20.
//  Copyright © 2020 dansTeam. All rights reserved.
//

import Foundation

protocol RequestMaker {
    
    var host: String { get }
    var scheme: String { get }
    var httpMethod: String { get }
    var path: String { get }
    var urlComponents: URLComponents { get }
    var queryItems: [URLQueryItem]? { get }
    var httpBody: Data? {get}
    var headers: [String: String]? { get }
    
    func makeRequest() -> URLRequest
}

enum PostRequestFactory: RequestMaker{
    case next(after: String)
    case getTopPosts
    
    var host: String {
        return "www.reddit.com"
    }
    
    var scheme: String {
        switch self {
        case .next(after: _), .getTopPosts:
            return "http"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .next(after: _), .getTopPosts:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .next(after: _), .getTopPosts:
            return "/top.json"
        }
    }
    
    var urlComponents: URLComponents{
        switch self {
        case .next(after: _), .getTopPosts:
            var urlComponents = URLComponents()
            urlComponents.scheme = scheme
            urlComponents.host = host
            urlComponents.path = path
            urlComponents.queryItems = queryItems
            return urlComponents
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .next(after: let fullname):
            return [URLQueryItem(name: "after", value: fullname)]
        case .getTopPosts:
            return nil
        }
    }
    
    var httpBody: Data?{
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    func makeRequest() -> URLRequest {
        switch self {
        case .next(after: _), .getTopPosts:
            assert(urlComponents.url != nil)
            var urlRequest = URLRequest(url: urlComponents.url!)
            urlRequest.httpMethod = httpMethod
            urlRequest.httpBody = httpBody
            urlRequest.allHTTPHeaderFields = headers
            return urlRequest
        }
    }
}
