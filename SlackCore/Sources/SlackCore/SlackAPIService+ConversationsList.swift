//
//  SlackAPIService+ConversationsList.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import Foundation

extension SlackAPIService {
    public func conversationsList() async throws -> ConversationsListResponse {
        let data: Data = try await _conversationsList()
        return try decode(data: data)
    }
    
    func _conversationsList() async throws -> Data {
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
    public struct ConversationsListResponse: Decodable {
        public let ok: Bool
        public let channels: [Channel]
        public let responseMetadata: ResponseMetadata
    }
}

extension SlackAPIService.ConversationsListResponse {
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

extension SlackAPIService.ConversationsListResponse.Channel {
    public struct Topic: Decodable {
        public let value: String
        public let creator: String
        public let lastSet: Date
    }
}

extension SlackAPIService.ConversationsListResponse.Channel {
    public struct Purpose: Decodable {
        public let value: String
        public let creator: String
        public let lastSet: Date
    }
}

extension SlackAPIService.ConversationsListResponse {
    public struct ResponseMetadata: Decodable {
        public let nextCursor: String
    }
}

