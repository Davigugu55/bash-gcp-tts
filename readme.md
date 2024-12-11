# Bash GCP-TTS

## Script Description

This Bash script uses the Google Cloud Text-to-Speech API to convert a text into audio. The resulting audio is saved in `.wav` format in a directory named `Audios`.

This script was developed to facilitate the conversion of text to audio using the Google Cloud Text-to-Speech API. For more information, refer to the [official documentation](https://cloud.google.com/text-to-speech/docs).

## Prerequisites

1. **Google Cloud SDK**: Ensure that you have the Google Cloud SDK installed and configured in your environment. To install, follow the official instructions: https://cloud.google.com/sdk/docs/install

2. **Authentication**: Log in to your Google Cloud account using the command `gcloud auth login`. This command will open a page in your browser where you can enter your Google credentials. After logging in, your environment will be authenticated to use `gcloud` commands.

3. **Google Cloud Project**: Make sure you are using the correct project in Google Cloud. You can set the default project using the command:
   ```
   gcloud config set project [PROJECT_ID]
   ```
   Replace `[PROJECT_ID]` with your Google Cloud project ID.

4. **Install jq Library**: Library responsible for transforming the data obtained through the arguments and the payload to send to the API.
   ```bash
   sudo apt-get install jq
   ```

## Usage

To run the script, you need to provide a filename as an argument. The script will generate an audio file with this name in `.wav` format.

```bash
./script.sh -f <FILENAME> -t <TEXT>
```

### Example

```bash
./script.sh -f my_audio -t "Olá, não estamos disponíveis no momento."
```

This command will create a file named `my_audio.wav` in the `Audios` directory.

## Script Workflow

1. **Argument Check**: The script checks if a filename and text is provided as an argument. If not, it displays a usage message and exits.

2. **Authentication**: The script uses the `gcloud auth print-access-token` command to obtain an access token, which is used to authenticate the API call to the Text-to-Speech service.

3. **Directory Creation**: The script checks if the `Audios` directory exists. If it does not exist, the script creates it.

4. **Text-to-Speech API Call**: The script makes a `curl` request to the Google Cloud Text-to-Speech API, passing the audio configuration and text parameters. The API response is saved in a `.txt` file within the `Audios` directory.

5. **Processing the Result**: The script processes the `.txt` file to extract the base64-encoded audio content, decodes this content, and saves it as a `.wav` file in the same directory. Temporary files are removed after processing.

## Notes

- Ensure that the `gcloud` command is available in your `PATH`.
- Appropriate permissions must be configured in your Google Cloud project to use the Text-to-Speech API.
- The script is configured to use the voice `pt-BR-Wavenet-E`, but you can change this configuration directly in the script as needed. As well as the text to be read by TTS.