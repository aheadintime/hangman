enum HangmanTopic {
  players,
  guesses,
  state;


  static HangmanTopic? fromString(String topic) {
    if (!topic.startsWith("hangman/")) {
      return null;
    }
  
    if (topic.endsWith("/players")) {
      return HangmanTopic.players;
    }

    if (topic.endsWith("/guesses")) {
      return HangmanTopic.guesses;
    }

    if (topic.endsWith("/state")) {
      return HangmanTopic.state;
    }

    return null;
  }

  String topic(String roomId) {
    switch(this) {
      case HangmanTopic.players:
        return "hangman/$roomId/players";
      case HangmanTopic.guesses:
        return "hangman/$roomId/guesses";
      case HangmanTopic.state:
        return "hangman/$roomId/state";
    }
  }




}
