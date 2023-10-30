//
//  ContentView.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/12.
//

import SwiftDown
import SwiftUI
import Combine

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
    var markdownContentPassThrough = PassthroughSubject<String, Never>()
    @State var debouncedMarkdown = initialMarkdown

    var selectedRangePassThrough = PassthroughSubject<(NSRange, MarkdownNode?), Never>()
    @State var debouncedSelectedRange: (NSRange, MarkdownNode?) = (NSRange(), nil)

    @State var inlineDelimeter: DelimeterType = .GitLab
    @State var mathFormat: MathFormatType = .Latex
    @State var display: Display = .Inline
    @State private var inputMode = false
    @State private var manualOrientation: ManualOrientation = .vertical
    @State var isInsert: (String, Range<String.Index>, Bool)?
    @State var help = false
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
                                markdownContent: $markdownContent,
                                inlineDelimeter: $inlineDelimeter,
                                display: isInsert.2 ? .Inline : .Block,
                                range: isInsert.1,
                                initialTex: isInsert.0
                            )
                                .interactiveDismissDisabled()
                        }
                        .buttonStyle(.borderedProminent)
                } else {
                    Button("Input Math") {
                        inputMode.toggle()
                    }
                        .sheet(isPresented: $inputMode) {
                            let i0 = markdownContent.startIndex
                            let _rng = debouncedSelectedRange.0
                            let A = markdownContent.index(i0, offsetBy: _rng.location)
                            let B = markdownContent.index(i0, offsetBy: _rng.location + _rng.length)
                            MathSheet(
                                mathFormat: $mathFormat,
                                inputMode: $inputMode,
                                markdownContent: $markdownContent,
                                inlineDelimeter: $inlineDelimeter,
                                display: display,
                                range: A..<B,
                                initialTex: ""
                            )
                                .interactiveDismissDisabled()
                        }
                        .buttonStyle(.borderedProminent)
                    Button("Edit Math") {
                        inputMode.toggle()
                    }.disabled(true)
                }

                Spacer()
                HStack(spacing: 12) {
                    ShareLink(item: markdownContent)
                    Button("Help", systemImage: "info.circle") {
                        help.toggle()
                    }
                        .labelStyle(.iconOnly)
                        .sheet(isPresented: $help, content: {
                            Help().padding(16)
                        })
                }

            }.onReceive(selectedRangePassThrough.debounce(for: .seconds(0.3), scheduler: RunLoop.main)) { mmm in
                debouncedSelectedRange = mmm
                if let markdownNode = mmm.1 {
                    let nodeType = markdownNode.type
                    if nodeType == MarkdownNode.MarkdownType.codeBlock ||
                       nodeType == MarkdownNode.MarkdownType.code {
                        let idx0 = markdownContent.startIndex
//                                let delStyle = inlineDelimeter.style()
                        let isInline = nodeType == MarkdownNode.MarkdownType.code
//                                let del = isInline ? delStyle.inline : delStyle.block

                        if isInline {
                            let _rng = markdownNode.range
                            let delimeter = inlineDelimeter.style().inline
                            if 0 <= _rng.location - 2 && _rng.location + _rng.length + 2 <= markdownContent.count {
                                let A = markdownContent.index(idx0, offsetBy: _rng.location - 2)
                                let B = markdownContent.index(idx0, offsetBy: _rng.location + _rng.length + 2)
                                let AB = A..<B
                                let sub = markdownContent[AB]
                                if sub.hasPrefix(delimeter.start) && sub.hasSuffix(delimeter.end) {
                                    self.isInsert = (String(sub.dropFirst(delimeter.start.count).dropLast(delimeter.end.count)), AB, true)
                                    return
                                }
                            }
                        } else {
                            let _rng = markdownNode.range
                            let delimeter = inlineDelimeter.style().block
                            let A = markdownContent.index(idx0, offsetBy: _rng.location)
                            let B = markdownContent.index(idx0, offsetBy: _rng.location + _rng.length, limitedBy: markdownContent.endIndex) ?? markdownContent.endIndex
                            let AB = A..<B
                            let sub = markdownContent[AB]
                            if sub.hasPrefix(delimeter.start) && sub.hasSuffix(delimeter.end) {
                                self.isInsert = (String(sub.dropFirst(delimeter.start.count).dropLast(delimeter.end.count)), AB, false)
                                return
                            }
                        }
                    }
                }
                self.isInsert = nil
            }

            let layout = manualOrientation == .vertical ?
                AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())

            layout {
                WebView(markdown: $debouncedMarkdown, delimeter: $inlineDelimeter, format: $mathFormat)
                    .onChange(of: markdownContent) {
                        markdownContentPassThrough.send(markdownContent)
                    }
                    .onReceive(markdownContentPassThrough.debounce(for: .seconds(0.3), scheduler: RunLoop.main)) { newValue in
                        debouncedMarkdown = newValue
                    }
              SwiftDownEditor(text: $markdownContent, onSelectionChange: { rng, mn in
                  selectedRangePassThrough.send((rng, mn))
              })
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
