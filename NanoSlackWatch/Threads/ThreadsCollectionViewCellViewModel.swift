//
//  ThreadsCollectionViewCellViewModel.swift
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/28/24.
//

import Observation
import SlackCore

actor ThreadsCollectionViewCellViewModel {
    @MainActor var profile: SlackCore.SlackAPIService.UserProfileGetResponse.Profile? {
        get {
            access(keyPath: \.profile)
            return _profile
        }
        set {
            withMutation(keyPath: \.profile) {
                _profile = newValue
            }
        }
    }
    @MainActor var body: AttributedString? {
        get {
            access(keyPath: \.body)
            return _body
        }
        set {
            withMutation(keyPath: \.body) {
                _body = newValue
            }
        }
    }
    
    @MainActor private var _profile: SlackCore.SlackAPIService.UserProfileGetResponse.Profile?
    @MainActor private var _body: AttributedString?
    private let _$observationRegistrar = Observation.ObservationRegistrar()
    
    func load(itemModel: ThreadsItemModel?) async throws {
        await MainActor.run {
            self.profile = nil
            self.body = nil
        }
        
        guard let message: [String: Any] = itemModel?.userInfo?[ThreadsItemModel.messageKey] as? [String: Any] else {
            return
        }
        
        let body: AttributedString?
        if let text: String = message["text"] as? String {
            body = try .init(markdown: text, options: .init(allowsExtendedAttributes: true), baseURL: nil)
        } else {
            body = nil
        }
        guard !Task.isCancelled else { return }
        
        await MainActor.run {
            self.body = body
        }
        
        guard let userID: String = message["user"] as? String else {
            return
        }
        
        let profileResponse: SlackAPIService.UserProfileGetResponse = try await SlackAPIService.shared.userProfileGet(userID: userID)
        let profile: SlackAPIService.UserProfileGetResponse.Profile? = profileResponse.profile
        
        guard !Task.isCancelled else { return }
        
        await MainActor.run {
            self.profile = profile
        }
    }
    
    private nonisolated func access<Member>(
        keyPath: KeyPath<ThreadsCollectionViewCellViewModel , Member>
    ) {
        _$observationRegistrar.access(self, keyPath: keyPath)
    }
    
    private nonisolated func withMutation<Member, MutationResult>(
        keyPath: KeyPath<ThreadsCollectionViewCellViewModel , Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
    }
}

extension ThreadsCollectionViewCellViewModel: Observation.Observable {
}
