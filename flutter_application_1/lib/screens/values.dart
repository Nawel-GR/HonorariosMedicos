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
                            final Patient user = state.clinicData!.patients[i];
                            return Container(
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
                                    width: MediaQuery.of(context).size.width *
                                        0.70,
                                    child: Text(
                                      "${TextUtils.capitalizeFirstLetter(user.nombre)}:",
                                      style: HonorTypography.body,
                                    ),
                                  ),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Text("\$${user.total}"))
                                ],
                              ),
                            );
                          },
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
