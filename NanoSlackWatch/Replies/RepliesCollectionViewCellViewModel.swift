//
//  RepliesCollectionViewCellViewModel.swift
//  NanoSlackWatch
//
//  Created by Jinwoo Kim on 3/28/24.
//

import Observation
import SlackCore

actor RepliesCollectionViewCellViewModel {
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
    @MainActor var text: String? {
        get {
            access(keyPath: \.text)
            return _text
        }
        set {
            withMutation(keyPath: \.text) {
                _text = newValue
            }
        }
    }
    
    @MainActor private var _profile: SlackCore.SlackAPIService.UserProfileGetResponse.Profile?
    @MainActor private var _text: String?
    private let _$observationRegistrar = Observation.ObservationRegistrar()
    
    func load(itemModel: RepliesItemModel?) async throws {
        await MainActor.run {
            self.profile = nil
            self.text = nil
        }
        
        guard let message: [String: Any] = itemModel?.userInfo?[RepliesItemModel.messageKey] as? [String: Any] else {
            return
        }
        
        let text: String? = message["text"] as? String
        
        guard !Task.isCancelled else { return }
        
        await MainActor.run {
            self.text = text
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
        keyPath: KeyPath<RepliesCollectionViewCellViewModel , Member>
    ) {
        _$observationRegistrar.access(self, keyPath: keyPath)
    }
    
    private nonisolated func withMutation<Member, MutationResult>(
        keyPath: KeyPath<RepliesCollectionViewCellViewModel , Member>,
        _ mutation: () throws -> MutationResult
    ) rethrows -> MutationResult {
        try _$observationRegistrar.withMutation(of: self, keyPath: keyPath, mutation)
    }
}

extension RepliesCollectionViewCellViewModel: Observation.Observable {
}
