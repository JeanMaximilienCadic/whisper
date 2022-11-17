import whisper
from argparse import ArgumentParser

if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument(
        "--audio_path",
        type=str,
        default="/srv/lake/landing/CADIC/cadic-asr-deepspeech/jsut_ver1.1/basic5000/wav/BASIC5000_0001.wav",
    )
    args = parser.parse_args()
    language = None
    model = whisper.load_model("large").cuda()
    result = model.transcribe(args.audio_path, language=language, temperature=0.0)

    transcription = result["text"].lower()
    print(transcription)
