import "package:flutter/material.dart";
import "package:the_guide/src/common/msg_constants.dart";
import "package:the_guide/src/model/story_intro.dart";
import "package:the_guide/src/widget/story_intro_widget.dart";

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24.0,
          children: [
            const Text(
              MsgConstants.storiesIntro,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _storyIntros.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: StoryIntroWidget(
                    key: ValueKey(_storyIntros[i]),
                    onTap: (story) {
                      // TODO: display confirmation popup before moving forward
                    },
                    intro: _storyIntros[i],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<StoryIntro> _storyIntros = [
  // Mythical & Fantasy
  const StoryIntro(
    title: "The Oracle's Defiance",
    genre: "Mythical Greece",
    description:
        "In the sun-drenched city-state of Thrylos, you are a celebrated warrior. The Oracle has spoken a grim prophecy: you will cause the city's downfall. The gods have sealed your fate, but you have other plans. Will you flee your home or stand and fight destiny itself?",
  ),
  const StoryIntro(
    title: "Echoes of the Deep Mountain",
    genre: "Dwarven Fantasy",
    description:
        "Ages ago, the great Dwarven kingdom of your ancestors was lost to goblin hordes. Armed with a tattered map and an unyielding grudge, you lead a small company to reclaim your lost legacy from the shadowed things that now dwell within the mountain's heart.",
  ),
  const StoryIntro(
    title: "The Crown of Ash",
    genre: "Low-Magic Political Fantasy",
    description:
        "The King is dead, and the realm teeters on the brink of civil war. As the heir to a lesser house, you must navigate a treacherous court of spies and schemers to protect your family, or risk it all to claim the Crown of Ash for yourself.",
  ),

  // Sci-Fi
  const StoryIntro(
    title: "The Last Spark",
    genre: "Space Opera (Outer Rim)",
    description:
        "On a forgotten desert moon, you make a living scavenging imperial wrecks. You've just uncovered a hidden vault containing an ancient lightfoil. Moments later, the scream of TIE fighters echoes from above. The Empire knows. You have to run.",
  ),
  const StoryIntro(
    title: "Chrome and Shadow",
    genre: "Cyberpunk Noir",
    description:
        "In the rain-slicked, neon-lit streets of Neo-Alexandria 2077, you're a private investigator with more cybernetic debts than clients. A shadowy corporate figure tasks you with finding a rogue android that has stolen sensitive data. The trail begins in the underbelly of the city, where life is cheap.",
  ),
  const StoryIntro(
    title: "The Sun-Scorched Road",
    genre: "Post-Apocalyptic Survival",
    description:
        "You are a Wayfarer, traveling the broken highways of a fallen world. During a routine supply run, you find a map pointing to a rumored sanctuary, a green place untouched by the blight. The problem is, you're not the only one who's found it.",
  ),

  // Modern & Pop Culture
  const StoryIntro(
    title: "The Emergence",
    genre: "Modern Superhero Origin",
    description:
        "A mysterious energy wave pulsed across the globe, granting a fraction of the population incredible powers. You've just discovered yours. As newfound heroes and villains clash in the streets, you must decide: do you hide, seek fame, or protect the innocent?",
  ),
  const StoryIntro(
    title: "The Serpent's Coil Academy",
    genre: "Magical School / Dark Academia",
    description:
        "As a first-year student at a hidden school of magic, you've stumbled upon a conspiracy. A secret society is operating within the school's ancient walls, and they seem to have taken an interest in you beyond your grades in Potion-making.",
  ),
  const StoryIntro(
    title: "The Crown of Ash",
    genre: "Low-Magic Political Fantasy (Game of Thrones-esque)",
    description:
        "The King of the Iron Concord is dead, and the realm teeters on the brink of civil war. You are the heir to a lesser noble house, sworn to the capital. Every great house is now vying for influence, making alliances, and sharpening their blades in the shadows. You must navigate a treacherous court of spies and schemers to protect your family, or risk it all to claim the Crown of Ash for yourself.",
  ),
];
