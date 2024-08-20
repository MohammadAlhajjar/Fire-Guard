import '../core/colors.dart';
import '../core/helper/date_format_helper.dart';
import '../models/create_car_model.dart';
import 'fire_brigades_page.dart';
import 'fires_page.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/car_bloc/car_bloc.dart';
import '../models/car_model.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snack_bar.dart';

TextEditingController carName = TextEditingController();
TextEditingController carPlateNumber = TextEditingController();
TextEditingController carModel = TextEditingController();

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  String selectedCenter = '1';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppButton(
              onPressed: () {
                showDialogForCreateCar(context);
              },
              title: 'Add Car',
            ),
          ),
        ],
      ),
      body: BlocListener<CarBloc, CarState>(
        listener: (context, state) {
          if (state is CarActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: state.actionMessage,
                isSuccess: true,
              ),
            );

            carName.clear();
            carModel.clear();
            carPlateNumber.clear();
            context.read<CarBloc>().add(FetchCars());
          } else if (state is CarActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: 'Error . . . Please Try Again !',
                isSuccess: false,
              ),
            );
            carName.clear();
            carModel.clear();
            carPlateNumber.clear();
            context.read<CarBloc>().add(FetchCars());
          }
        },
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is CarSuccess) {
              return PlutoGrid(
                columns: _buildColumns(context),
                rows: _buildRows(state.cars),
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
              );
            } else if (state is CarError) {
              return ErrorMessageWidget(errorMessage: state.errorMessage);
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<dynamic> showDialogForCreateCar(BuildContext outerContext) {
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
                                  'Car Name',
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
                              controller: carName,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                // labelText: 'Task Note',
                                // labelStyle: const TextStyle(
                                //   fontSize: 16,
                                //   color: primaryColor,
                                // ),
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
                                  'Car Model',
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
                              controller: carModel,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                // labelText: 'Task Note',
                                // labelStyle: const TextStyle(
                                //   fontSize: 16,
                                //   color: primaryColor,
                                // ),
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
                                  'Car Plate',
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
                              controller: carPlateNumber,
                              cursorColor: primaryColor,
                              decoration: InputDecoration(
                                // labelText: 'Task Note',
                                // labelStyle: const TextStyle(
                                //   fontSize: 16,
                                //   color: primaryColor,
                                // ),
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
                                  child: DropdownButton<String>(
                                    padding: const EdgeInsets.only(left: 10),
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
                                          value: snapshot.data![index].id
                                              .toString(),
                                          child:
                                              Text(snapshot.data![index].name!),
                                        );
                                      },
                                    ),
                                    // items: const [
                                    //   DropdownMenuItem<String>(
                                    //     value: '1',
                                    //     child: Text('Center 1'),
                                    //   ),
                                    //   DropdownMenuItem<String>(
                                    //     value: '2',
                                    //     child: Text('Center 2'),
                                    //   ),
                                    //   DropdownMenuItem(
                                    //     value: '3',
                                    //     child: Text('Center 3'),
                                    //   ),
                                    // ],
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
                                    outerContext.read<CarBloc>().add(
                                          CreateCar(
                                            createCarModel:
                                                CreateOrUpdateCarModel(
                                              name: carName.text,
                                              model: carModel.text,
                                              numberPlate: carPlateNumber.text,
                                              center: selectedCenter,
                                            ),
                                          ),
                                        );
                                    Navigator.pop(context);
                                  },
                                  title: 'Add Car',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                AppOutlineButton(
                                  onPressed: () {
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
        title: 'Model',
        field: 'Model',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        title: 'Number Plate',
        field: 'Number Plate',
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
        title: 'Created At',
        field: 'Created At',
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                color: primaryColor,
                onPressed: () {
                  showDialog(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Car Name',
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
                                            controller: carName,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              hintText: rendererContext
                                                  .row.cells.values
                                                  .elementAt(1)
                                                  .value,
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
                                                'Car Model',
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
                                            controller: carModel,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              hintText: rendererContext
                                                  .row.cells.values
                                                  .elementAt(2)
                                                  .value,
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
                                                'Car Plate',
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
                                            controller: carPlateNumber,
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                              hintText: rendererContext
                                                  .row.cells.values
                                                  .elementAt(3)
                                                  .value,
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
                                                child: DropdownButton<String>(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
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
                                                            .data![index].id
                                                            .toString(),
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
                                                      .read<CarBloc>()
                                                      .add(
                                                        UpdateCar(
                                                          updateCarId:
                                                              rendererContext
                                                                  .row
                                                                  .cells
                                                                  .values
                                                                  .first
                                                                  .value
                                                                  .toString(),
                                                          updateCarModel:
                                                              CreateOrUpdateCarModel(
                                                            name: carName.text
                                                                    .isEmpty
                                                                ? rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .elementAt(
                                                                        1)
                                                                    .value
                                                                : carName.text,
                                                            model: carModel.text
                                                                    .isEmpty
                                                                ? rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .elementAt(
                                                                        2)
                                                                    .value
                                                                : carModel.text,
                                                            numberPlate: carPlateNumber
                                                                    .text
                                                                    .isEmpty
                                                                ? rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .elementAt(
                                                                        3)
                                                                    .value
                                                                : carPlateNumber
                                                                    .text,
                                                            center:
                                                                selectedCenter,
                                                          ),
                                                        ),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                title: 'Update Car',
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              AppOutlineButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: outerContext,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 20,
                                                            vertical: 20,
                                                          ),
                                                          child: SizedBox(
                                                            width: 450,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      'Are you sure you want to delete this car?',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 50,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    AppButton(
                                                                      onPressed:
                                                                          () {
                                                                        outerContext
                                                                            .read<CarBloc>()
                                                                            .add(
                                                                              DeleteCar(
                                                                                deleteCarId: rendererContext.row.cells.values.first.value.toString(),
                                                                              ),
                                                                            );
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      title:
                                                                          'Yes',
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    AppOutlineButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      text:
                                                                          'No',
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
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                color: primaryColor,
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
                                      'Are you sure you want to delete this car?',
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
                                        outerContext.read<CarBloc>().add(
                                              DeleteCar(
                                                deleteCarId: rendererContext.row
                                                    .cells.values.first.value
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
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          );
        },
      ),
    ];
  }

  List<PlutoRow> _buildRows(List<CarModel> cars) {
    return cars.map((car) {
      return PlutoRow(cells: {
        'ID': PlutoCell(value: car.id),
        'Name': PlutoCell(value: car.name),
        'Model': PlutoCell(value: car.model),
        'Number Plate': PlutoCell(value: car.numberPlate),
        'Center': PlutoCell(value: car.center!.name),
        'Created At': PlutoCell(
          value: DateFormatHelper.getFormattedDate(date: car.createdAt!),
        ),
        'Actions': PlutoCell(value: car.center!.id),
      });
    }).toList();
  }
}
