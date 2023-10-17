import Foundation

enum HTMLMessageHandler: String {
    case input = "HTMLInputSent"
}

enum HTMLElement: String {
    case textInput = "textInput"
}

enum HTMLStyles {
    static var `default` = """
    body {
            font-family: Helvetica, sans-serif;
            text-align: center;
        }

        h1 {
            font-size: 24px;
        }

        #textInput {
            width: 80%;
            padding: 10px;
            margin: 10px auto;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        #webButton {
            padding: 10px 20px;
            background-color: #007aff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    """
}
