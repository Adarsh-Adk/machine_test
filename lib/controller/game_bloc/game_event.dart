part of 'game_bloc.dart';

class GameEvent extends Equatable {
  final String text;
  final GameScreenArgs gameScreenArgs;

  const GameEvent({required this.text, required this.gameScreenArgs});

  @override
  List<Object?> get props => [text, gameScreenArgs];
}
