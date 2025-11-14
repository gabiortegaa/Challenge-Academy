import Foundation

enum Elemento: String {
    case fogo = "🔥 Fogo"
    case agua = "🌊 Água"
    case terra = "🌎 Terra"
    case ar = "💨 Ar"
}

struct Magia {
    let nome: String
    let elemento: Elemento
    let custoMana: Int
    let poder: Int
    let nivelNecessario: Int

    func conjurar() {
        print("O Mago conjura **\(nome)**!")
        print("Causa \(poder) de poder de \(elemento.rawValue).")
    }
}

class Mago {
    var nome: String
    var nivel: Int
    var manaAtual: Int
    var manaMaxima: Int
    var experiencia: Int
    var magiasAprendidas: [Magia]
    
    init(nome: String) {
        self.nome = nome
        self.nivel = 1
        self.manaMaxima = 100
        self.manaAtual = 100
        self.experiencia = 0
        self.magiasAprendidas = []
    }
    
    func aprenderMagia(magia: Magia) {
        if nivel < magia.nivelNecessario {
            print("Você precisa ser nível \(magia.nivelNecessario)!")
            return
        }
        
        magiasAprendidas.append(magia)
        print("Você aprendeu \(magia.nome)!")
    }
    
    func usarMagia(magia: Magia) {
        
        if manaAtual < magia.custoMana {
            
            print("Mana insuficiente! Você tem \(manaAtual) e precisa de \(magia.custoMana)")
            return
            
        }
        
        manaAtual = manaAtual - magia.custoMana
        magia.conjurar()
        ganharExperiencia(quantidade: magia.poder)
        
    }
    
    func meditar() {
        let manaRecuperada = 50
        manaAtual = manaAtual + manaRecuperada
        
        if manaAtual > manaMaxima {
            manaAtual = manaMaxima
        }
        
        print("Você meditou e recuperou \(manaRecuperada) de mana")
        print("Mana atual: \(manaAtual)/\(manaMaxima)")
    }
    
    func ganharExperiencia(quantidade: Int) {
        experiencia = experiencia + quantidade
        let expNecessaria = nivel * 100
        
        if experiencia >= expNecessaria {
            subirNivel ()
        }
    }
    
    func subirNivel () {
        nivel = nivel + 1
        experiencia = 0
        manaMaxima = manaMaxima + 20
        manaAtual = manaMaxima
        
        print("\n PARABÉNS! Você subiu para o nível \(nivel)!")
        print("Sua mana máxima agora é \(manaMaxima) \n")
    }
    func mostraStatus(){
        print("\n==============================")
        print("Nome: \(nome)")
        print("Nível: \(nivel)")
        print("Mana: \(manaAtual)/\(manaMaxima)")
        print("Experiência: \(experiencia)/\(nivel * 100)")
        print("Magias aprendidas: \(magiasAprendidas.count)")
        print("============================\n")
    }
}

class Academia {
    var mago1: Mago
    var todasMagias: [Magia]
    var jogando: Bool
    
    init() {
        print ("BEM-VINDO À ACADEMIA DE MAGIA! \n")
        print("Qual é seu nome? ", terminator: "")
        let nomeJogador = readLine() ?? "Mago"
        
        self.mago1 = Mago(nome: nomeJogador)
        self.jogando = true
        self.todasMagias = []
        
        criarMagias()
        
        print("\n Olá, \(nomeJogador)! Sua aventura começa agora!\n")
    }
    func criarMagias() {
        let bolaFogo = Magia(nome: "Bola de Fogo", elemento: .fogo,
                             custoMana: 15, poder: 20, nivelNecessario: 1)
        let jatoAgua = Magia(nome: "Jato de Água", elemento: .agua,
                             custoMana: 15,poder: 20, nivelNecessario: 1)
        let pedra = Magia(nome: "Pedra Voadora", elemento: .terra,
                          custoMana: 15, poder: 20, nivelNecessario: 1)
        let rajada = Magia(nome: "Rajada de Vento", elemento: .ar,
                           custoMana: 15, poder: 20, nivelNecessario: 1)
        
        let meteoro = Magia(nome: "Meteoro", elemento: .fogo,
                            custoMana: 35, poder: 50, nivelNecessario: 3)
        let tsunami = Magia(nome: "Tsunami", elemento: .agua,
                            custoMana: 35,poder: 50, nivelNecessario: 3)
        let terremoto = Magia(nome: "Terremoto", elemento: .terra,
                              custoMana: 35, poder: 50, nivelNecessario: 3)
        let tornado = Magia(nome: "Tornado", elemento: .ar,
                            custoMana: 35, poder: 50, nivelNecessario: 3)
        
        let inferno = Magia(nome: "Inferno", elemento: .fogo,
                            custoMana: 60, poder: 100, nivelNecessario: 5)
        let oceano = Magia(nome: "Oceano Profundo", elemento: .agua,
                            custoMana: 60,poder: 100, nivelNecessario: 5)
        
        todasMagias = [bolaFogo, jatoAgua, pedra, rajada, meteoro, tsunami, terremoto, tornado, inferno, oceano]
    }
    
