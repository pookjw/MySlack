//
//  SlackAPIService+UserProfileGetTests.swift
//  
//
//  Created by Jinwoo Kim on 3/27/24.
//

import Foundation
import UniformTypeIdentifiers
import Testing
@testable import SlackCore

extension SlackAPIService {
    struct UserProfileGetTests {
        @Test(.tags("testUserProfileGet")) func testUserProfileGet() async throws {
            let userID: String = try await getFirstProfileID()
            let userProfile: SlackAPIService.UserProfileGetResponse = try await SlackAPIService.shared.userProfileGet(userID: userID)
            
            #expect(userProfile.profile != nil)
        }
        
        @Test(.tags("testGetUserProfileDictionary")) func testGetUserProfileDictionary() async throws {
            let userID: String = try await getFirstProfileID()
            
            let dictionary: NSDictionary = try await withCheckedThrowingContinuation { continuation in
                let completionHandler: @convention(block) (_ dictionary: NSDictionary?, _ error: Error?) -> Void = { dictionary, error in
                    do {
                        if let error: Error {
                            throw error
                        } else {
                            try continuation.resume(with: .success(#require(dictionary)))
                        }
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                }
                
                _ = SlackAPIService.shared.cxxInterop_getUserProfile(userID: userID, completionHandler: unsafeBitCast(completionHandler, to: UnsafeRawPointer.self))
            }
            
            #expect(dictionary["profile"] != nil)
        }
        
        @Test(.tags("testDecodeUserProfileGet")) func testDecodeUserProfileGet() throws {
            let url: URL = try #require(Bundle.module.url(forResource: "sample_user_profile_get", withExtension: UTType.json.preferredFilenameExtension))
            let data: Data = try #require(try Data(contentsOf: url))
            let response: SlackAPIService.UserProfileGetResponse = try SlackAPIService.shared.decode(data: data)
            #expect(response.profile != nil)
        }
        
        private func getFirstProfileID() async throws -> String {
            let conversationsList: SlackAPIService.ConversationsListResponse = try await SlackAPIService.shared.conversationsList()
            let channelID: String = try #require(conversationsList.channels.first?.id)
            let conversationsHistory: SlackAPIService.ConversationsHistoryResponse = try await SlackAPIService.shared.conversationsHistory(channelID: channelID)
            let userID: String = try #require(conversationsHistory.messages.first?.user)
            
            return userID
        }
    }
}
