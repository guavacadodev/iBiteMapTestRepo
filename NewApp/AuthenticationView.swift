//
//  AuthenticationView.swift
//  NewApp
//
//  Created by Jake Woodall on 10/26/26.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore
import Combine

struct EmailAuthenticationView: View {
    var body: some View {
        Text("Email Authentication View")
    }
}

struct GoogleAuthenticationView: View {
    var body: some View {
        Text("Google Authentication View")
    }
}

struct TwitterAuthenticationView: View {
    var body: some View {
        Text("Twitter Authentication View")
    }
}

enum AuthMethods {
    case email
    case google
    case twitter
}

struct AuthenticationView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                VStack {
                    AuthenticationMethodButton(title: "Sign In With Email", method: .email)
                    AuthenticationMethodButton(title: "Sign In With Google", method: .google)
                    AuthenticationMethodButton(title: "Sign In With Twitter", method: .twitter)
                }
            }
        }
    }
}

struct AuthenticationMethodButton: View {
    var title: String = ""
    let method: AuthMethods
    var body: some View {
        NavigationLink {
            if method == .email {
                EmailAuthenticationView()
            } else if method == .google {
                GoogleAuthenticationView()
            } else if method == .twitter {
                TwitterAuthenticationView()
            }
        } label: {
            Text(title)
                .frame(width: 250, height: 30, alignment: .center)
                .foregroundStyle(.white)
                .padding()
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    @ViewBuilder
    private var destinationView: some View {
        switch method {
        case .email:
            EmailAuthenticationView()

        case .google:
            GoogleAuthenticationView()

        case .twitter:
            TwitterAuthenticationView()
        }
    }
}

extension AuthenticationView {
    private var backgroundColor: some View {
        Color(.green)
            .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    AuthenticationView()
}
