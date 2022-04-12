const kSpanishSpecialCharacters = ['á', 'é', 'í', 'ñ', 'ó', 'ú', 'ü', '¿', '¡'];

const kLanguageElementTranslations = {
  LanguageElement.word: 'słowo',
  LanguageElement.verb: 'czasownik',
  LanguageElement.phrase: 'fraza'
};

enum MessageType { error, success }

enum LanguageElement { word, verb, phrase }

enum PopupAction { edit, delete, details }

enum LearningOption { all, custom }

enum AnswerStatus { none, correct, incorrect }
