import 'package:camera/camera.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_service.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/screens/camera.dart';
import 'package:flutter_app/screens/detail.dart';
import 'package:flutter_app/screens/layout/header.dart';
import 'package:flutter_app/screens/values.dart';
import 'package:flutter_app/theme/honor_theme.dart';
import 'package:flutter_app/utils/dialog_utils.dart';
import 'package:flutter_app/widgets/button.dart';
import 'package:flutter_app/widgets/circular_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_logger/pretty_logger.dart';

class HomeScreen extends StatelessWidget {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataCubit, DataState>(
      builder: (context, state) {
        return MainScaffold(
          selectedItem: 0, // TODO: change this to a list of tabs
          title: 'Inicio',
          body: Column(
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen()),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: HonorTheme.colors.primaryLight,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EasyRichText(
                          'Por pagar: \$100.000 CLP',
                          defaultStyle: HonorTypography.body,
                          patternList: [
                            EasyRichTextPattern(
                              targetString: '\$100.000',
                              style: TextStyle(
                                color: HonorTheme.colors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Center(
                  child: CircularIconButton(
                icon: CupertinoIcons.cloud_upload,
                onPressed: () async {
                  DialogUtils.showModal(context,
                      title: 'Subir archivo',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                try {
                                  await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: [
                                        'pdf',
                                      ]).then((value) async {
                                    if (value != null) {
                                      DialogUtils.showSpinner(
                                          text: "Enviando imagen");
                                      await context
                                          .read<DataCubit>()
                                          .postData()
                                          .then(
                                        (_) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ValuesScreen(
                                                        users: context
                                                            .read<DataCubit>()
                                                            .state
                                                            .clinicData!
                                                            .patients)),
                                          );
                                        },
                                      );
                                    }
                                  });
                                } catch (e) {
                                  print(e);
                                  PLog.red(
                                      'Error al seleccionar el archivo: $e');
                                }
                                DialogUtils.closeSpinner();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: HonorTheme.colors.primaryLight,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(CupertinoIcons.archivebox,
                                          color: HonorTheme.colors.darkLight,
                                          size: 30),
                                    ),
                                    EasyRichText(
                                      'Subir archivo desde dispositivo',
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () async {
                                // Obtain a list of the available cameras on the device.
                                try {
                                  WidgetsFlutterBinding.ensureInitialized();
                                  DialogUtils.showSpinner(
                                      text: "Abriendo camara");
                                  final cameras = await availableCameras();

                                  // Get a specific camera from the list of available cameras.
                                  final firstCamera = cameras.first;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TakePictureScreen(
                                        camera: firstCamera,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                  PLog.red('Error al abrir la camara: $e');
                                }
                                DialogUtils.closeSpinner();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: HonorTheme.colors.primaryLight,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(CupertinoIcons.camera,
                                          color: HonorTheme.colors.darkLight,
                                          size: 30),
                                    ),
                                    EasyRichText(
                                      'Subir archivo desde camara',
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ));
                },
                color: HonorTheme.colors.primaryLight,
                size: MediaQuery.of(context).size.height * 0.35,
              )),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  color: HonorTheme.colors.primaryLight,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 10),
                        child: HonorButton(
                          buttonSize: ButtonSize.large,
                          text: 'Estado de pagos',
                          onTap: () {},
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: HonorButton(
                          buttonSize: ButtonSize.large,
                          text: 'Tracking',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
