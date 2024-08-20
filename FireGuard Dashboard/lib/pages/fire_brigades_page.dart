import 'package:dio/dio.dart';
import '../blocs/fire_brigade_bloc/fire_brigade_bloc.dart';
import '../core/colors.dart';
import '../main.dart';
import '../models/center_model.dart';
import '../models/create_fire_brigade_model.dart';
import '../widgets/app_snack_bar.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../models/fire_brigade_model.dart';
import '../widgets/app_button.dart';
import 'fires_page.dart';

TextEditingController fireBrigadeName = TextEditingController();
TextEditingController fireBrigadeEmail = TextEditingController();
TextEditingController fireBrigadePassword = TextEditingController();

class FireBrigadesPage extends StatefulWidget {
  const FireBrigadesPage({super.key});

  @override
  State<FireBrigadesPage> createState() => _FireBrigadesPageState();
}

class _FireBrigadesPageState extends State<FireBrigadesPage> {
  int selectedNumber = 5;
  int selectedCenter = 1;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fire Brigades'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppButton(
              onPressed: () {
                showDialogForCreateFireBrigade(context);
              },
              title: 'Add Fire Brigade',
            ),
          ),
        ],
      ),
      body: BlocConsumer<FireBrigadeBloc, FireBrigadeState>(
        listener: (context, state) {
          if (state is FireBrigadeActionSuccesss) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: state.actionMessage,
                isSuccess: true,
              ),
            );
            context.read<FireBrigadeBloc>().add(FetchFireBrigades());
            fireBrigadeName.clear();
            fireBrigadeEmail.clear();
            fireBrigadePassword.clear();
          } else if (state is FireBrigadeActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: 'Error . . . Please Try Again !',
                isSuccess: false,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FireBrigadeLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is FireBrigadeSuccess) {
            return PlutoGrid(
              columns: _buildColumns(context),
              rows: _buildRows(state.fireBrigades),
              configuration: const PlutoGridConfiguration(
                columnSize: PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.equal,
                ),
                style: PlutoGridStyleConfig(
                  gridBackgroundColor: Colors.white,
                  activatedColor: Colors.white,
                  activatedBorderColor: Colors.grey,
                  gridBorderRadius: BorderRadius.zero,
                ),
              ),
              onChanged: (PlutoGridOnChangedEvent event) {
                // Handle cell changes
              },
            );
          } else if (state is FireBrigadeError) {
            return ErrorMessageWidget(errorMessage: state.errorMessage);
          } else {
            return const Center(
              child: LoadingWidget(),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> showDialogForCreateFireBrigade(BuildContext outerContext) {
    return showDialog(
      context: outerContext,
      builder: (context) {
        return FutureBuilder(
          future: getCenterIds(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 50,
                      ),
                      child: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Fire Brigade Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff353438),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextField(
                              controller: fireBrigadeName,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Fire Brigade Email',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff353438),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextField(
                              controller: fireBrigadeEmail,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Fire Brigade Password',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff353438),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextField(
                              controller: fireBrigadePassword,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primaryColor.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Choose Team Count',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff353438),
                                  ),
                                ),
                                NumberPicker(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        12,
                                      ),
                                    ),
                                    color: primaryColor.withOpacity(0.09),
                                  ),
                                  itemHeight: 35,
                                  selectedTextStyle: const TextStyle(
                                    fontSize: 25,
                                    color: primaryColor,
                                  ),
                                  minValue: 5,
                                  maxValue: 10,
                                  value: selectedNumber,
                                  onChanged: (number) {
                                    setState(() {
                                      selectedNumber = number;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Choose Center',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff353438),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  child: DropdownButton<int>(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    underline: Container(),
                                    iconEnabledColor: primaryColor,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: primaryColor,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedCenter,
                                    items: List.generate(
                                      snapshot.data!.length,
                                      (index) {
                                        return DropdownMenuItem(
                                          value: snapshot.data![index].id,
                                          child:
                                              Text(snapshot.data![index].name!),
                                        );
                                      },
                                    ),
                                    onChanged: (center) {
                                      setState(() {
                                        selectedCenter = center!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AppButton(
                                  onPressed: () {
                                    // print(fireBrigadeName.text);
                                    // print('$selectedNumber');
                                    // print('$selectedCenter');
                                    // print(fireBrigadeEmail.text);
                                    // print(fireBrigadePassword.text);
                                    outerContext.read<FireBrigadeBloc>().add(
                                          CreateFireBrigade(
                                            createFireBrigadeModel:
                                                CreateOrUpdateFireBrigadeModel(
                                              name: fireBrigadeName.text,
                                              numberOfTeam: selectedNumber,
                                              center: selectedCenter,
                                              email: fireBrigadeEmail.text,
                                              password:
                                                  fireBrigadePassword.text,
                                            ),
                                          ),
                                        );
                                    Navigator.pop(context);
                                  },
                                  title: 'Add Fire Brigade',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                AppOutlineButton(
                                  onPressed: () {
                                    fireBrigadeName.clear();
                                    fireBrigadeEmail.clear();
                                    fireBrigadePassword.clear();
                                    Navigator.pop(context);
                                  },
                                  text: 'Close',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
          },
        );
      },
    );
  }

  List<PlutoColumn> _buildColumns(BuildContext outerContext) {
    return [
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'ID',
        field: 'ID',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Name',
        field: 'Name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Email',
        field: 'Email',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Number of Team',
        field: 'Number of Team',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Center',
        field: 'Center',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Actions',
        field: 'Actions',
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          selectedNumber = rendererContext.row.cells.values.elementAt(3).value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: outerContext,
                    builder: (context) {
                      return FutureBuilder(
                        future: getFireBridgeIds(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Builder(builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 50,
                                    ),
                                    child: SizedBox(
                                      width: 400,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Fire Brigade Name',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff353438),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextField(
                                            controller: fireBrigadeName,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              hintText: rendererContext
                                                  .row.cells.values
                                                  .elementAt(1)
                                                  .value
                                                  .toString(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.5),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Fire Brigade Email',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff353438),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextField(
                                            controller: fireBrigadeEmail,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              hintText: rendererContext
                                                  .row.cells.values
                                                  .elementAt(2)
                                                  .value
                                                  .toString(),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.5),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Fire Brigade Password',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff353438),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          TextField(
                                            controller: fireBrigadePassword,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              hintText: "**********",
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: primaryColor,
                                                  width: 2,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: primaryColor
                                                      .withOpacity(0.5),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Choose Team Count',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff353438),
                                                ),
                                              ),
                                              NumberPicker(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      12,
                                                    ),
                                                  ),
                                                  color: primaryColor
                                                      .withOpacity(0.09),
                                                ),
                                                itemHeight: 35,
                                                selectedTextStyle:
                                                    const TextStyle(
                                                  fontSize: 25,
                                                  color: primaryColor,
                                                ),
                                                minValue: 5,
                                                maxValue: 10,
                                                value: selectedNumber,
                                                onChanged: (number) {
                                                  setState(() {
                                                    selectedNumber = number;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Choose Center',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff353438),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: primaryColor,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                ),
                                                child: DropdownButton<int>(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(12),
                                                  ),
                                                  underline: Container(),
                                                  iconEnabledColor:
                                                      primaryColor,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: primaryColor,
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  value: selectedCenter,
                                                  items: List.generate(
                                                    snapshot.data!.length,
                                                    (index) {
                                                      return DropdownMenuItem(
                                                        value: snapshot
                                                            .data![index].id,
                                                        child: Text(snapshot
                                                            .data![index]
                                                            .name!),
                                                      );
                                                    },
                                                  ),
                                                  onChanged: (center) {
                                                    setState(() {
                                                      selectedCenter = center!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              AppButton(
                                                onPressed: () {
                                                  outerContext
                                                      .read<FireBrigadeBloc>()
                                                      .add(
                                                        UpdateFireBrigade(
                                                          rendererContext
                                                              .row
                                                              .cells
                                                              .values
                                                              .first
                                                              .value
                                                              .toString(),
                                                          updateFireBrigadeModel:
                                                              CreateOrUpdateFireBrigadeModel(
                                                            name: fireBrigadeName
                                                                    .text
                                                                    .isEmpty
                                                                ? rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .elementAt(
                                                                        1)
                                                                    .value
                                                                : fireBrigadeName
                                                                    .text,
                                                            numberOfTeam:
                                                                selectedNumber,
                                                            center:
                                                                selectedCenter,
                                                            email: fireBrigadeEmail
                                                                    .text
                                                                    .isEmpty
                                                                ? rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .elementAt(
                                                                      2,
                                                                    )
                                                                    .value
                                                                : fireBrigadeEmail
                                                                    .text,
                                                            password:
                                                                fireBrigadePassword
                                                                    .text,
                                                          ),
                                                        ),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                title: 'Update Fire Brigade',
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              AppOutlineButton(
                                                onPressed: () {
                                                  fireBrigadeName.clear();
                                                  fireBrigadeEmail.clear();
                                                  fireBrigadePassword.clear();
                                                  Navigator.pop(context);
                                                },
                                                text: 'Close',
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                          } else {
                            return const Center(
                              child: LoadingWidget(),
                            );
                          }
                        },
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: outerContext,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          child: SizedBox(
                            width: 450,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Are you sure you want to delete this fire brigade?',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AppButton(
                                      onPressed: () {
                                        outerContext
                                            .read<FireBrigadeBloc>()
                                            .add(
                                              DeleteFireBrigade(
                                                deleteFireBrigadeId:
                                                    rendererContext.row.cells
                                                        .values.first.value
                                                        .toString(),
                                              ),
                                            );
                                        Navigator.pop(context);
                                      },
                                      title: 'Yes',
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    AppOutlineButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      text: 'No',
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: primaryColor,
                ),
              ),
            ],
          );
        },
      ),
    ];
  }

  List<PlutoRow> _buildRows(List<FireBrigadeModel> fireBrigades) {
    return fireBrigades.map((brigade) {
      return PlutoRow(cells: {
        'ID': PlutoCell(value: brigade.id),
        'Name': PlutoCell(value: brigade.name),
        'Email': PlutoCell(value: brigade.email),
        'Number of Team': PlutoCell(value: brigade.numberOfTeam),
        'Center': PlutoCell(value: brigade.center!.name),
        'Actions': PlutoCell(value: brigade),
      });
    }).toList();
  }
}

Future<List<CenterModel>> getCenterIds() async {
  final response = await Dio().get(
    'https://firegard.cupcoding.com/backend/public/api/admin/centers',
    options: Options(
      headers: {
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
      },
    ),
  );

  if (response.statusCode == 200) {
    List<CenterModel> centers = List.generate(
      response.data['pagination']['items'].length,
      (index) => CenterModel.fromMap(
        response.data['pagination']['items'][index],
      ),
    );
    return centers;
  } else {
    return [];
  }
}
