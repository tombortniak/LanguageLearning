const kSpanishSpecialCharacters = ['á', 'é', 'í', 'ñ', 'ó', 'ú', 'ü', '¿', '¡'];

const kLanguageNameTranslations = {
  Language.spanish: 'hiszpański',
  Language.english: 'angielski'
};

const kLanguageElementTranslations = {
  LanguageElement.word: 'słowo',
  LanguageElement.verb: 'czasownik',
  LanguageElement.phrase: 'fraza'
};

enum MessageType { error, success }

enum Language { spanish, english }

enum LanguageElement { word, verb, phrase }

enum PopupAction { edit, delete, details }

enum LearningOption { all, custom }

enum AnswerStatus { none, correct, incorrect }