    func iniciar() {
        while jogando {
            mostrarMenu()
            let escolha = readLine() ?? "0"
            processarEscolha(escolha: escolha)
        }
    }
    func mostrarMenu() {
        print("\n-----------------------------")
        print("O QUE VOCÊ DESEJA FAZER?")
        print("-------------------------------")
        print("1. Ver meu status")
        print("2. Aprender uma magia")
        print("3. Usar uma magia")
        print("4. Ver minhas magias")
        print("5. Meditar")
        print("6. Treinar")
        print("7. Sair")
        print("-------------------------------")
        print("Digite o número:", terminator: "")
    }
    func processarEscolha(escolha: String){
        if escolha == "1" {
            mago1.mostraStatus()
        } else if escolha == "2" {
            menuAprenderMagia()
        } else if escolha == "3" {
            menuUsarMagia()
        } else if escolha == "4" {
            mostrarMinhasMagias()
        } else if escolha == "5" {
            mago1.meditar()
        }else if escolha == "6" {
            treinar()
        }else if escolha == "7" {
            print("\n Até logo, \(mago1.nome)! Continue praticando!")
            jogando = false
        } else {
            print("Opção inválida!")
        }
    }
    
    func menuAprenderMagia() {
        print("\n MAGIAS DISPONÍVEIS\n")
        
        var magiasNaoAprendidas: [Magia] = []
        for magia in todasMagias {
            if !mago1.magiasAprendidas.contains(where: {$0.nome == magia.nome}) {
                magiasNaoAprendidas.append(magia)
            }
        }
        if magiasNaoAprendidas.isEmpty {
            print("Você já aprendeu todas as magias disponíveis")
            return
        }
        
        for (index, magia) in magiasNaoAprendidas.enumerated() {
            var status = "✅"
            if mago1.nivel < magia.nivelNecessario {
                status = "🔒"
            }
            
            print("\(index + 1). \(status) \(magia.nome)")
            print("   \(magia.elemento.rawValue) | Mana: \(magia.custoMana) | Poder: \(magia.poder)")
            print("   Nível necessário: \(magia.nivelNecessario)")
            print ("")
        }
        
        print("Escolha uma magia (0 para voltar): ",terminator: "")
        let escolha = readLine() ?? "0"
        
        if let numeroEscolhido = Int(escolha) {
            if numeroEscolhido > 0 && numeroEscolhido <= magiasNaoAprendidas.count {
                let magiaSelecionada = magiasNaoAprendidas[numeroEscolhido - 1]
                mago1.aprenderMagia(magia: magiaSelecionada)
            }
        }
    }
    
    func menuUsarMagia() {
        if mago1.magiasAprendidas.count == 0 {
            print("Você ainda não aprendeu nenhuma magia!")
            return
        }
        
        print("\n SUAS MAGIAS\n")
        
        var numero = 1
        for magia in mago1.magiasAprendidas {
            var podeUsar = "✅"
            if mago1.manaAtual < magia.custoMana {
                podeUsar = "❌"
            }
            
            print("\(numero). \(podeUsar) \(magia.nome)")
            print("   Custo: \(magia.custoMana) mana | Poder: \(magia.poder)")
            numero = numero + 1
        }
        
        print("\nEscolha uma magia (0 para voltar): ", terminator: "")
        let escolha = readLine() ?? "0"
        
        if let numeroEscolhido = Int(escolha) {
            if numeroEscolhido > 0 && numeroEscolhido <= mago1.magiasAprendidas.count {
                let magiaSelecionada = mago1.magiasAprendidas[numeroEscolhido - 1]
                mago1.usarMagia(magia: magiaSelecionada)
            }
        }
    }
    
    func mostrarMinhasMagias() {
        print("\n📖 MEU GRIMÓRIO\n")
        
        if mago1.magiasAprendidas.count == 0 {
            print("Você ainda não aprendeu nenhuma magia.")
            return
        }
        
        for magia in mago1.magiasAprendidas {
            print("• \(magia.nome) (\(magia.elemento.rawValue))")
            print("  Mana: \(magia.custoMana) | Poder: \(magia.poder)")
        }
    }
    
    func treinar() {
        print("\n MODO DE TREINO\n")
        
        if mago1.magiasAprendidas.count == 0 {
            print("❌ Você precisa aprender magias primeiro!")
            return
        }
        
        var vidaDummy = 100
        print("Um boneco de treino aparece! Vida: \(vidaDummy)\n")
        
        while vidaDummy > 0 && mago1.manaAtual > 0 {
            print(" Sua mana: \(mago1.manaAtual)")
            print(" Vida do boneco: \(vidaDummy)")
            print("\n1. Atacar")
            print("2. Parar treino")
            print("Escolha: ", terminator: "")
            
            let escolha = readLine() ?? "2"
            
            if escolha == "2" {
                break
            }
            
            if escolha == "1" {
                print("\nEscolha uma magia:")
                var numero = 1
                for magia in mago1.magiasAprendidas {
                    print("\(numero). \(magia.nome) (Mana: \(magia.custoMana))")
                    numero = numero + 1
                }
                
                print("Magia: ", terminator: "")
                let escolhaMagia = readLine() ?? "0"
                
                if let numeroMagia = Int(escolhaMagia) {
                    if numeroMagia > 0 && numeroMagia <= mago1.magiasAprendidas.count {
                        let magia = mago1.magiasAprendidas[numeroMagia - 1]
                        
                        if mago1.manaAtual >= magia.custoMana {
                            mago1.manaAtual = mago1.manaAtual - magia.custoMana
                            vidaDummy = vidaDummy - magia.poder
                            print("\n💥 Você causou \(magia.poder) de dano!")
                            mago1.ganharExperiencia(quantidade: magia.poder)
                        } else {
                            print("❌ Mana insuficiente!")
                        }
                    }
                }
            }
        }
        
        if vidaDummy <= 0 {
            print("\n🎉 Você derrotou o boneco de treino!")
            print("🌟 Ganhou experiência extra!")
            mago1.ganharExperiencia(quantidade: 50)
        }
    }
}

let academia = Academia()
academia.iniciar()
