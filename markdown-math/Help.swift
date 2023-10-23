//
//  Help.swift
//  markdown-math
//
//  Created by Ingun Jon on 10/23/23.
//

import SwiftUI

struct Help: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Write markdown in")
                Text("CommonMark").bold().font(.largeTitle).monospaced()
                Text("syntax.")
            }
            HStack {
                Text("Write inline math using")
                Text("$`").bold().font(.largeTitle).monospaced()
                Text("LaTex...").font(.largeTitle).monospaced().foregroundStyle(Color(.systemGray4))
                Text("`$").bold().font(.largeTitle).monospaced()
                Text("delimeter.")
            }
            Text("Write block math using")
            VStack(alignment: .leading) {
                Text("```math").bold().font(.largeTitle).monospaced()
                Text("LaTex...").font(.largeTitle).monospaced().foregroundStyle(Color(.systemGray4))
                Text("```").bold().font(.largeTitle).monospaced()
            }
            Text("delimeter.")
            HStack {
                Text("This application is open source. Consider making requests/contributions at the [GitHub Page](https://github.com/ingun37/markdown-math), or contact the [developer](mailto:ingun37@gmail.com).")
            }
        }
    }
}

#Preview {
    Help()
}
