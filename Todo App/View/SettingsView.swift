//
//  SettingsView.swift
//  Todo App
//
//  Created by Paulo Orquillo on 1/05/21.
//

import SwiftUI

struct SettingsView: View {
    // MARK: Properties
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: Form
                Form {
                    // MARK: Section 3
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://quonsepto.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://quonsepto.com")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://quonsepto.com")

                    }
                    
                    // MARK: Section 4
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Quonsepto")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Paulo Orquillo")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    }.padding(.vertical, 3)
                }//:Form
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: Footer
                Text("Copyright All righst reserved. \nBetter Apps ♡ Less Code.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.gray)
            }
            .navigationBarItems(
                leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                 Image(systemName: "xmark")
                    
                }
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground"))
            .edgesIgnoringSafeArea(.all)
        }//:Navigation
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
