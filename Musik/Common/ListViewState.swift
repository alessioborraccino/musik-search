//
//  ListViewState.swift
//  Musik
//
//

import Foundation

enum ListViewState<ViewModel> {
    case empty(String)
    case loading(String)
    case content(ViewModel)
    case error(String)
}

extension ListViewState {
    var viewModel: ViewModel? {
        guard case let .content(viewModel) = self else {
            return nil
        }

        return viewModel
    }
}
