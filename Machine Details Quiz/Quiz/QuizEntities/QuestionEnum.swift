//
//  QuizQuestionsEnum.swift
//  Machine Details
//
//  Created by David Sarkisyan on 11.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

enum QuizQestion{
    case scheme
    case transmission
    case smoothness
    case cost
}

extension QuizQestion: RawRepresentable{
    public typealias RawValue = OptionViewModelProtocol
    
    public init?(rawValue: RawValue) {
        if let _ = rawValue as? SchemeOptionViewModel {
            self = .scheme
        }else if let _ = rawValue as? TransmissionOptionViewModel {
            self = .transmission
        }else if let _ = rawValue as? SmooothnessOptionViewModel {
            self = .smoothness
        }else if let _ = rawValue as? CostOptionViewModel {
            self = .cost
        }
        else{
            return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .scheme: return SchemeOptionViewModel()
        case .transmission: return TransmissionOptionViewModel()
        case .smoothness: return SmooothnessOptionViewModel()
        case .cost: return CostOptionViewModel()
        }
    }
}

enum QuizOption{
    static let allCases: [QuizOption] = [.A, .B, .C, .D]
    case A,B,C,D
}
