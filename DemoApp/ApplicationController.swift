import UIKit

@MainActor
final class ApplicationController {
    private let navigation: UINavigationController
    private var mainFlow: MainFlowCoordinator?

    init(navigation: UINavigationController) {
        self.navigation = navigation
        navigation.setNavigationBarHidden(true, animated: false)

        setupStartFlow()
    }

    func setupWithLaunchOptions(_: UIScene.ConnectionOptions?) {
        mainFlow?.start()
    }

    func didBecomeActive() {}
    func willResignActive() {}

    // MARK: - Private helpers

    private func setupStartFlow() {
        mainFlow = MainFlowCoordinator(with: navigation)
    }
}
