//
//  EULAView.swift
//  CleosPage
//
//  Created by Jordan McKnight on 4/4/25.
//

import SwiftUI

struct EULAView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("End User License Agreement")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 20)
                
                Text("By using Cleo's App, you agree to the following terms and conditions:")
                    .font(.headline)
                
                Text("""
                - You may not reverse-engineer, duplicate, or redistribute the app without prior written permission.
                - Your data is handled in accordance with our privacy policy.
                - The app and its creators are not liable for any misuse or loss of data resulting from the use of the app.
                - Additional terms may apply.
                """)
                    .font(.body)
                    .padding(.top, 10)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("EULA")
    }
}
