//
//  Gender.swift
//  rentbabe
//
//  Created by Richard Gozali on 05/12/24.
//

enum Gender: String {
    case UNSPECIFIED
    case FEMALE = "0"
    case MALE = "1"
}

extension Gender {
    func valueToGender(_ value: String = "") -> Gender {
        return Gender(rawValue: value) ?? .UNSPECIFIED
    }
}
