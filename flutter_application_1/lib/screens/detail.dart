import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/bloc/data/data_cubit.dart';
import 'package:flutter_app/screens/layout/header.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        context.read<DataCubit>().obtainConsults();
        return MainScaffold(
          selectedItem: 0, // TODO: change this to a list of tabs
          title: 'Detalle',
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: HonorTheme.colors.primaryLight),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              EasyRichText(
                                'Por pagar: 100.000',
                                defaultStyle: HonorTypography.header,
                                patternList: [
                                  EasyRichTextPattern(
                                    targetString: '100.000',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Icon(CupertinoIcons.arrowtriangle_down,
                                    color: HonorTheme.colors.darkLight,
                                    size: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: HonorTheme.colors.primaryLight),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              hintText: 'Buscar',
                              prefixIcon: Icon(CupertinoIcons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: HonorTheme.colors.primaryVariantLight,
                                  width: 1, // This is the line to add
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: HonorTheme.colors.white,
                                  width: 1, // This is the line to add
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
