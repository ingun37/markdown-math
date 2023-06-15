//
//  InputWebView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/29.
//

import SwiftUI

//
//  WebView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/27.
//

import Foundation
import Ink
import SwiftUI
import WebKit

struct InputWebView: UIViewRepresentable {
    @Binding var tex: String
    @Binding var format: MathFormatType

//    let request: URLRequest

    func makeUIView(context _: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context _: Context) {
        var html = "\\[" + tex + "\\]"
        uiView.loadHTMLString(format.header() + html, baseURL: nil)
    }
}

struct InputWebView_Previews: PreviewProvider {
    @State static var tex: String = """
    \\tau
    """
    @State static var format: MathFormatType = .Katex
    static var previews: some View {
        InputWebView(tex: $tex, format: $format)
    }
}
