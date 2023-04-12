import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/controller/game_bloc/game_bloc.dart';
import 'package:machine_test/model/constants/app_color_scheme.dart';
import 'package:machine_test/model/constants/app_constants.dart';
import 'package:machine_test/model/constants/custom_decoration.dart';
import 'package:machine_test/model/game_screen_args.dart';
import 'package:machine_test/view/components/app_padding.dart';

class GameScreen extends StatefulWidget {
  final GameScreenArgs args;

  const GameScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final sliverGridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisSpacing: AppConstants.defaultPadding,
    crossAxisSpacing: AppConstants.defaultPadding,
    crossAxisCount: widget.args.columns,
    childAspectRatio: 1,
  );

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameBloc>(
      create: (context) => GameBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColorScheme.primaryColor,
              title: Text(
                "Play Ground",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColorScheme.onPrimaryColor),
              )),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  const AppPadding(),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: textController,
                      decoration:
                          CustomDecoration.inputDecoration(label: "PlayText"),
                      onChanged: (value) {
                        BlocProvider.of<GameBloc>(context, listen: false).add(
                          GameEvent(
                              text: value,
                              gameScreenArgs: widget.args,
                              toggleDirection:
                                  BlocProvider.of<GameBloc>(context).toggle),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.add_box_outlined),
                      const AppPadding(),
                      const Text("All Directions"),
                      const AppPadding(),
                      BlocBuilder<GameBloc, GameState>(
                        builder: (context, state) {
                          if (state is GameInitialState ||
                              state is GameLoadingState) {
                            return Switch(
                                value: false,
                                onChanged: (value) {
                                  BlocProvider.of<GameBloc>(context,
                                          listen: false)
                                      .add(
                                    GameEvent(
                                        text: BlocProvider.of<GameBloc>(context)
                                            .text,
                                        gameScreenArgs: widget.args,
                                        toggleDirection: true),
                                  );
                                });
                          } else if (state is GameLoadedState) {
                            return Switch(
                                value: state.toggleDirection,
                                activeColor: state.isMatching
                                    ? AppColorScheme.gridMatchColor
                                    : AppColorScheme.gridErrorColor,
                                inactiveThumbColor: state.isMatching
                                    ? AppColorScheme.gridMatchColor
                                    : AppColorScheme.gridErrorColor,
                                onChanged: (value) {
                                  BlocProvider.of<GameBloc>(context,
                                          listen: false)
                                      .add(
                                    GameEvent(
                                        text: BlocProvider.of<GameBloc>(context)
                                            .text,
                                        gameScreenArgs: widget.args,
                                        toggleDirection:
                                            !state.toggleDirection),
                                  );
                                });
                          } else {
                            return Switch(
                                value: false,
                                onChanged: (value) {
                                  BlocProvider.of<GameBloc>(context,
                                          listen: false)
                                      .add(
                                    GameEvent(
                                        text: BlocProvider.of<GameBloc>(context)
                                            .text,
                                        gameScreenArgs: widget.args,
                                        toggleDirection: true),
                                  );
                                });
                          }
                        },
                      ),
                    ],
                  ),
                  const AppPadding(),
                  const AppPadding(),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.args.totalCount,
                      gridDelegate: sliverGridDelegate,
                      itemBuilder: (context, index) {
                        return BlocBuilder<GameBloc, GameState>(
                          builder: (context, state) {
                            if (state is GameInitialState ||
                                state is GameLoadingState) {
                              return _DefaultContainer(
                                text: widget.args.alphabets[index],
                              );
                            } else if (state is GameLoadedState) {
                              return Container(
                                padding: const EdgeInsets.all(
                                    AppConstants.defaultPadding),
                                decoration: BoxDecoration(
                                  color: state.indexList[index]
                                      ? state.isMatching
                                          ? AppColorScheme.gridMatchColor
                                          : AppColorScheme.gridErrorColor
                                      : AppColorScheme.gridDefaultColor,
                                  borderRadius: BorderRadius.circular(
                                      !state.indexList[index]
                                          ? AppConstants.cornerRadius
                                          : AppConstants.cornerRadius * 5),
                                ),
                                child: Center(
                                    child: Text(
                                  widget.args.alphabets[index],
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                )),
                              );
                            } else {
                              return _DefaultContainer(
                                  text: widget.args.alphabets[index]);
                            }
                          },
                        );
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _DefaultContainer extends StatelessWidget {
  final String text;
  const _DefaultContainer({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppColorScheme.gridDefaultColor,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
      child: Center(
          child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      )),
    );
  }
}
