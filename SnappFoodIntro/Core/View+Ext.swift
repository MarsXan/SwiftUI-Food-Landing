//
//  View+Ext.swift
//  SnappFoodIntro
//
//  Created by mohsen mokhtari on 8/12/23.
//

import SwiftUI

extension View {
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
}
