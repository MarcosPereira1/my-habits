# Meus Hábitos 📱

Bem-vindo ao repositório do "Meus Hábitos"! Este é um aplicativo mobile desenvolvido em Flutter, criado para ajudar os usuários a gerenciar e acompanhar seus hábitos diários. Este projeto reflete minha evolução como desenvolvedor, aplicando boas práticas de desenvolvimento de software, como Clean Architecture e o padrão BLoC.

## 📸 Capturas de Tela

<div align="center">
  <img src="https://github.com/user-attachments/assets/1b58464d-b254-4753-8f79-803bf5150cef" alt="Screenshot 1" width="300"/>
  <img src="https://github.com/user-attachments/assets/a1ee5160-0a19-4627-a93d-c35f1ea4e3e1" alt="Screenshot 2" width="300"/>
  <img src="https://github.com/user-attachments/assets/b07453f7-bfac-4c08-b8bc-adb3bdc195d1" alt="Screenshot 3" width="300"/>
  <img src="https://github.com/user-attachments/assets/f220d276-0d06-4960-b4da-7220dcf35fe0" alt="Screenshot 4" width="300"/>
</div>


## 🚀 Funcionalidades
- Criação e gerenciamento de hábitos diários.
- Acompanhamento do progresso de cada hábito.
- Histórico de hábitos concluídos.

## 🛠️ Tecnologias Utilizadas
- **Flutter**: Framework para desenvolvimento multiplataforma.
- **BLoC Pattern**: Para gerenciar o estado do app de forma reativa.
- **Clean Architecture**: Para manter o código organizado, modular e de fácil manutenção.
- **Shared Preferences**: Para armazenamento de dados localmente.

## 🧱 Estrutura do Projeto

O projeto foi estruturado com base nos princípios da **Clean Architecture**, garantindo uma separação clara entre as camadas de apresentação, domínio e dados. Abaixo está uma visualização da estrutura:

![Clean Architecture Structure](![image](https://github.com/user-attachments/assets/215d3c2d-3369-4d04-bad8-87f8a7681634)  
*Exemplo de estrutura utilizando Clean Architecture.*

### 📂 Camadas do Projeto
- **Presentation**: Contém as telas (UI) e o gerenciamento de estado (BLoC).
- **Domain**: Contém as regras de negócio, entidades, casos de uso e repositórios abstratos.
- **Data**: Contém a implementação dos repositórios, modelos e fontes de dados.

## 🎨 Padrões de Design
Utilizamos o **BLoC Pattern** para manter a interface do usuário desacoplada da lógica de negócio, proporcionando um código mais limpo e testável.

