//
//  SlackAPIService+ConversationsHistory.swift
//  
//
//  Created by Jinwoo Kim on 3/23/24.
//

import Foundation

extension SlackAPIService {
    public func conversationsHistory(channelID: String) async throws -> ConversationsHistoryResponse {
        let data: Data = try await _conversationsHistory(channelID: channelID)
        return try decode(data: data)
    }
    
    func _conversationsHistory(channelID: String) async throws -> Data {
        try await request(
            path: "/api/conversations.history",
            queryItems: [
                .init(name: "channel", value: channelID)
            ]
        )
    }
}

extension SlackAPIService {
    public struct ConversationsHistoryResponse: Decodable {
        public let ok: Bool
        public let messages: [Message]
        public let hasMore: Bool
        public let pinCount: Int
    }
}

extension SlackAPIService.ConversationsHistoryResponse {
    public struct Message: Decodable {
        public let user: String?
        public let type: String?
        public let ts: String?
        public let clientMsgId: String?
        public let text: String? // Markdown
        public let team: String?
        public let files: [File]?
    }
}

extension SlackAPIService.ConversationsHistoryResponse.Message {
    public struct File: Decodable {
        public let id: String?
        public let created: Date?
        public let timestamp: Date?
        public let name: String?
        public let title: String?
        public let mimetype: String? // image/png
        public let filetype: String? // png
        public let prettyType: String? // PNG
        public let size: UInt64?
        public let mode: String?
        public let urlPrivate: URL?
        public let urlPrivateDownload: URL?
        public let thumb64: URL?
        public let thumb80: URL?
        public let thumb360: URL?
        public let thumb360W: Int?
        public let thumb360H: Int?
        public let thumb160: URL?
        public let originalW: Int?
        public let originalH: Int?
        public let thumbTiny: String? // base64
        public let permalink: String? // Open In Slack
        public let isStarred: Bool?
        public let hasRichPreview: Bool?
        public let fileAccess: String?
    }
}
