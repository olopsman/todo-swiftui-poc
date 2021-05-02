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
    @EnvironmentObject var iconSettings: IconNames
    
    // Theme
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    @State private var isThemeChanged: Bool = false
    
    // MARK: Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: Form
                Form {
                    // MARK: Section 1
                    Section(header: Text("Choose an app icon")){
                        Picker(selection: $iconSettings.currentIndex, label:
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(Color.primary, lineWidth: 2)
                                Image(systemName: "paintbrush")
                                    .font(.system(size: 28, weight: .regular, design: .default))
                            }.frame(width: 44, height: 44)
                            
                            Text("App Icons".uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                        }
                        
                        ) {
                            ForEach(0..<iconSettings.iconNames.count) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44, alignment: .center)
                                        .cornerRadius(8)
                                       Spacer()
                                        .frame(width:8)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                }.padding(3)
                            }
                        }//:Picker
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { value in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! YOu have changed the app icon")
                                    }
                                }
                            }
                            
                        }
                    }.padding(.vertical, 3)
                    
                    // MARK: Section 2
                    Section(header:
                                HStack {
                                    Text("Choose the app theme")
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .foregroundColor(themes[self.theme.themeSettings].themeColor)
                                }
                    
                    ) {
                        List{
                            ForEach(themes, id:\.id){ item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                    self.isThemeChanged.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        Text(item.themeName)
                                    }
                                }//:Button
                                .accentColor(Color.primary)
                                
                            }
                        }
                    }.padding(.vertical, 3)
                    .alert(isPresented: $isThemeChanged) {
                        Alert(title: Text("Success"), message: Text("App has been changed to the \(themes[self.theme.themeSettings].themeName). Now close and restart the app."), dismissButton: .default(Text("OK")))
                    }
                    
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
                trailing:
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
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(IconNames())
    }
}
