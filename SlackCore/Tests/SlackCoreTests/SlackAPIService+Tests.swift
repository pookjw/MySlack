//
//  SlackAPIService+Tests.swift
//  
//
//  Created by Jinwoo Kim on 3/19/24.
//

import Testing
@testable import SlackCore

extension SlackAPIService {
    struct Tests {
        @Test(.tags("testGetConversations")) func testGetConversations() async throws {
            try await SlackAPIService.shared.conversations()
        }
    }
}
