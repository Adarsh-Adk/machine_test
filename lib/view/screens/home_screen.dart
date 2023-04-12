import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:machine_test/custom_router.dart';
import 'package:machine_test/model/constants/app_color_scheme.dart';
import 'package:machine_test/model/constants/app_constants.dart';
import 'package:machine_test/model/constants/custom_decoration.dart';
import 'package:machine_test/model/game_screen_args.dart';
import 'package:machine_test/view/components/app_padding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final rowController = TextEditingController();
  final columnsController = TextEditingController();
  final alphabetsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    rowController.dispose();
    columnsController.dispose();
    alphabetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColorScheme.primaryColor,
          centerTitle: true,
          title: const Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const AppPadding(),
              Text(
                "Enter the number of rows,columns and the alphabets",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const AppPadding(
                multipliedBy: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      maxLength: 1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration:
                          CustomDecoration.inputDecoration(label: "Rows"),
                      controller: rowController,
                      validator: (value) {
                        int val = int.tryParse(value ?? "") ?? 0;
                        if (val > 1) {
                          return null;
                        } else {
                          return "Enter value greater than 0";
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                    ),
                  ),
                  const AppPadding(
                    multipliedBy: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      maxLength: 1,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration:
                          CustomDecoration.inputDecoration(label: "Column"),
                      controller: columnsController,
                      validator: (value) {
                        int val = int.tryParse(value ?? "") ?? 0;
                        if (val > 1) {
                          return null;
                        } else {
                          return "Enter value greater than 0";
                        }
                      },
                      onChanged: (value) {
                        _formKey.currentState?.validate();
                      },
                    ),
                  )
                ],
              ),
              const AppPadding(
                multipliedBy: 2,
              ),
              TextFormField(
                controller: alphabetsController,
                textInputAction: TextInputAction.done,
                decoration:
                    CustomDecoration.inputDecoration(label: "Alphabets"),
                validator: (value) {
                  int rows = int.tryParse(rowController.text) ?? 0;
                  int columns = int.tryParse(columnsController.text) ?? 0;
                  String val = value?.trim() ?? "";
                  log("${val.length} val");
                  if (val.length == (rows * columns)) {
                    return null;
                  } else {
                    return "only ${(rows * columns)} characters required";
                  }
                },
                onChanged: (value) => _formKey.currentState?.validate(),
              ),
              const AppPadding(
                multipliedBy: 2,
              ),
              ElevatedButton.icon(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColorScheme.primaryColor)),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    int rows = int.tryParse(rowController.text) ?? 0;
                    int columns = int.tryParse(columnsController.text) ?? 0;
                    String alphabets = alphabetsController.text.trim();

                    if (rows != 0 &&
                        columns != 0 &&
                        (alphabets.length == rows * columns)) {
                      final arg = GameScreenArgs(
                          row: rows,
                          columns: columns,
                          alphabets: alphabets,
                          totalCount: (rows * columns));

                      Navigator.pushNamed(context, CustomRouter.gameScreen,
                          arguments: arg);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Fix errors")));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fix errors")));
                  }
                },
                icon: const Icon(Icons.grid_3x3),
                label: Text(
                  "Make Grid",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: AppColorScheme.onPrimaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
