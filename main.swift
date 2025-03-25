//
//  main.swift
//  pop_console
//
//  Created by Pedro Henrique Sudario da Silva on 25/03/25.
//


protocol Notificable {
    var message: String { get set }
    func sendNotification() -> Void
}

struct Email: Notificable{
    var emailAddress: String
    var message: String
    func sendNotification() -> Void {
        print("Enviando email para tal tal tal")
    }
}

struct Sms: Notificable {
    var phoneNumber: String
}

struct PushNotification: Notificable {
    let deviceToken: String
}

extension NotificableExtension: Notificable {
    func sendNotification -> Void {
        print("Enviando notificação...")
    }
}


