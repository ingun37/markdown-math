//
//  Handwriting.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI
import PencilKit

struct Handwriting: View {
    var body: some View {
        VStack {
            MyScript()
            Button("finish") {
                print("finish")
            }
        }
    }
}

// struct Handwriting_Previews: PreviewProvider {
//    static var previews: some View {
//        Handwriting()
//    }
// }

