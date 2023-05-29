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

struct WebView : UIViewRepresentable {
    @Binding var markdown:String
    @Binding var delimeter: DelimeterType
    @Binding var format: MathFormatType
    var parser = MarkdownParser();

    init(markdown: Binding<String>, delimeter: Binding<DelimeterType>, format: Binding<MathFormatType>) {
        self._markdown = markdown;
        self._delimeter = delimeter;
        self._format = format;
        
        self.parser.addModifier(Modifier(target: .codeBlocks, closure: { html, markdown in
            
            let block = delimeter.wrappedValue.style().block;
            if(markdown.starts(with: block.start)) {
                let html = "\\[" + markdown.dropFirst(block.start.count).dropLast(block.end.count) + "\\]";
//                print(html);
                return html;
            } else {
                return html
            }
        }))
        
        self.parser.addModifier(Modifier(target: .inlineCode, closure: { html, markdown in
            if(markdown.starts(with: inlineMathBegin)) {
                let html = "\\(" + markdown.dropFirst(inlineMathBegin.count).dropLast(inlineMathEnd.count) + "\\)";
//                print(html);
                return html;
            } else {
                return html
            }
        }))
    }
//    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let matches = markdown.matches(of: delimeter.style().inline);
        var newMD = "";

        var idx:String.Index? = nil
        for match in matches {
            if(idx == nil) {
                newMD += markdown[..<match.startIndex];
            }
            else {
                newMD += markdown[idx!..<match.startIndex];
            }
//            print(markdown[match.startIndex..<match.endIndex].dropFirst(2).dropLast(2));
            newMD += inlineMathBegin + markdown[match.startIndex..<match.endIndex].dropFirst(2).dropLast(2) + inlineMathEnd
            idx = match.endIndex;
        }
        newMD += markdown[idx!...]
        uiView.loadHTMLString(self.format.header() + parser.html(from: newMD), baseURL: nil)
    }
    
}

let inlineMathBegin = "`#inline-math-begin# "
let inlineMathEnd = " #inline-math-begin#`"
