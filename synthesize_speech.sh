#!/bin/bash

# Check if a voice name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <FILENAME>"
  exit 1
fi

# Assign the provided voice name to a variable
FILENAME=$1

# Replace all occurrences of 'pt-BR-Wavenet-G' with the provided voice name
curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "x-goog-user-project: jdrel-central" \
  -H "Content-Type: application/json; charset=utf-8" \
  --data '{
    "audioConfig": {
      "audioEncoding": "LINEAR16",
      "pitch": 0,
      "speakingRate": 1.15
    },
    "input": {
      "text": "Olá, não estamos disponíveis no momento. O time que atende esta opção, fica disponível de segunda a sexta-feira, das 8 às 12 horas, e das 13 e 30 até às 17 e 40, horário de Cuiabá. Pode nos retornar nesses horários? Obrigado por ligar, até mais!"
    },
    "voice": {
      "languageCode": "pt-BR",
      "name": "pt-BR-Wavenet-E"
    }
  }' "https://texttospeech.googleapis.com/v1/text:synthesize" > Audios/$FILENAME.txt

# Check if the directory does not exist
if [ ! -d "Audios" ]; then
  # Create the directory
  mkdir -p "Audios"
  echo "Directory 'Audios' created."
else
  echo "Directory 'Audios' already exists."
fi 

cat ./Audios/$FILENAME.txt | grep 'audioContent' | \
sed 's|audioContent| |' | tr -d '\n ":{},' > ./Audios/tmp.txt && \
base64 ./Audios/tmp.txt --decode > ./Audios/$FILENAME.wav && \
rm ./Audios/tmp.txt && \
rm ./Audios/$FILENAME.txt