#!/bin/bash

# Function to display help
show_usage() {
  echo "Usage: $0 -f <FILENAME> [-t <TEXT>] [-h]"
  echo ""
  echo "Options:"
  echo "  -f <FILENAME>    Name of the output file to save the generated audio (required)."
  echo "  -t <TEXT>        Text to be converted into audio (optional, uses default text if not provided)."
  echo "  -h               Show this help message and exit."
  exit 0
}

# Assign the provided voice name to a variable
FILENAME=""
TEXT=""

# Parse arguments
while getopts "f:t:h" opt; do
  case $opt in
    f)
      FILENAME=$OPTARG
      ;;
    t)
      TEXT=$OPTARG
      ;;
    h)
      show_usage
      ;;
    *)
      show_usage
      ;;
  esac
done

# Check if a voice name is provided
if [ -z "$FILENAME" ]; then
  echo "Error: The output file name (-f) is required."
  show_usage
  exit 1
fi

# Replace all occurrences of 'pt-BR-Wavenet-G' with the provided voice name
curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  -H "x-goog-user-project: jdrel-central" \
  -H "Content-Type: application/json; charset=utf-8" \
  --data " $(jq -n --arg text "$TEXT" '{
    "audioConfig": {
      "audioEncoding": "LINEAR16",
      "pitch": 0,
      "speakingRate": 1.15
    },
    "input": {
      "text": $text
    },
    "voice": {
      "languageCode": "pt-BR",
      "name": "pt-BR-Wavenet-E"
    }
  }')" "https://texttospeech.googleapis.com/v1/text:synthesize" > Audios/$FILENAME.txt

# Check if the directory does not exist
if [ ! -d "Audios" ]; then
  # Create the directory
  mkdir -p "Audios"
  echo "Directory 'Audios' created."
else
  echo "Directory 'Audios' already exists."
fi 

jq -r '.audioContent' ./Audios/$FILENAME.txt | base64 --decode > ./Audios/$FILENAME.wav
rm ./Audios/$FILENAME.txt