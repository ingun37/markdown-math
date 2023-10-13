//
//  Sheet.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/10/13.
//

import SwiftUI
import SwiftDown

struct MathSheet: View {
    @Binding var mathFormat: MathFormatType
    @Binding var inputMode: Bool
    @Binding var markdownContent: String
    @Binding var inlineDelimeter: DelimeterType
    @Binding var display: Display
    var offset: Int
    var length: Int
    var initialTex: String
    var body: some View {
        MathInput(tex: initialTex, format: mathFormat, onCancel: {
            inputMode.toggle()
        }, onInsert: { tex in
            let x = markdownContent.index(markdownContent.startIndex, offsetBy: offset)
            let y = markdownContent.index(markdownContent.startIndex, offsetBy: offset + length)

            let delimiters = inlineDelimeter.style()

            let start: String
            let end: String
            switch display {
            case .Block:
                start = "\n" + delimiters.block.start + "\n"
                end = "\n" + delimiters.block.end + "\n"
            case .Inline:
                start = delimiters.inline.start
                end = delimiters.inline.end
            }

            DispatchQueue.main.async {
                markdownContent = markdownContent[..<x] + start + tex + end + markdownContent[y...]
            }

            inputMode.toggle()
        })
    }
}
