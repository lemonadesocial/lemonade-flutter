import 'package:app/core/application/vault/create_vault_verify_seed_phrase_bloc/create_vault_verify_seed_phrase_bloc.dart';
import 'package:app/theme/color.dart';
import 'package:app/theme/spacing.dart';
import 'package:app/theme/typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhraseCheckAnswersOptions extends StatefulWidget {
  final CreateVaultVerifySeedPhraseState state;
  final List<String> phrases;
  const PhraseCheckAnswersOptions({
    super.key,
    required this.state,
    required this.phrases,
  });

  @override
  State<PhraseCheckAnswersOptions> createState() =>
      _PhraseCheckAnswersOptionsState();
}

class _PhraseCheckAnswersOptionsState extends State<PhraseCheckAnswersOptions> {
  String? selectedWord;

  @override
  Widget build(BuildContext context) {
    final trackData = widget.state.data;
    final currentQuestion = trackData.questions[trackData.currentQuestion];

    return BlocConsumer<CreateVaultVerifySeedPhraseBloc,
        CreateVaultVerifySeedPhraseState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () => null,
          question: (data) {
            setState(() {
              selectedWord = null;
            });
          },
        );
      },
      builder: (context, state) => Column(
        children: currentQuestion.choices.map((choice) {
          late Color borderColor;
          borderColor = state.maybeWhen(
            orElse: () => Colors.transparent,
            correct: (data) => choice == currentQuestion.correctWord
                ? LemonColor.snackBarSuccess
                : Colors.transparent,
            incorrect: (data) => choice == selectedWord
                ? LemonColor.errorRedBg
                : Colors.transparent,
          );
          return InkWell(
            onTap: () {
              if (selectedWord != null) {
                return;
              }
              setState(() {
                selectedWord = choice;
              });
              context.read<CreateVaultVerifySeedPhraseBloc>().add(
                    CreateVaultVerifySeedPhraseEvent.checkWord(
                      wordIndex: widget.phrases.indexOf(choice),
                    ),
                  );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: Spacing.xSmall),
              child: Container(
                height: 54.w,
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.smMedium,
                ),
                decoration: BoxDecoration(
                  color: LemonColor.atomicBlack,
                  borderRadius: BorderRadius.circular(LemonRadius.small),
                  border: Border.all(color: borderColor),
                ),
                child: Center(
                  child: Text(
                    choice,
                    style: Typo.medium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
