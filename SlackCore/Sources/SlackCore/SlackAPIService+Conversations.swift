//
//  SlackAPIService+Conversations.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import Foundation

extension SlackAPIService {
    public func conversations() async throws -> ConversationsResponse {
        let data: Data = try await _conversations()
        return try decode(data: data)
    }
    
    func _conversations() async throws -> Data {
        try await request(
            path: "/api/conversations.list",
            queryItems: [
                .init(name: "limit", value: "999"),
                .init(name: "types", value: "public_channel,private_channel,mpim,im")
            ]
        )
    }
}

extension SlackAPIService {
    public struct ConversationsResponse: Decodable {
        public let ok: Bool
        public let channels: [Channel]
        public let responseMetadata: ResponseMetadata
    }
}

extension SlackAPIService.ConversationsResponse {
    public struct Channel: Decodable {
        public let id: String
        public let name: String?
        public let isChannel: Bool?
        public let isGroup: Bool?
        public let isPrivate: Bool?
        public let created: Date?
        public let isArchived: Bool?
        public let isGeneral: Bool?
        public let unlinked: Int?
        public let nameNormalized: String?
        public let isShared: Bool?
        public let isOrgShared: Bool?
        public let isPendingExtShared: Bool?
        public let contextTeamId: String?
        public let updated: Date?
        public let parentConversation: String?
        public let creator: String?
        public let isExtShared: Bool?
        public let sharedTeamIds: [String]?
        public let pendingConnectedTeamIds: [String]?
        public let isMember: Bool?
        public let topic: Topic?
        public let purpose: Purpose?
        public let previousNames: [String]?
        public let numMembers: Int?
        public let isUserDeleted: Bool?
        public let priority: Float?
    }
}

extension SlackAPIService.ConversationsResponse.Channel {
    public struct Topic: Decodable {
        public let value: String
        public let creator: String
        public let lastSet: Date
    }
}

extension SlackAPIService.ConversationsResponse.Channel {
    public struct Purpose: Decodable {
        public let value: String
        public let creator: String
        public let lastSet: Date
    }
}

extension SlackAPIService.ConversationsResponse {
    public struct ResponseMetadata: Decodable {
        public let nextCursor: String
    }
}

