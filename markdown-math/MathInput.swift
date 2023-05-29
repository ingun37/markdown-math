//
//  MathInput.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/05/29.
//

import SwiftUI

struct MathInput: View {
    @State var tex: String
    @State var format: MathFormatType
    var body: some View {
        VStack {
            InputWebView(tex: $tex, format: $format)
            TextEditor(text: $tex)
            Button("Handwriting") {}
            
        }.padding()
    }
}

struct MathInput_Previews: PreviewProvider {
    static var previews: some View {
        MathInput(tex: """
\\tau
""", format: .Katex)
    }
}
