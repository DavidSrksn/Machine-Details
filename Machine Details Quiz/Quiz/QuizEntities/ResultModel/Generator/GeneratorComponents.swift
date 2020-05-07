//
//  GeneratorComponents.swift
//  Machine Details
//
//  Created by David Sarkisyan on 15.03.2020.
//  Copyright © 2020 DavidS. All rights reserved.
//

enum GeneratorFrequency{ // частота
    case f705
    case f715
    case f702
    case f709
    case f716
    case f712
    case f727
    case f731
    case f915
    case f920
    case f925
    case f945
    case f950
    case f960
    case f970
    case f980
    case f1357
    case f1350
    case f1395
    case f1410
    case f1432
    case f1440
    case f1447
    case f1455
    case f1462
    case f1470
    case f2820
    case f2805
    case f2850
    case f2895
    case f2910
    case f2919
    case f2925
    
    static let allCases: [GeneratorFrequency] = [
        .f705,
        .f715,
        .f702,
        .f709,
        .f716,
        .f712,
        .f727,
        .f731,
        .f915,
        .f920,
        .f925,
        .f945,
        .f950,
        .f960,
        .f970,
        .f980,
        .f1357,
        .f1350,
        .f1395,
        .f1410,
        .f1432,
        .f1440,
        .f1447,
        .f1455,
        .f1462,
        .f1470,
        .f2820,
        .f2805,
        .f2850,
        .f2895,
        .f2910,
        .f2919,
        .f2925
    ]
    
    static func allGeneratorOptions() -> [(Double, String)] {
        var sourceFrequencyOptions: [(Double, String)] = []
        
        for option in GeneratorFrequency.allCases{
            sourceFrequencyOptions.append(option.rawValue)
        }
        
        return sourceFrequencyOptions
    }
    
}

extension GeneratorFrequency: RawRepresentable{
    public typealias RawValue = (Double,String)
    
    public init?(rawValue: RawValue) {
        switch rawValue{
        case (705, "90LA8"): self = .f705
        case (715, "90LB8"): self = .f715
        case (702, "100L8"): self = .f702
        case (709, "112MA8"): self = .f709
        case (716, "132S8"): self = .f716
        case (712, "132M8"): self = .f712
        case (727, "160S8"): self = .f727
        case (731, "180M8"): self = .f731
        case (915, "17A6"): self = .f915
        case (920, "80A6"): self = .f920
        case (925, "90L6"): self = .f925
        case (945, "100L6"): self = .f945
        case (950, "112MA6"): self = .f950
        case (960, "132S6"): self = .f960
        case (970, "160S6"): self = .f970
        case (980, "180M6"): self = .f980
        case (1357, "71A4"): self = .f1357
        case (1350, "71B4"): self = .f1350
        case (1395, "80A4"): self = .f1395
        case (1410, "100S4"): self = .f1410
        case (1432, "112M4"): self = .f1432
        case (1440, "132S4"): self = .f1440
        case (1447, "132M4"): self = .f1447
        case (1455, "160S4"): self = .f1455
        case (1462, "180S4"): self = .f1462
        case (1470, "180M4"): self = .f1470
        case (2820, "71A2"): self = .f2820
        case (2805, "71B2"): self = .f2805
        case (2850, "80A2"): self = .f2850
        case (2895, "112M2"): self = .f2895
        case (2910, "132M2"): self = .f2910
        case (2919, "180S2"): self = .f2919
        case (2925, "180M2"): self = .f2925
        default:
            return nil
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case .f705: return (705, "90LA8")
        case .f715: return (715, "90LB8")
        case .f702: return (702, "100L8")
        case .f709: return (709, "112MA8")
        case .f716: return (716, "132S8")
        case .f712: return (712, "132M8")
        case .f727: return (727, "160S8")
        case .f731: return (731, "180M8")
        case .f915: return (915, "17A6")
        case .f920: return (920, "80A6")
        case .f925: return (925, "90L6")
        case .f945: return (945, "100L6")
        case .f950: return (950, "112MA6")
        case .f960: return (960, "132S6")
        case .f970: return (970, "160S6")
        case .f980: return (980, "180M6")
        case .f1357: return (1357, "71A4")
        case .f1350: return (1350, "71B4")
        case .f1395: return (1395, "80A4")
        case .f1410: return (1410, "100S4")
        case .f1432: return (1432, "112M4")
        case .f1440: return (1440, "132S4")
        case .f1447: return (1447, "132M4")
        case .f1455: return (1455, "160S4")
        case .f1462: return (1462, "180S4")
        case .f1470: return (1470, "180M4")
        case .f2820: return (2820, "71A2")
        case .f2805: return (2805, "71B2")
        case .f2850: return (2850, "80A2")
        case .f2895: return (2895, "112M2")
        case .f2910: return (2910, "132M2")
        case .f2919: return (2919, "180S2")
        case .f2925: return (2925, "180M2")
        }
    }
}


