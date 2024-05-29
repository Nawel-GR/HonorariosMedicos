import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/models/data.dart';
import 'package:flutter_app/screens/layout/header.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/utils/text_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValuesScreen extends StatefulWidget {
  static const String routeName = '/values';

  const ValuesScreen({super.key, required this.users});

  final List<Patient>? users;

  @override
  State<ValuesScreen> createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  ApiService apiService = ApiService();
  Map<String, String> changedValues = {};
  Map<String, String> initialValues = {};
  late Map<String, TextEditingController> textEditingControllers;

  bool cancelTriggered = false;

  @override
  void initState() {
    super.initState();
    initialValues = _getInitialValues();
    changedValues = {};
    textEditingControllers = _initializeTextEditingControllers();
  }

  Map<String, TextEditingController> _initializeTextEditingControllers() {
    Map<String, TextEditingController> controllers = {};
    for (var e in initialValues.keys) {
      controllers[e] = TextEditingController(text: initialValues[e]);
    }
    return controllers;
  }

  Map<String, String> _getInitialValues() {
    // Initialize initial values from report items
    Map<String, String> initialValues = {};
    List<Patient> patientItems = widget.users!;
    for (var e in patientItems) {
      initialValues[e.nombre] = e.total.toString();
    }
    return initialValues;
  }

  void updateModifiedValue(String title, String value) {
    setState(() {
      changedValues[title] = value;
    });
  }

  void resetToInitialValues() {
    setState(() {
      for (var e in textEditingControllers.entries) {
        e.value.text = initialValues[e.key]!;
      }
    });
  }

  void _saveValues() {
    // Function to save the changed values, e.g., send them to an API
    // apiService.saveValues(changedValues);
    // Clear the map after saving
    // Print the changed values
    changedValues.forEach((key, value) {
      print('Index: $key, Value: $value');
    });
    setState(() {
      changedValues.clear();
      initialValues.clear();
    });
  }

  void _cancelChanges() {
    setState(() {
      changedValues.clear();
      cancelTriggered = true; // Trigger rebuild with initial values
      // Optionally restore text fields to initial values if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(builder: (context, state) {
      return MainScaffold(
        selectedItem: 0, // TODO: change this to a list of tabs
        title: 'Información',
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    "Clínica Alemana archivo N°1",
                    style: HonorTypography.titleLarge,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HonorTheme.colors.primaryLight),
                  child: Center(
                      child: Text(
                    "${state.clinicData!.professional.valor}  - ${state.clinicData!.date.valor}",
                    style: HonorTypography.subtitleStrong,
                  )),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HonorTheme.colors.primaryLight),
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.30),
                        child: ListView.separated(
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 4),
                          itemCount: state.clinicData!.patients.length,
                          itemBuilder: (context, i) {
                            final user = state.clinicData!.patients[i];
                            if (!initialValues.containsKey(user.nombre)) {
                              initialValues[user.nombre] =
                                  user.total.toString();
                            }
                            return EditingTextWidget(
                              i: i,
                              textController:
                                  textEditingControllers[user.nombre]!,
                              initialValue: initialValues[user.nombre]!,
                              onChanged: (newValue) {
                                updateModifiedValue(user.nombre, newValue);
                              },
                              onCancel: () {
                                setState(
                                  () {
                                    if (changedValues
                                        .containsKey(user.nombre)) {
                                      changedValues.remove(user.nombre);
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    resetToInitialValues();
                    changedValues.clear();
                  },
                  child: Text('Cancelar'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _saveValues,
                  child: Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class EditingTextWidget extends StatefulWidget {
  final int i;
  final TextEditingController textController;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final VoidCallback onCancel;

  const EditingTextWidget({
    super.key,
    required this.i,
    required this.textController,
    required this.initialValue,
    required this.onChanged,
    required this.onCancel,
  });
  @override
  State<EditingTextWidget> createState() => _EditingTextWidgetState();
}

class _EditingTextWidgetState extends State<EditingTextWidget> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    widget.textController.text = widget.initialValue;
  }

  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<DataCubit>().state.clinicData!.patients[widget.i];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: HonorTheme.colors.darkLighter, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.70,
            child: Text(
              "${TextUtils.capitalizeFirstLetter(user.nombre)}:",
              style: HonorTypography.body,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isEditing = !isEditing;
                if (isEditing) {
                  widget.textController.text = widget.initialValue;
                } else {
                  widget.onChanged(widget.textController.text);
                }
              });
            },
            child: Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width * 0.20,
              child: Visibility(
                visible: !isEditing,
                replacement: TextField(
                  onChanged: (newValue) {},
                  onSubmitted: (newValue) {
                    setState(() {
                      isEditing = false;
                      user.total = int.parse(newValue);
                      widget.onChanged(widget.textController.text);
                    });
                  },
                  autofocus: true,
                  controller: widget.textController,
                  onTapOutside: (event) {
                    setState(
                      () {
                        isEditing = false;
                        user.total = int.parse(widget.textController.text);

                        widget.onChanged(widget.textController.text);
                      },
                    );
                    widget.onChanged(widget.textController.text);
                  },
                ),
                child: Text(
                  "\$${widget.textController.text}", // Display initial total
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
