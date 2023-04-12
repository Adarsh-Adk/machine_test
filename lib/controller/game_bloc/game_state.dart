part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class GameInitialState extends GameState {
  @override
  List<Object> get props => [];
}

class GameLoadingState extends GameState {
  @override
  List<Object> get props => [];
}

class GameLoadedState extends GameState {
  final List<bool> indexList;
  final bool isMatching;
  final bool toggleDirection;

  const GameLoadedState(
      {required this.indexList,
      required this.isMatching,
      required this.toggleDirection});
  @override
  List<Object> get props => [indexList, isMatching, toggleDirection];
}
