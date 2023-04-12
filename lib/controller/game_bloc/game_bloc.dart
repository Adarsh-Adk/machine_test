import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/model/game_screen_args.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  String _text = "";
  String get text => _text;

  bool _toggle = false;
  bool get toggle => _toggle;

  GameBloc() : super(GameInitialState()) {
    on<GameEvent>((event, emit) {
      _text = event.text;
      _toggle = event.toggleDirection;
      emit(GameLoadingState());
      try {
        int rows = event.gameScreenArgs.row;
        int column = event.gameScreenArgs.columns;
        bool searchResult = false;
        List<String> alphabetsList = List.generate(
            event.gameScreenArgs.alphabets.length,
            (index) => event.gameScreenArgs.alphabets[index]);
        List<List<String>> grid = [];
        List<List<bool>> selected = [];
        List<bool> indexBoolList = [];

        int alpha = 0;
        while (alpha < alphabetsList.length) {
          List<bool> innerSelected = [];
          List<String> innerRow = [];
          for (int j = 0; j < column && alpha < alphabetsList.length; j++) {
            innerRow.add(alphabetsList[alpha]);
            innerSelected.add(false);
            alpha++;
          }
          selected.add(innerSelected);
          grid.add(innerRow);
        }

        // Search horizontally from RTL

        for (int row = 0; row < grid.length; row++) {
          String rowString = grid[row].reversed.join('');
          if (rowString.contains(event.text) && event.text.length > 1) {
            int startIndex = rowString.indexOf(event.text);
            for (int i = startIndex; i < startIndex + event.text.length; i++) {
              selected[row][column - 1 - i] = true;
            }
            if (event.toggleDirection) {
              searchResult = true;
            } else {
              searchResult = false;
            }
          }
        }

        //search vertically from BTT

        for (int col = column - 1; col >= 0; col--) {
          String colString = '';

          for (int row = grid.length - 1; row >= 0; row--) {
            colString += grid[row][col];
          }

          if (colString.contains(event.text)) {
            int startIndex = colString.indexOf(event.text);

            for (int i = startIndex; i < startIndex + event.text.length; i++) {
              selected[rows - i - 1][col] = true;
            }
            if (event.toggleDirection) {
              searchResult = true;
            } else {
              searchResult = false;
            }
          }
        }

        //search diagonally from TRTBL
        if (rows == column) {
          String diaString = '';
          for (int input = 0; input <= (rows - 1); input++) {
            diaString += grid[input][(rows - 1) - input];
          }
          if (diaString.contains(event.text)) {
            int startIndex = diaString.indexOf(event.text);
            for (int j = startIndex; j < startIndex + event.text.length; j++) {
              selected[j][rows - 1 - j] = true;
            }
            searchResult = true;
          }
        }

        // Search horizontally from LTR
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

        // Search vertically from TTB
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

        for (int i = 0; i < selected.length; i++) {
          for (int j = 0; j < selected[i].length; j++) {
            indexBoolList.add(selected[i][j]);
          }
        }

        emit(GameLoadedState(
            indexList: indexBoolList,
            isMatching: searchResult,
            toggleDirection: event.toggleDirection));
      } catch (e) {
        emit(GameFailedState(error: e.toString()));
      }
    });
  }
}
