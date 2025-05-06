# manage-dns

Este repositório público gerencia, via **Terraform**, a infraestrutura de DNS do domínio [`observatudo.com.br`](https://observatudo.com.br), utilizando práticas de **GitOps** e **Infraestrutura como Código (IaC)**.

> 🎯 Este projeto faz parte do meu portfólio técnico e demonstra minha capacidade de estruturar, versionar e automatizar a gestão de recursos em nuvem de forma profissional.

---

## 🔧 O que este repositório gerencia

- Criação da zona DNS pública do domínio `observatudo.com.br` no **Google Cloud DNS**
- Registros `A` e `CNAME` para subdomínios como:
  - `observatudo.com.br`
  - `www.observatudo.com.br`
  - `jdias.observatudo.com.br`
- (Futuramente) Registros `TXT`, `MX`, ou outros, conforme evolução do domínio

---

## 🧱 Tecnologias e práticas utilizadas

- **Terraform** para definição declarativa da infraestrutura
- **Google Cloud Platform (GCP)** como provedor de DNS
- **GitHub Actions** (em breve) para validar e aplicar alterações com controle de versionamento
- **GitOps** como estratégia principal: todas as alterações passam por revisão via Pull Request antes de serem aplicadas

---

## 📁 Estrutura do repositório

```bash
terraform/
├── zone.tf             # Criação da zona DNS
├── root-and-www.tf     # Registros A e CNAME do domínio principal
├── jdias.tf            # Registros para subdomínio jdias
├── variables.tf        # (opcional) variáveis reutilizáveis
└── backend.tf          # Configuração do state remoto (GCS)
```

---

## 🔐 Observações de segurança

- Nenhuma credencial sensível está armazenada neste repositório
- O acesso à aplicação do Terraform (`terraform apply`) é feito com uma **Service Account do GCP via CI/CD** (em construção)

---

## 👨‍💻 Sobre mim

Este repositório faz parte do meu portfólio pessoal.  
Sou desenvolvedor focado em **DevOps**, **automação**, **infraestrutura moderna** e **experiências digitais baseadas em dados e serviços**.

🌐 Acesse: [https://observatudo.com.br](https://observatudo.com.br)

---

## 📬 Contato

- GitHub: [@seu-usuario](https://github.com/seu-usuario)  
- LinkedIn: [linkedin.com/in/seu-perfil](https://linkedin.com/in/seu-perfil)
