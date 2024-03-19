//
//  SlackAPIService.swift
//  
//
//  Created by Jinwoo Kim on 3/14/24.
//

import Foundation
import AsyncHTTPClient
import CxxStdlib

@globalActor
public actor SlackAPIService {
    public static let shared: SlackAPIService = .init()
    
    public static func getSharedInstance() -> SlackAPIService {
        .shared
    }
    
    public func conversations() async throws -> ConversationsResponse {
        try await request(path: "/api/conversations.list", queryItems: nil)
    }
    
    private func request<T: Decodable>(path: String, queryItems: [URLQueryItem]?) async throws -> T {
        var components: URLComponents = .init()
        components.scheme = "https"
        components.host = "slack.com"
        components.path = path
        components.queryItems = queryItems
        
        let url: URL = components.url!
        
        var request: HTTPClientRequest = .init(url: url.path(percentEncoded: true))
        request.method = .GET
        request.headers = .init(
            [
                ("Authorization", "Bearer \(apiKey)")
            ]
        )
        
        let httpClient: HTTPClient = .init(eventLoopGroupProvider: .singleton)
        let response: HTTPClientResponse = try await httpClient.execute(request, timeout: .minutes(1))
        
        var data: Data
        if let contentLength: Int = response.headers.first(name: "Content-Length").flatMap(Int.init) {
            data = .init(capacity: contentLength)
        } else {
            data = .init()
        }
        
        for try await buffer in response.body {
            buffer.readableBytesView.withContiguousStorageIfAvailable { p in
                data.append(p.baseAddress!, count: p.count)
            }
        }
        
        assert(response.headers.first(name: "Content-Length").flatMap(Int.init)! == data.count)
        fatalError()
    }
}
