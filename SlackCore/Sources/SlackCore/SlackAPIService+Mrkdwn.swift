//
//  SlackAPIService+Mrkdwn.swift
//  
//
//  Created by Jinwoo Kim on 3/28/24.
//

import Foundation
import RegexBuilder

// https://app.slack.com/block-kit-builder
// https://api.slack.com/reference/surfaces/formatting

extension SlackAPIService {
    public func parseMrkdwnStringToAttributedString() -> AsyncThrowingStream<AttributedString, Error> {
        let (stream, continuation) = AsyncThrowingStream<AttributedString, Error>.makeStream(bufferingPolicy: .bufferingNewest(1))
        
        let task: Task<Void, Never> = .init { 
            
        }
        
        continuation.onTermination = { _ in
            task.cancel()
        }
        
        return stream
    }
}
