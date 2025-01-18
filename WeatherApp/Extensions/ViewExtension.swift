//
//  ViewExtension.swift
//  WeatherApp
//
//  Created by José Alves da Cunha on 18/01/25.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
