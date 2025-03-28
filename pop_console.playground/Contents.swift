//
//  main.swift
//  pop_console
//
//  Created by Pedro Henrique Sudario da Silva, Guilherme Sampaio Furquim  & Enzo Enrico Boteon Chiuratto on 25/03/25.

enum TipoMensagem {
    case promocao
    case lembrete
    case alerta
    case notificacao
}

struct Mensagem {
    var tipo: TipoMensagem
    var conteudo: String
}

protocol Notificavel {
    var mensagem: Mensagem { get set }
    func enviarNotificacao()
}

extension Notificavel {
    func enviarNotificacao() {
        print("notificação generica: \(mensagem.conteudo)")
    }
}

struct Email: Notificavel {
    var enderecoEmail: String
    var mensagem: Mensagem

    func enviarNotificacao() {
        print("email enviado para \(enderecoEmail): \(mensagem.conteudo) [Tipo: \(mensagem.tipo)]")
    }
}

struct SMS: Notificavel {
    var numeroTelefone: String
    var mensagem: Mensagem

    func enviarNotificacao() {
        print("enviando SMS para \(numeroTelefone): \(mensagem.conteudo) [Tipo: \(mensagem.tipo)]")
    }
}

struct PushNotification: Notificavel {
    let tokenDispositivo: String
    var mensagem: Mensagem

    func enviarNotificacao() {
        print(
            "enviando uma notificacao para o dispositivo \(tokenDispositivo): \(mensagem.conteudo) [Tipo: \(mensagem.tipo)]"
        )
    }
}

func main() {
    let mensagemPromocao = Mensagem(
        tipo: .promocao, conteudo: "50% de desconto em todos os produtos!")
    let mensagemLembrete = Mensagem(
        tipo: .lembrete, conteudo: "Não se esqueça da reunião amanhã às 10h")
    let mensagemAlerta = Mensagem(
        tipo: .alerta, conteudo: "Alerta de segurança: acesso não autorizado detectado")

    let email = Email(enderecoEmail: "usuario@exemplo.com", mensagem: mensagemPromocao)
    let sms = SMS(numeroTelefone: "+5511999998888", mensagem: mensagemLembrete)
    let push = PushNotification(tokenDispositivo: "abcd1234efgh5678", mensagem: mensagemAlerta)

    let canaisNotificacao: [Notificavel] = [email, sms, push]

    for canal in canaisNotificacao {
        canal.enviarNotificacao()
    }

    var emailAtualizado = email
    emailAtualizado.mensagem = mensagemAlerta
    emailAtualizado.enviarNotificacao()
}


main()
