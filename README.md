# The Guide

This is a simple, text adventure game built with Dart. The entire story, from the initial scenario to the consequences of your choices, is generated dynamically by a Large Language Model (LLM) like Google's Gemini or OpenAI's GPT.

Developed for MacOS and I didn't test it on different platforms.

### How it Works

* **AI Game Master:** The core of the game is an LLM that acts as the storyteller and game master.
* **Dynamic Story:** You can choose from a few pre-written story prompts or provide your own custom idea (e.g., "a space pirate looking for treasure on a deserted moon").
* **Interactive Gameplay:** The game presents a scenario and a set of choices. Your selection is sent back to the AI, which then generates the next part of the story.
* **Stateful:** The game includes a simple inventory and character naming to give the AI context and make the story more personal.


### Getting Started

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/your-username/the_guide.git](https://github.com/your-username/the_guide.git)
    cd the_guide
    ```

2. **Use [FVM](https://fvm.app/) to install required sdk version
    ```bash
    fvm install
    ```


3.  **Set up environment variables:**
    * Create a file named `.env` in the root of the project.
    * Add your LLM API key to it:
    ```
    API_KEY="YOUR_API_KEY_HERE"
    ```

4.  **Install dependencies:**
    ```bash
    fvm flutter pub get
    ```

5.  **Run the application:**
    ```bash
    fvm flutter run -d macos
    ```
