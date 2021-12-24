//
//  ListViewState.swift
//  Musik
//
//

import Foundation

public enum ViewState<ViewModel> {
    case empty(String)
    case loading(String)
    case content(ViewModel)
    case error(String)
}

public extension ViewState {
    
    var message: String? {
        switch self {
        case .empty(let message), .loading(let message), .error(let message):
            return message
        case .content:
            return nil
        }
    }
    
    var viewModel: ViewModel? {
        guard case let .content(viewModel) = self else {
            return nil
        }

        return viewModel
    }
}
