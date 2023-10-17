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
import Combine

struct WebView: UIViewRepresentable {
    @Binding var markdown: String
    @Binding var delimeter: DelimeterType
    @Binding var format: MathFormatType
    var parser = MarkdownParser()

    init(markdown: Binding<String>, delimeter: Binding<DelimeterType>, format: Binding<MathFormatType>) {
        _markdown = markdown
        _delimeter = delimeter
        _format = format

        parser.addModifier(Modifier(target: .codeBlocks, closure: { html, markdown in

            let block = delimeter.wrappedValue.style().block
            if markdown.starts(with: block.start) {
                let html = "\\[" + markdown.dropFirst(block.start.count).dropLast(block.end.count) + "\\]"
//                print(html);
                return html
            } else {
                return html
            }
        }))

        parser.addModifier(Modifier(target: .inlineCode, closure: { html, markdown in
            if markdown.starts(with: inlineMathBegin) {
                let html = "\\(" + markdown.dropFirst(inlineMathBegin.count).dropLast(inlineMathEnd.count) + "\\)"
//                print(html);
                return html
            } else {
                return html
            }
        }))
    }

//    let request: URLRequest

    func makeUIView(context _: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context c: Context) {
        let matches = markdown.matches(of: delimeter.style().inlineMatcher)
        var newMD = ""

        var idx: String.Index?
        for match in matches {
            if idx == nil {
                newMD += markdown[..<match.startIndex]
            } else {
                newMD += markdown[idx! ..< match.startIndex]
            }
            newMD += inlineMathBegin + markdown[match.startIndex ..< match.endIndex].dropFirst(2).dropLast(2) + inlineMathEnd
            idx = match.endIndex
        }
        newMD += markdown[idx!...]
        uiView.loadHTMLString(format.header() + parser.html(from: newMD), baseURL: nil)
    }

}

let inlineMathBegin = "`#inline-math-begin# "
let inlineMathEnd = " #inline-math-end#`"
