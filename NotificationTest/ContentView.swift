//
//  ContentView.swift
//  NotificationTest
//
//  Created by Victor Soares on 27/10/23.
//

import SwiftUI
import TipKit

struct FavoriteLandmarkTip: Tip {
    var title: Text {
        Text("Save as a Favorite")
    }
    
    
    var message: Text? {
        Text("Your favorite landmarks always appear at the top of the list.")
    }
    
    
    var image: Image? {
        Image(systemName: "star")
    }
}

struct ContentView: View {
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    let favoriteLandmarkTip = FavoriteLandmarkTip()
    
    var body: some View {
        VStack {
            
            TipView(favoriteLandmarkTip)
            
            Text("Daqui quanto tempo a notificação vai ativar?")
                .font(.title2)
            
            
            
            HStack {
                Text("Minutos: ")
                Picker("Minutes", selection: $minutes) {
                    ForEach(0..<61) { index in
                        Text(String(index))
                            .tag(index)
                    }
                }
            }
            
            HStack {
                Text("Segundos: ")
                Picker("Segundos", selection: $seconds) {
                    ForEach(0..<61) { index in
                        Text(String(index))
                            .tag(index)
                    }
                }
            }
        
            Button("Agendar") {

                
                let notificationContent = getNotificationContent()
                
                print(notificationContent)
                triggerNotification(notificationContent)
            }
        }
        .padding()
        .onAppear {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (accepted, error) in
                print("Accepted")
            }
        }
        .task {
            // Configure and load your tips at app launch.
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
        
    }
    
    func triggerNotification(_ content: UNMutableNotificationContent) {
        
        let uuid = UUID().uuidString
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(minutes * 60 + seconds), repeats: false)
        
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            
            if error == nil {
                print("Foi")
            } else {
                print(error)
            }
            
        }
        
    }
    
    func getNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        
        content.title = "Notificação oi"
        content.body = "Funcinou acho"
        content.badge = 25
        
        return content
    }
}

#Preview {
    ContentView()
}
