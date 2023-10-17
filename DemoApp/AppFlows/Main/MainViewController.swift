import Combine
import UIKit
import WebKit


final class MainViewController: UIViewController {
    private let viewModel: MainViewModel

    private var textInputView: UITextField!
    private var sendButton: UIButton!
    private var webView: WKWebView!

    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Main"
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBindings()
    }

    // MARK: - Private

    private func setupUI() {
        // TextInput setup
        textInputView = UITextField()
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.placeholder = "Enter text to send to WebView"
        view.addSubview(textInputView)
        textInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true

        // Send Button setup
        sendButton = UIButton(configuration: .filled(), primaryAction: .init(title: "Send to WebView", handler: { [weak self] _ in
            self?.sendTextToWebView()
        }))
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sendButton)
        sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        sendButton.topAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: 16).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        // WebView setup
        let controller = WKUserContentController()
        controller.add(self, name: HTMLMessageHandler.input.rawValue)
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 16).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupBindings() {
        webView.loadHTMLString(viewModel.htmlText, baseURL: nil)

        textInputView.returnPublisher
            .sink { [weak self] in
                self?.sendTextToWebView()
            }
            .store(in: &cancellables)
    }

    private func sendTextToWebView() {
        textInputView.resignFirstResponder()

        let javascriptCode = "document.getElementById('\(HTMLElement.textInput.rawValue)').value = '\(textInputView.text ?? "")';"
        webView.evaluateJavaScript(javascriptCode) { (result, error) in
            if let error {
                print("JavaScript Error: \(error.localizedDescription)")
            }
        }
    }
}

extension MainViewController: WKScriptMessageHandler {
    public func userContentController(_: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == HTMLMessageHandler.input.rawValue {
            let text = message.body as? String
            textInputView.text = text
        }
    }
}

extension MainViewController: WKNavigationDelegate {
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        print("WebView didFinish navigation")
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        print("WebView didFail navigation")
    }
}
