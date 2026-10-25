//
//  ContentView.swift
//  NewApp
//
//  Created by Jake Woodall on 10/25/26.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        ZStack {
            backgroundColor
            iBiteMap()
        }
    }
}

extension MainView {
    private var backgroundColor: some View {
        Color(.black)
            .ignoresSafeArea(edges: .all)
    }
}

struct iBiteMap: View {
    var body: some View {
        
    }
}

#Preview {
    MainView()
}
