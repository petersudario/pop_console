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

struct Email: Notificable {
    var emailAddress: String
    var message: String = "Enviando e-mail para \(emailAddress)"
    func sendNotification() -> Void {
        print(message)
    }
}

struct Sms: Notificable {
    var phoneNumber: String
    var message: String = "Enviando SMS para \(phoneNumber)"
    func sendNotification() -> Void {
        print(message)
    }
}

struct PushNotification: Notificable {
    let deviceToken: String
    var message: String = "Enviando notificação para \(deviceToken)"
    func sendNotification() -> Void {
        print(message)
    }
}

struct Notifications: Notificable {
    let email: Email
    let sms: Sms
    let pushNotification: PushNotification
}

extension NotificableExtension: Notificable {
    func sendNotification -> Void {
        print("Enviando notificação...")
    }
}


