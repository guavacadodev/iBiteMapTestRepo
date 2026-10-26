//
//  ContentView.swift
//  NewApp
//
//  Created by Jake Woodall on 10/25/26.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore
import Combine

struct User: Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
}

@main
struct NewAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //AuthenticationView()
            MainView(mainVM: MainViewModel())
        }
    }
}

@MainActor
class MainViewModel: ObservableObject {
    @Published var users: [User] = []

    private let db = Firestore.firestore()

    func fetchFirebaseUserData() async {
        do {
            let users = try await db.collection("users").getDocuments()

            self.users = users.documents.map { document in
                let data = document.data()

                return User(
                    id: document.documentID,
                    firstName: data["firstName"] as? String ?? "",
                    lastName: data["lastName"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    age: data["age"] as? Int ?? 0
                )
            }

            print("Fetched \(users.count) users")

        } catch {
            print("Error getting users: \(error.localizedDescription)")
        }
    }
    
    func deleteFirebaseUserData(for user: User) async {
        do {
            try await db.collection("users").document(user.id).delete()
            print("Successfully deleted the user.")
            
            users.removeAll { $0.id == user.id }
        } catch {
            print("Error deleting document: \(error)")
        }
    }
}

struct MainView: View {
    @StateObject var mainVM: MainViewModel
    var body: some View {
        ZStack {
            backgroundColor
            ScrollView(.horizontal) {
                HStack {
                    ForEach(mainVM.users) { user in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(user.firstName) \(user.lastName)")
                                Spacer()
                                Text("Age: \(user.age)")
                            }
                            Text(user.email.isEmpty ? "Loading email..." : user.email)
                                .font(.caption2)
                            DeleteUserButton(mainVM: mainVM, user: user)
                            Text("ID: \(user.id)")
                                .font(.footnote)
                                .foregroundStyle(.black)
                        }
                        .frame(width: 250, height: 80, alignment: .leading)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                Spacer()
            }
        }
        .task {
            await mainVM.fetchFirebaseUserData()
        }
    }
}

extension MainView {
    private var backgroundColor: some View {
        Color(.black)
            .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    MainView(mainVM: MainViewModel())
}
