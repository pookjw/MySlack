//
//  SlackAPIService+ConversationsHistoryTests.swift
//  
//
//  Created by Jinwoo Kim on 3/23/24.
//

import Foundation
import UniformTypeIdentifiers
import Testing
@testable import SlackCore

extension SlackAPIService {
    struct ConversationsHistoryTests {
        @Test(.tags("testConversationsHistory")) func testConversationsHistory() async throws {
            let channelID: String = try await getFirstChannelID()
            let conversationsHistory: SlackAPIService.ConversationsHistoryResponse = try await SlackAPIService.shared.conversationsHistory(channelID: channelID)
            #expect(!conversationsHistory.messages.isEmpty)
        }
        
        @Test(.tags("testGetConversationsHistoryDictionary")) func testGetConversationsHistoryDictionary() async throws {
            let channelID: String = try await getFirstChannelID()
            
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
                
                _ = SlackAPIService.shared.cxxInterop_getConversationsHistoryDictionary(channelID: channelID, completionHandler: unsafeBitCast(completionHandler, to: UnsafeRawPointer.self))
            }
            
            let messages: NSArray = try #require(dictionary["messages"] as? NSArray)
            #expect(messages.count > .zero)
        }
        
        @Test(.tags("testDecodeConversationsHistory")) func testDecodeConversationsHistory() throws {
            let url: URL = try #require(Bundle.module.url(forResource: "sample_conversations_history", withExtension: UTType.json.preferredFilenameExtension))
            let data: Data = try #require(try Data(contentsOf: url))
            let response: SlackAPIService.ConversationsHistoryResponse = try SlackAPIService.shared.decode(data: data)
            #expect(response.messages.count == 4)
        }
        
        private func getFirstChannelID() async throws -> String {
            let conversationsList: SlackAPIService.ConversationsListResponse = try await SlackAPIService.shared.conversationsList()
            return try #require(conversationsList.channels.first?.id)
        }
    }
}
