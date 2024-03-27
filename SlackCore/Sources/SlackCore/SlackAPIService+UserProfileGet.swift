//
//  SlackAPIService+UserProfileGet.swift
//  
//
//  Created by Jinwoo Kim on 3/27/24.
//

import Foundation

extension SlackAPIService {
    public func userProfileGet(userID: String) async throws -> UserProfileGetResponse {
        let data: Data = try await _userProfileGet(userID: userID)
        return try decode(data: data)
    }
    
    func _userProfileGet(userID: String) async throws -> Data {
        try await request(
            path: "/api/users.profile.get",
            queryItems: [
                .init(name: "user", value: userID)
            ]
        )
    }
}

extension SlackAPIService {
    public struct UserProfileGetResponse: Decodable {
        public let ok: Bool?
        public let profile: Profile?
    }
}

extension SlackAPIService.UserProfileGetResponse {
    public struct Profile: Decodable {
        public let title: String?
        public let phone: String?
        public let skype: String?
        public let realName: String?
        public let realNameNormalized: String?
        public let displayName: String?
        public let displayNameNormalized: String?
        public let statusText: String?
        public let statusEmoji: String?
        public let statusEmojiDisplayInfo: [StatusEmojiDisplayInfo]?
        public let statusExpiration: Date?
        public let firstName: String?
        public let lastName: String?
        public let image24: URL?
        public let image32: URL?
        public let image48: URL?
        public let image72: URL?
        public let image192: URL?
        public let image512: URL?
        public let statusTextCanonical: String?
    }
}

extension SlackAPIService.UserProfileGetResponse.Profile {
    public struct StatusEmojiDisplayInfo: Decodable {
        public let emojiName: String?
        public let displayUrl: URL?
        public let unicode: String?
    }
}
