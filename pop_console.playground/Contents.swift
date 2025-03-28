//
//  main.swift
//  pop_console
//
//  Criado por Pedro Henrique Sudario da Silva, Guilherme Sampaio Furquim & Enzo Enrico Boteon Chiuratto em 25/03/25.
//

/// Representa os tipos de mensagem que podem ser enviados.
enum MessageType {
    case promotion, reminder, alert, notification
}

/// Define os níveis de prioridade para notificações.
enum NotificationPriority {
    case low, medium, high
}

/// Estrutura que representa uma mensagem com tipo, conteúdo e prioridade.
struct Message {
    let type: MessageType
    let content: String
    let priority: NotificationPriority
}

/// Protocolo para qualquer entidade que possa enviar notificações.
protocol Notifiable {
    var message: Message { get }
    func sendNotification()
}

/// Implementação padrão para o método `sendNotification()`.
/// Se a prioridade for alta, adiciona a tag "URGENTE!" na notificação.
extension Notifiable {
    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)Notificação genérica: \(message.content)")
    }
}

/// Implementação de notificação via Email.
struct Email: Notifiable {
    private let emailAddress: String
    let message: Message

    init(emailAddress: String, message: Message) {
        self.emailAddress = emailAddress
        self.message = message
    }

    /// Envia uma notificação por email.
    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)Email enviado para \(emailAddress): \(message.content) [Tipo: \(message.type)]")
    }
}

/// Implementação de notificação via SMS.
struct SMS: Notifiable {
    private let phoneNumber: String
    let message: Message

    init(phoneNumber: String, message: Message) {
        self.phoneNumber = phoneNumber
        self.message = message
    }

    /// Envia uma notificação por SMS.
    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)SMS enviado para \(phoneNumber): \(message.content) [Tipo: \(message.type)]")
    }
}

/// Implementação de notificação via Push Notification.
struct PushNotification: Notifiable {
    private let deviceToken: String
    let message: Message

    init(deviceToken: String, message: Message) {
        self.deviceToken = deviceToken
        self.message = message
    }

    /// Envia uma notificação por Push Notification.
    func sendNotification() {
        let priorityTag = message.priority == .high ? "URGENTE! " : ""
        print("\(priorityTag)Push enviado para \(deviceToken): \(message.content) [Tipo: \(message.type)]")
    }
}

/// Filtra um array de canais de notificação e retorna apenas os do tipo especificado.
/// - Parameters:
///   - channels: Array contendo diferentes tipos de canais de notificação.
///   - type: O tipo de canal de notificação a ser filtrado.
/// - Returns: Um array contendo apenas os canais do tipo especificado.
func filterChannels<T: Notifiable>(from channels: [Notifiable], ofType type: T.Type) -> [T] {
    return channels.compactMap { $0 as? T }
}

func main() {
    // Define mensagens com diferentes prioridades.
    let messages = [
        Message(type: .promotion, content: "50% de desconto em todos os produtos!", priority: .low),
        Message(type: .reminder, content: "Não se esqueça da reunião amanhã às 10h", priority: .medium),
        Message(type: .alert, content: "Alerta de segurança: acesso não autorizado detectado", priority: .high),
        Message(type: .alert, content: "Alerta: Conta bancária esvaziada por hacker", priority: .high)
    ]

    // Cria um array de diferentes canais de notificação.
    let notificationChannels: [Notifiable] = [
        Email(emailAddress: "usuario@exemplo.com", message: messages[0]),
        SMS(phoneNumber: "+5511999998888", message: messages[1]),
        PushNotification(deviceToken: "abcd1234efgh5678", message: messages[2]),
        Email(emailAddress: "pepo@pepo.com", message: messages[3])
    ]

    // Envia todas as notificações.
    notificationChannels.forEach { $0.sendNotification() }

    // Filtra apenas as notificações do tipo Email. Passível de alteração caso precisar testar filtragem com outros tipos.
    let emailChannels = filterChannels(from: notificationChannels, ofType: Email.self)
    print("\nApenas emails filtrados:")
    emailChannels.forEach { $0.sendNotification() }
}

main()
