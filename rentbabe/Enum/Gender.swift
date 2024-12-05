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
    private var titles: [Gender: String] {[
        .UNSPECIFIED: "",
        .MALE: "Male",
        .FEMALE: "Female",
    ]}

    var title: String{
        titles[self] ?? ""
    }
}
