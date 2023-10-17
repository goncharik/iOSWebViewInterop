import Combine

final class MainViewModel {

    let htmlText = """
    <!DOCTYPE html>
    <html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Web Page with JavaScript</title>
        <style>
            \(HTMLStyles.default)
        </style>
    </head>
    <body>
    <h1>HTML Web Page</h1>

    <input type="text" id="\(HTMLElement.textInput.rawValue)" placeholder="Type here">
    <button id="webButton">Send to iOS App</button>

    <script>
        document.getElementById('webButton').addEventListener('click', function() {
            // Update the label text when the HTML button is clicked
            var inputValue = document.getElementById('\(HTMLElement.textInput.rawValue)').value;
            // Post a message to the iOS app
            window.webkit.messageHandlers.\(HTMLMessageHandler.input.rawValue).postMessage(inputValue);
        });
    </script>
    </body>
    </html>
    """

}
