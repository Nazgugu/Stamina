//
//  CreateChallengeViewModel.swift
//  Stamina
//
//  Created by Zhe Liu on 9/21/20.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject {
    @Published var dropdownds: [ChallengePartViewModel] = [
        .init(type: .exercise),
        .init(type: .startAmount),
        .init(type: .increase),
        .init(type: .length)
    ]
    
    enum Action {
        case selectOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropdownIndex != nil
    }
    
    var selectedDropdownIndex: Int? {
        dropdownds.enumerated().first(where: { $0.element.isSelected })?.offset
    }
    
    var displayedOptions: [DropdownOption] {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return [] }
        return dropdownds[selectedDropdownIndex].options
    }
    
    func send(action: Action) {
        switch action {
        case let .selectOption(index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOption()
            dropdownds[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }
    
    func clearSelectedOption() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdownds[selectedDropdownIndex].options.indices.forEach { index in
            dropdownds[selectedDropdownIndex].options[index].isSelected = false
        }
    }
    
    func clearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropdownds[selectedDropdownIndex].isSelected = false
    }
}

extension CreateChallengeViewModel {
    
    struct ChallengePartViewModel: DropdownItemProtocol {
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            options.first(where:  { $0.isSelected })?.formattedValue ?? ""
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
                .init(type: .text(rawValue), formattedValue: rawValue.capitalized, isSelected: self == .pullups)
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {

            case one = 1
            case two = 2
            case three = 3
            case four = 4
            case five = 5
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formattedValue: "\(rawValue)", isSelected: self == .one)
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {

            case one = 1, two, three, four, five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formattedValue: "+\(rawValue)", isSelected: self == .one)
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {

            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formattedValue: "\(rawValue) days", isSelected: self == .seven)
            }
        }
    }
}
