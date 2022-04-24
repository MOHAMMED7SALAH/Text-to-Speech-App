import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text_example/api/speech_api.dart';
import 'package:speech_to_text_example/widget/substring_highlighted.dart';

import '../utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = 'Press the button and start speaking';
  bool isListening = false;
  double confidence = 1.0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Confidence: ${(confidence * 100.0).toStringAsFixed(1)}%'),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.content_copy),
                onPressed: () async {
                  await FlutterClipboard.copy(text);

                  Scaffold.of(context).showSnackBar(
                    const SnackBar(content: Text('✓   Copied to Clipboard')),
                  );
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: const EdgeInsets.all(30).copyWith(bottom: 150),
          child: SubstringHighlight(
            text: text,
            terms: Command.all,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            textStyleHighlight: const TextStyle(
              fontSize: 32.0,
              color: Colors.green,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          endRadius: 75,
          glowColor: Theme.of(context).primaryColor,
          child: FloatingActionButton(
            child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
            onPressed: _listen,
          ),
        ),
      );
void _listen() async {
    if (!isListening) {
      bool available = await SpeechApi.speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => isListening = true);
        SpeechApi.speech.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => isListening = false);
      SpeechApi.speech.stop();
    }
  }
  // Future toggleRecording() => SpeechApi.toggleRecording(
  //       onResult: (text) {
  //         return setState(() {
  //           this.text = text;
  //           if (text.hasConfidenceRating && text.confidence > 0) {
  //             confidence = text.confidence;
  //           }
  //         });
  //       },
  //       //  _text = val.recognizedWords;
  //       //     if (val.hasConfidenceRating && val.confidence > 0) {
  //       //       _confidence = val.confidence;
  //       //     }
  //       onListening: (isListening) {
  //         setState(() => this.isListening = isListening);

  //         if (!isListening) {
  //           Future.delayed(const Duration(seconds: 1), () {
  //             Utils.scanText(text);
  //           });
  //         }
  //       },
  //     );
}
