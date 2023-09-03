//
//  MathInput.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/29.
//

import SwiftUI

struct MathInput: View, MyScriptSampleObserverDelegate {
    @State var tex: String
    @State var format: MathFormatType
    @State private var handwriting = false
    
    var onCancel: () -> Void
    var onInsert: (String) -> Void
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    onCancel()
                }
                Spacer()
                Button("Insert") {
                    onInsert(tex)
                }
            }
            InputWebView(tex: $tex, format: $format)
            TextEditor(text: $tex).scrollContentBackground(.hidden).background(Color(hex: 0x1D1F21)).foregroundColor(Color(hex:0xA1A8B5))
            Button("Handwriting") {
                handwriting.toggle()
            }.fullScreenCover(isPresented: $handwriting) {
                MyScript(delegate: self)
            }.buttonStyle(.borderedProminent)

        }.padding()
    }
    func cancel() {
        handwriting.toggle()
    }
    func done(tex:String) {
        self.tex = tex
        handwriting.toggle()
    }
}

struct MathInput_Previews: PreviewProvider {
    static var previews: some View {
        MathInput(tex: """
        \\tau
        """, format: .Katex, onCancel: {}, onInsert: { _ in })
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
