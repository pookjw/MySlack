//
//  SlackAPIService+ConversationsTests.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import Foundation
import UniformTypeIdentifiers
import Testing
@testable import SlackCore

extension SlackAPIService {
    struct ConversationsTests {
        @Test(.tags("testConversations")) func testConversations() async throws {
            let conversations: SlackAPIService.ConversationsResponse = try await SlackAPIService.shared.conversations()
            #expect(!conversations.channels.isEmpty)
        }
        
        @Test(.tags("testGetConversationsDictionary")) func testGetConversationsDictionary() async throws {
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
                
                _ = SlackAPIService.shared.cxxInterop_getConversationsDictionary(completionHandler: unsafeBitCast(completionHandler, to: UnsafeRawPointer.self))
            }
            
            let channels: NSArray = dictionary["channels"] as! NSArray
            #expect(channels.count > .zero)
        }
        
        @Test(.tags("testDecodeConversations")) func testDecodeConversations() throws {
            let url: URL = try #require(Bundle.module.url(forResource: "sample_conversations_list", withExtension: UTType.json.preferredFilenameExtension))
            let data: Data = try #require(try Data(contentsOf: url))
            _ = try SlackAPIService.shared.decode(type: SlackAPIService.ConversationsResponse.self, data: data)
        }
    }
}
