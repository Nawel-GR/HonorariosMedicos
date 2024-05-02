import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/screens/layout/header.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ValuesScreen extends StatelessWidget {
  ApiService apiService = ApiService();

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
                    "Clinica Alemana archivo N°1",
                    style: HonorTypography.titleLarge,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HonorTheme.colors.primaryLight),
                  child: SizedBox(
                    width: 500, //TODO: change this to mediaquery
                    height: 80,
                    child: Center(
                        child: Text(
                      "13917203-5  - Miércoles 12/10/2022 al Miércoles 12/10/2022",
                      style: HonorTypography.subtitleStrong,
                    )),
                  ),
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
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: HonorTheme.colors.primaryLight),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("PRIETO OVALLE GREGORIO:"),
                            SizedBox(
                              width: 350,
                            ),
                            Text("\$91.499")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          children: [
                            Text("DOUGNAC SEPULVEDA MARIANNE VICTORIA:"),
                            SizedBox(
                              width: 230,
                            ),
                            Text("\$91.499")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          children: [
                            Text("ARIZTIA SILVA ANDRES"),
                            SizedBox(
                              width: 390,
                            ),
                            Text("\$73.199")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          children: [
                            Text("PALMA BAEZA ELIAN AARON"),
                            SizedBox(
                              width: 350,
                            ),
                            Text("\$73.199")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          children: [
                            Text("PEREZ BUENO JOAQUIN IGNACIO"),
                            SizedBox(
                              width: 320,
                            ),
                            Text("\$91.499")
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          children: [
                            Text("SANCHEZ CORONADO RODRIGO GABRIEL"),
                            SizedBox(
                              width: 260,
                            ),
                            Text("\$91.499")
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
