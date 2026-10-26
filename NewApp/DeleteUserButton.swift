//
//  DeleteUserButton.swift
//  NewApp
//
//  Created by Jake Woodall on 10/26/26.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore
import Combine

struct DeleteUserButton: View {
    @ObservedObject var mainVM: MainViewModel
    let user: User
    var body: some View {
        Button {
            Task {
                await mainVM.deleteFirebaseUserData(for: user)
            }
        } label: {
            ZStack(alignment: .center) {
                Rectangle()
                    .foregroundStyle(.red)
                    .frame(height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text("Delete Account")
                    .font(.caption2)
            }
        }
    }
}
