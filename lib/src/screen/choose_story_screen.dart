import "package:flutter/material.dart";
import "package:the_guide/src/common/msg_constants.dart";

class ChooseStoryScreen extends StatefulWidget {
  const ChooseStoryScreen({super.key});

  static Future<void> push(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const ChooseStoryScreen(),
        ),
      );

  @override
  State<ChooseStoryScreen> createState() => _ChooseStoryScreenState();
}

class _ChooseStoryScreenState extends State<ChooseStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Choose Story"),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 64.0,
            ),
            child: Text(
              MsgConstants.storiesIntro,
            ),
          ),
        ],
      ),
    );
  }
}
