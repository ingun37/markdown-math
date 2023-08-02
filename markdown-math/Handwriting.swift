//
//  Handwriting.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI

struct Handwriting: View {
    var engine: IINKEngine
    var body: some View {
        VStack{
            Canvas(engine: engine)
            Button("finish") {
                print("finish")
            }
        }
    }
}

//struct Handwriting_Previews: PreviewProvider {
//    static var previews: some View {
//        Handwriting()
//    }
//}
