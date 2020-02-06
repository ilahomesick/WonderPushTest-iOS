//
//  ContentView.swift
//  WonderPushTest
//
//  Created by ilario salatino on 05.02.20.
//  Copyright © 2020 ilario salatino. All rights reserved.
//

import SwiftUI
import WonderPush

struct ContentView: View {
    
    let genders = ["<empty>","male","female"]
    
    
    @State var isSubscribed = WonderPush.isSubscribedToNotifications()
    @State var gender :Int = WonderPush.getPropertyValue("int_gender") is NSNull ? 0 : WonderPush.getPropertyValue("int_gender") as! Int
    
    
    
    var body: some View {
        
        let index = Binding<Int>(get: {

            return self.gender

        }, set: {

            WonderPush.putProperties(["int_gender": $0])
            self.gender = $0
            
        })
        
        return NavigationView{
            Form{
                Toggle.init(isOn: $isSubscribed){
                    Text("Push Notifications")
                }.onTapGesture {
                    if(self.isSubscribed){
                        WonderPush.unsubscribeFromNotifications()
                        self.isSubscribed = false
                    }
                    else{
                        WonderPush.subscribeToNotifications()
                        self.isSubscribed = true
                    }
                }.padding()
                Picker(selection: index, label: Text("Gender")
                        ){
                    ForEach(0..<self.genders.count){
                        Text(self.genders[$0]).tag($0)               }
                }
                
                
            }
            .padding(.top, 200.0)
            
            
            
            
            }.navigationBarTitle("Wonder Push")
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
