import UIKit
import SwiftUI

@MainActor
public final class MainFlowCoordinator {
    private let navigation: UINavigationController

    public init(with navigation: UINavigationController) {
        self.navigation = navigation
    }

    /// Entry point to the flow
    public func start() {
        let viewModel = MainViewModel()
        let view = MainViewController(viewModel: viewModel)
        navigation.setViewControllers([view], animated: false)
    }
}
