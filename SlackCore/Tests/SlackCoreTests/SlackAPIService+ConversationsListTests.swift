//
//  SlackAPIService+ConversationsListTests.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import Foundation
import UniformTypeIdentifiers
import Testing
@testable import SlackCore

extension SlackAPIService {
    struct ConversationsListTests {
        @Test(.tags("testConversationsList")) func testConversationsList() async throws {
            let conversationsList: SlackAPIService.ConversationsListResponse = try await SlackAPIService.shared.conversationsList()
            #expect(!conversationsList.channels.isEmpty)
        }
        
        @Test(.tags("testGetConversationsListDictionary")) func testGetConversationsListDictionary() async throws {
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
                
                _ = SlackAPIService.shared.cxxInterop_getConversationsListDictionary(completionHandler: unsafeBitCast(completionHandler, to: UnsafeRawPointer.self))
            }
            
            let channels: NSArray = try #require(dictionary["channels"] as? NSArray)
            #expect(channels.count > .zero)
        }
        
        @Test(.tags("testDecodeConversationsList")) func testDecodeConversationsList() throws {
            let url: URL = try #require(Bundle.module.url(forResource: "sample_conversations_list", withExtension: UTType.json.preferredFilenameExtension))
            let data: Data = try #require(try Data(contentsOf: url))
            let response: SlackAPIService.ConversationsListResponse = try SlackAPIService.shared.decode(data: data)
            #expect(!response.channels.isEmpty)
        }
    }
}
