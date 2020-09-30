//
//  CreateChallengeViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI
import Combine

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject {
    
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    
    @Published var error: IncrementError?
    @Published var isLoading: Bool = false
    
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = [AnyCancellable]()
    private let challengeService: ChallengeServiceProtocol
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService(), challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
            case .createChallenge:
                isLoading = true
                currentUserId().flatMap { userId -> AnyPublisher<Void, IncrementError> in
                    return self.createChallenge(userId: userId)
                }
                .sink { completion in
                    self.isLoading = false
                    switch completion {
                        case let .failure(error):
                            self.error = error
                        case .finished:
                            print("finished")
                    }
                } receiveValue: { _ in
                    print("success")
                }.store(in: &cancellables)

        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, IncrementError> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increaseDropdown.number,
              let length = lengthDropdown.number else { return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher() }
        
        let challenge = Challenge(exercise: exercise,
                                  startAmount: startAmount,
                                  increase: increase,
                                  length: length,
                                  userId: userId,
                                  startDate: Date())
        
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    private func currentUserId() -> AnyPublisher<UserId, IncrementError> {
        print("getting user Id")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId, IncrementError> in
            if let userId = user?.uid {
                print("user is logged in")
                return Just(userId)
                    .setFailureType(to: IncrementError.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is being logged in anonumously")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel {
    
    struct ChallengePartViewModel: DropdownItemProtocol {
        
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formattedValue
        }
        
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        init(type: ChallengePartType) {
            self.type = type
            switch type {
                case .exercise:
                    self.options = ExerciseOption.allCases.map{ $0.toDropdownOption }
                case .startAmount:
                    self.options = StartOption.allCases.map{ $0.toDropdownOption }
                case .increase:
                    self.options = IncreaseOption.allCases.map{ $0.toDropdownOption }
                case .length:
                    self.options = LengthOption.allCases.map{ $0.toDropdownOption }
            }
            self.selectedOption = options.first!
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable,  DropdownOptionProtocol {

            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue),
                      formattedValue: rawValue.capitalized
                )
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {

            case one = 1
            case two = 2
            case three = 3
            case four = 4
            case five = 5
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formattedValue: "\(rawValue)"
                )
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {

            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formattedValue: "+\(rawValue)"
                )
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {

            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue),
                      formattedValue: "\(rawValue) days"
                )
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
