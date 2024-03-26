//
//  SlackAPIService+ConversationsRepliesTests.swift
//  
//
//  Created by Jinwoo Kim on 3/26/24.
//

import Foundation
import UniformTypeIdentifiers
import Testing
@testable import SlackCore

extension SlackAPIService {
    struct ConversationsRepliesTests {
        @Test(.tags("testConversationsReplies")) func testConversationsReplies() async throws {
            let (channelID, threadID): (String, String) = try await getFirstChannelIDAndThreadID()
            
            let conversationsReplies: SlackAPIService.ConversationsRepliesResponse = try await SlackAPIService.shared.conversationsReplies(channelID: channelID, threadID: threadID)
            
            #expect(!conversationsReplies.messages.isEmpty)
        }
        
        @Test(.tags("testGetConversationsRepliesDictionary")) func testGetConversationsListDictionary() async throws {
            let (channelID, threadID): (String, String) = try await getFirstChannelIDAndThreadID()
            
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
                
                _ = SlackAPIService.shared.cxxInterop_getConversationsRepliesDictionary(channelID: channelID, threadID: threadID, completionHandler: unsafeBitCast(completionHandler, to: UnsafeRawPointer.self))
            }
            
            let messages: NSArray = try #require(dictionary["messages"] as? NSArray)
            #expect(messages.count > .zero)
        }
        
        @Test(.tags("testDecodeConversationsReplies")) func testDecodeConversationsList() throws {
            let url: URL = try #require(Bundle.module.url(forResource: "sample_conversations_replies", withExtension: UTType.json.preferredFilenameExtension))
            let data: Data = try #require(try Data(contentsOf: url))
            let response: SlackAPIService.ConversationsRepliesResponse = try SlackAPIService.shared.decode(data: data)
            #expect(!response.messages.isEmpty)
        }
        
        private func getFirstChannelIDAndThreadID() async throws -> (channelID: String, threadID: String) {
            let conversationsList: SlackAPIService.ConversationsListResponse = try await SlackAPIService.shared.conversationsList()
            let channelID: String = try #require(conversationsList.channels.first?.id)
            let conversationsHistory: SlackAPIService.ConversationsHistoryResponse = try await SlackAPIService.shared.conversationsHistory(channelID: channelID)
            let threadID: String = try #require(conversationsHistory.messages.first?.ts)
            
            return (channelID, threadID)
        }
    }
}
