//
//  SlackAPIService+Request.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import Foundation
import AsyncHTTPClient

extension SlackAPIService {
    nonisolated func decode<T: Decodable>(type: T.Type = T.self, data: Data) throws -> T {
        let jsonDecoder: JSONDecoder = .init()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.allowsJSON5 = true
        jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
        
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func request(path: String, queryItems: [URLQueryItem]?) async throws -> Data {
        var components: URLComponents = .init()
        components.scheme = "https"
        components.host = "slack.com"
        components.path = path
        components.queryItems = queryItems
        
        let url: URL = components.url!
        
        var request: HTTPClientRequest = .init(url: url.absoluteString)
        request.method = .GET
        request.headers = .init(
            [
                ("Authorization", "Bearer \(apiKey)")
            ]
        )
        
        let httpClient: HTTPClient = .init(eventLoopGroupProvider: .singleton)
        defer { httpClient.shutdown { _ in } }
        
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
        
        return data
    }
}
