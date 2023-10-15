//
//  ContentView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/12.
//

import SwiftDown
import SwiftUI
enum ManualOrientation {
    case horizontal
    case vertical
}

enum Display: String, CaseIterable, Identifiable {

    var id: Self { self }
    case Block
    case Inline
}

struct ContentView: View {
    @State var markdownContent: String = initialMarkdown
    @State var selectedrange: (NSRange, MarkdownNode?) = (NSRange(), nil)
    @State var inlineDelimeter: DelimeterType = .GitLab
    @State var mathFormat: MathFormatType = .Latex
    @State var display: Display = .Inline
    @State private var inputMode = false
    @State private var manualOrientation: ManualOrientation = .vertical
    var isInsert: (String, NSRange, Bool)? {
        get {
            if let markdownNode = selectedrange.1 {
                let nodeType = markdownNode.type
                let rng = markdownNode.range
                if nodeType == MarkdownNode.MarkdownType.codeBlock ||
                   nodeType == MarkdownNode.MarkdownType.code {
                    let idx0 = markdownContent.startIndex
                    let delStyle = inlineDelimeter.style()
                    let isInline = nodeType == MarkdownNode.MarkdownType.code
                    let del = isInline ? delStyle.inline : delStyle.block

                    let A = markdownContent.index(idx0, offsetBy: rng.location + del.start.count)
                    let B = markdownContent.index(idx0, offsetBy: rng.location + rng.length - del.end.count)

                    let sub = markdownContent[A..<B]
                    return (String(sub), rng, isInline)

                }
            }
            return nil
        }
    }
    var body: some View {
        VStack {
            HStack {
                Text("Delimeter style")
                Picker("Inline Delimeter", selection: $inlineDelimeter) {
                    ForEach(DelimeterType.allCases) { style in
                        Text(style.rawValue)
                    }
                }
                Text("Math renderer")
                Picker("Format", selection: $mathFormat) {
                    ForEach(MathFormatType.allCases) { style in
                        Text(style.rawValue)
                    }
                }
                Text("Display")
                Picker("Display", selection: $display) {
                    ForEach(Display.allCases) { display in
                        Text(display.rawValue)
                    }
                }

                if let isInsert = isInsert {
                    Button("Input Math") {
                        inputMode.toggle()
                    }.disabled(true)
                    Button("Edit Math") {
                        inputMode.toggle()
                    }
                    .sheet(isPresented: $inputMode) {
                        MathSheet(
                            mathFormat: $mathFormat,
                            inputMode: $inputMode,
                            markdownContent: $markdownContent,
                            inlineDelimeter: $inlineDelimeter,
                            display: isInsert.2 ? .Inline : .Block,
                            offset: isInsert.1.location,
                            length: isInsert.1.length,
                            initialTex: isInsert.0
                        )
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    Button("Input Math") {
                        inputMode.toggle()
                    }
                    .sheet(isPresented: $inputMode) {
                        MathSheet(
                            mathFormat: $mathFormat,
                            inputMode: $inputMode,
                            markdownContent: $markdownContent,
                            inlineDelimeter: $inlineDelimeter,
                            display: display,
                            offset: selectedrange.0.location,
                            length: selectedrange.0.length,
                            initialTex: ""
                        )
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Edit Math") {
                        inputMode.toggle()
                    }.disabled(true)
                }

                Spacer()
                ShareLink(item: markdownContent)
            }

            let layout = manualOrientation == .vertical ?
                AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

            layout {
                WebView(markdown: $markdownContent, delimeter: $inlineDelimeter, format: $mathFormat)

                SwiftDownEditor(text: $markdownContent, selectedRange: $selectedrange)
                    .insetsSize(40)
                    .theme(Theme.BuiltIn.defaultDark.theme())

            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
