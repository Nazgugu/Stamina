//
//  ChallengeService.swift
//  Stamina
//
//  Created by Zhe Liu on 9/22/20.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol ChallengeServiceProtocol {
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error>
}

final class ChallengeService: ChallengeServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func create(_ challenge: Challenge) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            do {
                _ = try self.db.collection("challenges").addDocument(from: challenge)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
