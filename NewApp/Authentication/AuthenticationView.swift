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
import FirebaseAuth
import GoogleSignIn
import Combine

struct UserAuthResult {
    let id: String
    let email: String?

    init(user: FirebaseAuth.User) {
        self.id = user.uid
        self.email = user.email
    }
}

class AuthenticationManager: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    func createUser(email: String, password: String) async throws -> UserAuthResult {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return UserAuthResult(user: result.user)
    }
    func signInUserWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                let newUser = try await createUser(email: email, password: password)
                print("Success")
                print(newUser)
            } catch {
                print("Error: \(error)")
            }
        }
    }
    func signInUserWithGoogle() {
        Task {
            do {
                let newUser = try await createUser(email: email, password: password)
                
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

struct EmailAuthenticationView: View {
    @ObservedObject var authVM: AuthenticationManager
    var body: some View {
        VStack {
            Text("Email Authentication View")
            TextField("Enter your email...", text: $authVM.email)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            SecureField("Password...", text: $authVM.password)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            Button {
                authVM.signInUserWithEmail()
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .frame(height: 55)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
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
    @StateObject var authVM: AuthenticationManager
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                VStack {
                    AuthenticationMethodButton(authVM: authVM, title: "Sign In With Email", method: .email)
                    AuthenticationMethodButton(authVM: authVM, title: "Sign In With Google", method: .google)
                    AuthenticationMethodButton(authVM: authVM, title: "Sign In With Twitter", method: .twitter)
                }
            }
        }
    }
}

struct AuthenticationMethodButton: View {
    @ObservedObject var authVM: AuthenticationManager
    var title: String = ""
    let method: AuthMethods
    var body: some View {
        NavigationLink {
            if method == .email {
                EmailAuthenticationView(authVM: authVM)
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
}

extension AuthenticationView {
    private var backgroundColor: some View {
        Color(.green)
            .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    AuthenticationView(authVM: AuthenticationManager())
}
