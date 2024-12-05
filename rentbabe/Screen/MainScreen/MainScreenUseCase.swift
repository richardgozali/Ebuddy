//
//  MainScreenUseCase.swift
//  rentbabe
//
//  Created by Richard Gozali on 06/12/24.
//

import Foundation

class MainScreenUseCase {
    var output = Output()
    var callback = Callback()

    func updateTask(_ user: User) {
        output.user = user
        callback.onSubmissionSuccess()
    }
}

extension MainScreenUseCase {
    class Output {
        var user = User()
    }
    class Callback {
        var onSubmissionSuccess: () -> Void = { return }
        var onFetchSuccess: () -> Void = { return }
    }
}
