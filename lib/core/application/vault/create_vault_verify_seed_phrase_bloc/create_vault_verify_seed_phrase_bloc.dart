import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_vault_verify_seed_phrase_bloc.freezed.dart';

@freezed
class PhraseQuestion with _$PhraseQuestion {
  factory PhraseQuestion({
    required int wordIndex,
    required String correctWord,
    required List<String> choices,
  }) = _PhraseQuestion;
}

class CreateVaultVerifySeedPhraseBloc extends Bloc<
    CreateVaultVerifySeedPhraseEvent, CreateVaultVerifySeedPhraseState> {
  final String seedPhrase;
  final int totalQuestions = 5; // total number of questions
  int choicesPerQuestion = 4; // number of choices per question

  CreateVaultVerifySeedPhraseBloc({
    required this.seedPhrase,
  }) : super(
          CreateVaultVerifySeedPhraseState.initial(
            data: VerifySeedPhraseTrackData(
              questions: [],
              currentQuestion: 0,
            ),
          ),
        ) {
    on<CreateVaultVerifySeedPhraseEventGenerateQuestions>(_onGenerateQuestions);
    on<CreateVaultVerifySeedPhraseEventCheckWord>(_onCheckWord);
    on<CreateVaultVerifySeedPhraseEventGoNext>(_onGoNext);
  }

  void _onGenerateQuestions(
    CreateVaultVerifySeedPhraseEventGenerateQuestions event,
    Emitter emit,
  ) {
    final originalPhrases = seedPhrase.split(" ");
    List<PhraseQuestion> questions = [];
    List<String> phrases = List.from(originalPhrases);
    phrases.removeAt(0);
    phrases.removeLast();
    phrases.shuffle(); // Shuffling places words at random positions
    var correctWords =
        phrases.sublist(0, totalQuestions); // Getting the first N random words

    for (var answer in correctWords) {
      var phraseCopy = List<String>.from(phrases);
      phraseCopy.removeWhere(
        (element) => correctWords.contains(element),
      ); // Subtracting correctWords from phrase
      phraseCopy.shuffle();
      var incorrectAnswers = phraseCopy.sublist(
        0,
        choicesPerQuestion - 1,
      ); //Randomly select words from the remaining words

      incorrectAnswers.add(answer);
      incorrectAnswers.shuffle();
      questions.add(
        PhraseQuestion(
          wordIndex: originalPhrases.indexOf(answer),
          correctWord: answer,
          choices: incorrectAnswers,
        ),
      );
    }

    emit(
      CreateVaultVerifySeedPhraseState.question(
        data: state.data.copyWith(
          questions: questions,
          currentQuestion: 0,
        ),
      ),
    );
  }

  Future<void> _onCheckWord(
    CreateVaultVerifySeedPhraseEventCheckWord event,
    Emitter emit,
  ) async {
    final trackData = state.data;
    final currentQuestion = trackData.questions[trackData.currentQuestion];
    if (currentQuestion.wordIndex == event.wordIndex) {
      emit(CreateVaultVerifySeedPhraseState.correct(data: trackData));
      await Future.delayed(const Duration(milliseconds: 500));
      add(CreateVaultVerifySeedPhraseEvent.goNext());
    } else {
      emit(CreateVaultVerifySeedPhraseState.incorrect(data: trackData));
    }
  }

  Future<void> _onGoNext(
    CreateVaultVerifySeedPhraseEventGoNext event,
    Emitter emit,
  ) async {
    final currentTrackData = state.data;
    if (currentTrackData.currentQuestion == totalQuestions - 1) {
      // completed
      emit(CreateVaultVerifySeedPhraseState.completed(data: currentTrackData));
      return;
    }
    final newTrackData = state.data.copyWith(
      questions: state.data.questions,
      currentQuestion: state.data.currentQuestion + 1,
    );
    emit(CreateVaultVerifySeedPhraseState.question(data: newTrackData));
  }
}

@freezed
class CreateVaultVerifySeedPhraseEvent with _$CreateVaultVerifySeedPhraseEvent {
  factory CreateVaultVerifySeedPhraseEvent.generateQuestions() =
      CreateVaultVerifySeedPhraseEventGenerateQuestions;
  factory CreateVaultVerifySeedPhraseEvent.checkWord({
    required int wordIndex,
  }) = CreateVaultVerifySeedPhraseEventCheckWord;
  factory CreateVaultVerifySeedPhraseEvent.goNext() =
      CreateVaultVerifySeedPhraseEventGoNext;
}

@freezed
class CreateVaultVerifySeedPhraseState with _$CreateVaultVerifySeedPhraseState {
  factory CreateVaultVerifySeedPhraseState.initial({
    required VerifySeedPhraseTrackData data,
  }) = CreateVaultVerifySeedPhraseStateInitial;
  factory CreateVaultVerifySeedPhraseState.question({
    required VerifySeedPhraseTrackData data,
  }) = CreateVaultVerifySeedPhraseStateQuestion;
  factory CreateVaultVerifySeedPhraseState.correct({
    required VerifySeedPhraseTrackData data,
  }) = CreateVaultVerifySeedPhraseStateCorrect;
  factory CreateVaultVerifySeedPhraseState.incorrect({
    required VerifySeedPhraseTrackData data,
  }) = CreateVaultVerifySeedPhraseStateInCorrect;
  factory CreateVaultVerifySeedPhraseState.completed({
    required VerifySeedPhraseTrackData data,
  }) = CreateVaultVerifySeedPhraseStateCompleted;
}

@freezed
class VerifySeedPhraseTrackData with _$VerifySeedPhraseTrackData {
  factory VerifySeedPhraseTrackData({
    required List<PhraseQuestion> questions,
    required int currentQuestion,
  }) = _VerifySeedPhraseTrackData;
}
