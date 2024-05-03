import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/screens/layout/header.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/utils/text_utils.dart';
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
                    "13917203-5  - Miércoles 12/10/2022 al Miércoles 12/10/2022",
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
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HonorTheme.colors.darkLighter,
                                    width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.70,
                              child: Text(
                                "${TextUtils.capitalizeFirstLetter("PRIETO OVALLE GREGORIO")}:",
                                style: HonorTypography.body,
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text("\$91.499"))
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.70,
                                child: Text(
                                    "${TextUtils.capitalizeFirstLetter("DOUGNAC SEPULVEDA MARIANNE VICTORIA")}:")),
                            Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text("\$91.499"))
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    "${TextUtils.capitalizeFirstLetter("ARIZTIA SILVA ANDRES")}:")),
                            Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text("\$73.199"))
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    "${TextUtils.capitalizeFirstLetter("PALMA BAEZA ELIAN AARON")}:")),
                            Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text("\$73.199"))
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    "${TextUtils.capitalizeFirstLetter("PEREZ BUENO JOAQUIN IGNACIO")}:")),
                            Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text("\$91.499"))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text(
                                    "${TextUtils.capitalizeFirstLetter("SANCHEZ CORONADO RODRIGO GABRIEL")}:")),
                            Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text("\$91.499"))
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
