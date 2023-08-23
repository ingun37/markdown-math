//
//  Handwriting.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/06/18.
//

import SwiftUI
import PencilKit

struct Handwriting: View {
    var engine: IINKEngine
    init(engine: IINKEngine) {
        self.engine = engine;
        do {
            
        } catch {
            
        }
        
    }
    var body: some View {
        VStack {
            MyScript(engine: engine)
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
