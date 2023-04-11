import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/model/game_screen_args.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitialState()) {
    on<GameEvent>((event, emit) {
      emit(GameLoadingState());
      int rows = event.gameScreenArgs.row;
      int column = event.gameScreenArgs.columns;
      int totalCount = event.gameScreenArgs.totalCount;
      bool searchResult = false;
      List<String> firstList = List.generate(
          event.gameScreenArgs.alphabets.length,
          (index) => event.gameScreenArgs.alphabets[index]);
      List<List<String>> grid = [];
      List<List<bool>> selected = [];
      List<bool> indexBoolList = [];

      int i = 0;
      while (i < firstList.length) {
        List<bool> innerSelected = [];
        List<String> innerRow = [];
        for (int j = 0; j < column && i < firstList.length; j++) {
          innerRow.add(firstList[i]);
          innerSelected.add(false);
          i++;
        }
        selected.add(innerSelected);
        grid.add(innerRow);
      }

      // Search horizontally
      for (int row = 0; row < grid.length; row++) {
        String rowString = grid[row].join('');
        if (rowString.contains(event.text)) {
          int startIndex = rowString.indexOf(event.text);
          for (int i = startIndex; i < startIndex + event.text.length; i++) {
            selected[row][i] = true;
          }
          searchResult = true;
        }
      }
      // Search vertically
      for (int col = 0; col < grid[0].length; col++) {
        String colString = '';
        for (int row = 0; row < grid.length; row++) {
          colString += grid[row][col];
        }
        if (colString.contains(event.text)) {
          int startIndex = colString.indexOf(event.text);
          for (int i = startIndex; i < startIndex + event.text.length; i++) {
            selected[i][col] = true;
          }
          searchResult = true;
        }
      }
      //search diagonally
      if (rows == column) {
        String diaString = '';
        for (int input = 0; input <= (rows - 1); input++) {
          diaString += grid[input][(rows - 1) - input];
        }
        if (diaString.contains(event.text)) {
          for (int j = 0; j < event.text.length; j++) {
            selected[j][rows - 1 - j] = true;
          }
        }
      }

      for (int i = 0; i < selected.length; i++) {
        for (int j = 0; j < selected[i].length; j++) {
          indexBoolList.add(selected[i][j]);
        }
      }

      emit(GameLoadedState(indexList: indexBoolList, isMatching: searchResult));
    });
  }
}
