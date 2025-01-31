//
//  AppStorageView.swift
//  StorageDemo
//
//  Created by 강보현 on 1/13/25.
//

import SwiftUI


struct UserName: Codable {
    var firstName: String
    var secondName: String
}

struct AppStorageView: View {
    @AppStorage("userName") var namestore: Data = Data()
    
    var userName: UserName {
        get {
            let decoder = JSONDecoder()
            guard let name = try? decoder.decode(UserName.self, from: namestore) else {
                return UserName(firstName: "", secondName: "")
            }
            return name
        }
        
        set {
            let encoder = JSONEncoder()
            namestore = try! encoder.encode(newValue)
        }
    }
    
    var body: some View {
        Text("\(userName.firstName), \(userName.secondName)")
    }
}

#Preview {
    AppStorageView()
}
