part of 'game_bloc.dart';

class GameEvent extends Equatable {
  final String text;
  final bool toggleDirection;
  final GameScreenArgs gameScreenArgs;

  const GameEvent(
      {required this.text,
      required this.gameScreenArgs,
      this.toggleDirection = false});

  @override
  List<Object?> get props => [text, gameScreenArgs];
}
