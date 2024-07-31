# Bash TTS-GCP

## Descrição do Script

Este script Bash utiliza a API de Text-to-Speech do Google Cloud para converter um texto em áudio. O áudio resultante é salvo no formato `.wav` em um diretório chamado `Audios`.

Este script foi desenvolvido para facilitar a conversão de textos em áudio utilizando a API de Text-to-Speech do Google Cloud. Para mais informações, consulte a [documentação oficial](https://cloud.google.com/text-to-speech/docs).

## Pré-requisitos

1. **Google Cloud SDK**: Certifique-se de ter o Google Cloud SDK instalado e configurado em seu ambiente. Para instalar, siga as instruções oficiais: https://cloud.google.com/sdk/docs/install

2. **Autenticação**: Faça login na sua conta do Google Cloud utilizando o comando `gcloud auth login`. Este comando abrirá uma página no seu navegador para que você insira suas credenciais do Google. Após o login, seu ambiente estará autenticado para usar os comandos do `gcloud`.

3. **Projeto Google Cloud**: Verifique se você está usando o projeto correto no Google Cloud. Você pode definir o projeto padrão usando o comando:
   ```
   gcloud config set project [ID_DO_PROJETO]
   ```
   Substitua `[ID_DO_PROJETO]` pelo ID do seu projeto no Google Cloud.

## Uso

Para executar o script, você deve fornecer um nome de arquivo como argumento. O script irá gerar um arquivo de áudio com este nome no formato `.wav`.

```bash
./script.sh <NOME_DO_ARQUIVO>
```

### Exemplo

```bash
./script.sh meu_audio
```

Este comando irá criar um arquivo chamado `meu_audio.wav` no diretório `Audios`.

## Funcionamento do Script

1. **Verificação do Argumento**: O script verifica se um nome de arquivo foi fornecido como argumento. Se não for, ele exibe uma mensagem de uso e termina a execução.

2. **Autenticação**: O script utiliza o comando `gcloud auth print-access-token` para obter um token de acesso, que é usado para autenticar a chamada à API de Text-to-Speech.

3. **Criação do Diretório**: O script verifica se o diretório `Audios` existe. Se não existir, ele o cria.

4. **Chamada à API de Text-to-Speech**: O script faz uma solicitação `curl` para a API de Text-to-Speech do Google Cloud, passando os parâmetros de configuração de áudio e texto. O resultado da API é salvo em um arquivo `.txt` dentro do diretório `Audios`.

5. **Processamento do Resultado**: O script processa o arquivo `.txt` para extrair o conteúdo de áudio codificado em base64, decodifica este conteúdo e salva como um arquivo `.wav` no mesmo diretório. Os arquivos temporários são removidos após o processamento.

## Observações

- Certifique-se de que o comando `gcloud` está disponível no seu `PATH`.
- As permissões adequadas devem estar configuradas no seu projeto do Google Cloud para utilizar a API de Text-to-Speech.
- O script está configurado para usar a voz `pt-BR-Wavenet-E`, mas você pode alterar essa configuração diretamente no script conforme necessário, assim como o texto a ser lido.