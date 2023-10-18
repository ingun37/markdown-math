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
    @StateObject var appState = AppState(initialMarkdown)
    @State var debouncedMarkdown = initialMarkdown
    @State var inlineDelimeter: DelimeterType = .GitLab
    @State var mathFormat: MathFormatType = .Latex
    @State var display: Display = .Inline
    @State private var inputMode = false
    @State private var manualOrientation: ManualOrientation = .vertical
    @State var isInsert: (String, NSRange, Bool)?
    var body: some View {
        VStack {
            HStack {
                Text("Delimeter style")
                Picker("Inline Delimeter", selection: $inlineDelimeter) {
                    ForEach(DelimeterType.allCases) { style in
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
                            markdownContent: $appState.markdownContent,
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
                            markdownContent: $appState.markdownContent,
                            inlineDelimeter: $inlineDelimeter,
                            display: display,
                            offset: appState.selectedrange.0.location,
                            length: appState.selectedrange.0.length,
                            initialTex: ""
                        )
                    }
                    .buttonStyle(.borderedProminent)
                    Button("Edit Math") {
                        inputMode.toggle()
                    }.disabled(true)
                }

                Spacer()
                ShareLink(item: appState.markdownContent)
            }

            let layout = manualOrientation == .vertical ?
                AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

            layout {
                WebView(markdown: $debouncedMarkdown, delimeter: $inlineDelimeter, format: $mathFormat).onReceive(appState.$markdownContent.debounce(for: .seconds(0.3), scheduler: RunLoop.main), perform: { newValue in
                        debouncedMarkdown = newValue
                })

              SwiftDownEditor(text: $appState.markdownContent, onSelectionChange: { rng, mn in
                  appState.selectedrange = (rng, mn)
              })
                .insetsSize(40)
                .theme(Theme.BuiltIn.defaultDark.theme())
                .onReceive(appState.$selectedrange.debounce(for: .seconds(0.3), scheduler: RunLoop.main)) { mmm in
                        if let markdownNode = mmm.1 {
                            let nodeType = markdownNode.type
                            let rng = markdownNode.range
                            if nodeType == MarkdownNode.MarkdownType.codeBlock ||
                               nodeType == MarkdownNode.MarkdownType.code {
                                let idx0 = appState.markdownContent.startIndex
//                                let delStyle = inlineDelimeter.style()
                                let isInline = nodeType == MarkdownNode.MarkdownType.code
//                                let del = isInline ? delStyle.inline : delStyle.block
                                let offsetA = isInline ? 0 : 8
                                let offsetB = isInline ? 0 : -4
                                let A = appState.markdownContent.index(idx0, offsetBy: rng.location + offsetA)
                                let B = appState.markdownContent.index(idx0, offsetBy: rng.location + rng.length + offsetB)

                                let sub = appState.markdownContent[A..<B]
                                self.isInsert = (String(sub), rng, isInline)
                                return
                            }
                        }
                        self.isInsert = nil

                    }

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
