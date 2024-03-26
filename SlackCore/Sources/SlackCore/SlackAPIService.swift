//
//  SlackAPIService.swift
//  
//
//  Created by Jinwoo Kim on 3/14/24.
//

import Foundation

// https://api.slack.com/methods

@_expose(Cxx)
@globalActor
public actor SlackAPIService {
    public static let shared: SlackAPIService = .init()
    
    public static func getSharedInstance() -> SlackAPIService {
        .shared
    }
    
    @_expose(Cxx, "getConversationsListDictionary")
    public nonisolated func cxxInterop_getConversationsListDictionary(completionHandler: UnsafeRawPointer) -> Progress {
        typealias CompletionHandlerType = @convention(block) @Sendable (NSDictionary?, Swift.Error?) -> Void
        
        let copiedCompletionHandler: AnyObject = unsafeBitCast(completionHandler, to: AnyObject.self).copy() as AnyObject
        
        let task: Task<Void, Never> = .init { 
            let castedCompletionHandler: CompletionHandlerType = unsafeBitCast(copiedCompletionHandler, to: CompletionHandlerType.self)
            
            do {
                let data: Data = try await _conversationsList()
                let dictionary: NSDictionary = try JSONSerialization.jsonObject(with: data, options: [.json5Allowed]) as! NSDictionary
                castedCompletionHandler(dictionary, nil)
            } catch {
                castedCompletionHandler(nil, error)
            }
        }
        
        let progress: Progress = .init(totalUnitCount: 1)
        
        progress.cancellationHandler = {
            task.cancel()
        }
        
        return progress
    }
    
    @_expose(Cxx, "getConversationsHistoryDictionary")
    public nonisolated func cxxInterop_getConversationsHistoryDictionary(channelID: String, completionHandler: UnsafeRawPointer) -> Progress {
        typealias CompletionHandlerType = @convention(block) @Sendable (NSDictionary?, Swift.Error?) -> Void
        
        let copiedCompletionHandler: AnyObject = unsafeBitCast(completionHandler, to: AnyObject.self).copy() as AnyObject
        
        let task: Task<Void, Never> = .init { 
            let castedCompletionHandler: CompletionHandlerType = unsafeBitCast(copiedCompletionHandler, to: CompletionHandlerType.self)
            
            do {
                let data: Data = try await _conversationsHistory(channelID: channelID)
                let dictionary: NSDictionary = try JSONSerialization.jsonObject(with: data, options: [.json5Allowed]) as! NSDictionary
                castedCompletionHandler(dictionary, nil)
            } catch {
                castedCompletionHandler(nil, error)
            }
        }
        
        let progress: Progress = .init(totalUnitCount: 1)
        
        progress.cancellationHandler = {
            task.cancel()
        }
        
        return progress
    }
    
    @_expose(Cxx, "getConversationsRepliesDictionary")
    public nonisolated func cxxInterop_getConversationsRepliesDictionary(channelID: String, threadID: String, completionHandler: UnsafeRawPointer) -> Progress {
        typealias CompletionHandlerType = @convention(block) @Sendable (NSDictionary?, Swift.Error?) -> Void
        
        let copiedCompletionHandler: AnyObject = unsafeBitCast(completionHandler, to: AnyObject.self).copy() as AnyObject
        
        let task: Task<Void, Never> = .init { 
            let castedCompletionHandler: CompletionHandlerType = unsafeBitCast(copiedCompletionHandler, to: CompletionHandlerType.self)
            
            do {
                let data: Data = try await _conversationsReplies(channelID: channelID, threadID: threadID)
                let dictionary: NSDictionary = try JSONSerialization.jsonObject(with: data, options: [.json5Allowed]) as! NSDictionary
                castedCompletionHandler(dictionary, nil)
            } catch {
                castedCompletionHandler(nil, error)
            }
        }
        
        let progress: Progress = .init(totalUnitCount: 1)
        
        progress.cancellationHandler = {
            task.cancel()
        }
        
        return progress
    }
    
    @_expose(Cxx, "getUserProfile")
    public nonisolated func cxxInterop_getUserProfile(userID: String, completionHandler: UnsafeRawPointer) -> Progress {
        typealias CompletionHandlerType = @convention(block) @Sendable (NSDictionary?, Swift.Error?) -> Void
        
        let copiedCompletionHandler: AnyObject = unsafeBitCast(completionHandler, to: AnyObject.self).copy() as AnyObject
        
        let task: Task<Void, Never> = .init { 
            let castedCompletionHandler: CompletionHandlerType = unsafeBitCast(copiedCompletionHandler, to: CompletionHandlerType.self)
            
            do {
                let data: Data = try await _userProfileGet(userID: userID)
                let dictionary: NSDictionary = try JSONSerialization.jsonObject(with: data, options: [.json5Allowed]) as! NSDictionary
                castedCompletionHandler(dictionary, nil)
            } catch {
                castedCompletionHandler(nil, error)
            }
        }
        
        let progress: Progress = .init(totalUnitCount: 1)
        
        progress.cancellationHandler = {
            task.cancel()
        }
        
        return progress
    }
}
