//
//  main.swift
//  pop_console
//
//  Created by Pedro Henrique Sudario da Silva, Guilherme Sampaio Furquim & Enzo Enrico Boteon Chiuratto on 25/03/25.
//

enum MessageType {
    case promotion, reminder, alert, notification
}

enum NotificationPriority {
    case low, medium, high
}

struct Message {
    let type: MessageType
    let content: String
    let priority: NotificationPriority
}

protocol Notifiable {
    var message: Message { get }
    func sendNotification()
}

extension Notifiable {
    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)Notificação genérica: \(message.content)")
    }
}

struct Email: Notifiable {
    private let emailAddress: String
    let message: Message

    init(emailAddress: String, message: Message) {
        self.emailAddress = emailAddress
        self.message = message
    }

    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)Email enviado para \(emailAddress): \(message.content) [Tipo: \(message.type)]")
    }
}

struct SMS: Notifiable {
    private let phoneNumber: String
    let message: Message

    init(phoneNumber: String, message: Message) {
        self.phoneNumber = phoneNumber
        self.message = message
    }

    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)SMS enviado para \(phoneNumber): \(message.content) [Tipo: \(message.type)]")
    }
}

struct PushNotification: Notifiable {
    private let deviceToken: String
    let message: Message

    init(deviceToken: String, message: Message) {
        self.deviceToken = deviceToken
        self.message = message
    }

    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)Push enviado para \(deviceToken): \(message.content) [Tipo: \(message.type)]")
    }
}

func filterChannels<T: Notifiable>(from channels: [Notifiable], ofType type: T.Type) -> [T] {
    return channels.compactMap { $0 as? T }
}

func main() {
    let messages = [
        Message(type: .promotion, content: "50% de desconto em todos os produtos!", priority: .low),
        Message(type: .reminder, content: "Não se esqueça da reunião amanhã às 10h", priority: .medium),
        Message(type: .alert, content: "Alerta de segurança: acesso não autorizado detectado", priority: .high),
        Message(type: .alert, content: "Alerta: Conta bancária esvaziada por hacker", priority: .high)
    ]

    let notificationChannels: [Notifiable] = [
        Email(emailAddress: "usuario@exemplo.com", message: messages[0]),
        SMS(phoneNumber: "+5511999998888", message: messages[1]),
        PushNotification(deviceToken: "abcd1234efgh5678", message: messages[2]),
        Email(emailAddress: "pepo@pepo.com", message: messages[3])
    ]

    notificationChannels.forEach { $0.sendNotification() }

    let emailChannels = filterChannels(from: notificationChannels, ofType: Email.self)
    print("\nApenas emails filtrados:")
    emailChannels.forEach { $0.sendNotification() }
}

main()
