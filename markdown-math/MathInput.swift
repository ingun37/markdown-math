//
//  MathInput.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/29.
//

import SwiftUI

struct MathInput: View, MyScriptSampleObserverDelegate {
    let fColor = Color(hex: 0xA1A8B5)
    @State var tex: String
    @State var format: MathFormatType
    @State private var handwriting = false
    @State var err: TexError?
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
            InputWebView(tex: tex, format: $format)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 500)
            ZStack {
                if tex.isEmpty {   ///show placeholder if not text typed
                  Text("Write LaTex here ...")
                    .foregroundColor(fColor.opacity(0.75))
                    .font(.system(size: 42))
                    .padding(EdgeInsets(top: 7, leading: 4, bottom: 0, trailing: 0))
                    .padding(5)
                }
                TextEditor(text: $tex)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .foregroundColor(fColor)
                    .font(Font.system(.body, design: .monospaced))
            }.background(Color(hex: 0x1D1F21))

            Button("Handwriting") {
                handwriting.toggle()
            }
            .fullScreenCover(isPresented: $handwriting) {
                MyScript(delegate: self, latex: tex, err: $err)
            }.buttonStyle(.borderedProminent)

        }
        .padding()
    }
    func cancel() {
        handwriting.toggle()
    }
    func done(tex: String) {
        self.tex = tex
        handwriting.toggle()
    }
    func alert(err: Error) {
        self.err = TexError(err: err)
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
