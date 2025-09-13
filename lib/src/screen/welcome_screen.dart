import "package:flutter/material.dart";
import "package:the_guide/src/common/msg_constants.dart";
import "package:the_guide/src/screen/choose_story_screen.dart";

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("The Guide"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(MsgConstants.welcomeMessage),
            ElevatedButton(
              onPressed: () => ChooseStoryScreen.push(context),
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}
