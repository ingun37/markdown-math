//
//  MyScript.swift
//  markdown-math
//
//  Created by Ingun Jon on 2023/08/23.
//

import SwiftUI

struct MyScript: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        let vc = MainViewController.instantiate(from: .main)!
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = MainViewController
    
    var engine: IINKEngine

}

// struct Canvas_Previews: PreviewProvider {
//    static var previews: some View {
//        Canvas()
//    }
// }

