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
    var isInsert: Bool {
        get {
            selectedrange.1?.type != MarkdownNode.MarkdownType.codeBlock &&
            selectedrange.1?.type != MarkdownNode.MarkdownType.code
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

                Button("Input Math") {
                    inputMode.toggle()
                }
                .sheet(isPresented: $inputMode) {
                    MathSheet(
                        mathFormat: $mathFormat,
                        inputMode: $inputMode,
                        markdownContent: $markdownContent,
                        inlineDelimeter: $inlineDelimeter,
                        display: $display,
                        offset: selectedrange.0.location,
                        length: selectedrange.0.length,
                        initialTex: ""
                    )
                }
                .buttonStyle(.borderedProminent)
                .disabled(!isInsert)

                Button("Edit Math") {
                    inputMode.toggle()
                }
                .sheet(isPresented: $inputMode) {
                }
                .buttonStyle(.borderedProminent)
                .disabled(isInsert)


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
