import '../blocs/forest_bloc/forest_bloc.dart';
import '../core/colors.dart';
import '../core/helper/date_format_helper.dart';
import '../models/create_forest_model.dart';
import '../models/forest_model.dart';
import 'fires_page.dart';
import '../widgets/app_snack_bar.dart';
import '../widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../widgets/app_button.dart';
import '../widgets/loading_widget.dart';
import 'pick_location_for_device.dart';

TextEditingController forestName = TextEditingController();
TextEditingController forestDescription = TextEditingController();
TextEditingController addressName = TextEditingController();

LatLng? pickedLocationLatLngForForest = const LatLng(0, 0);

class ForestsPage extends StatefulWidget {
  const ForestsPage({super.key});

  @override
  State<ForestsPage> createState() => _ForestsPageState();
}

class _ForestsPageState extends State<ForestsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forests',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppButton(
              onPressed: () {
                pickedLocationLatLngForForest = LatLng(0, 0);
                showDialogForCreateCar(context);
              },
              title: 'Add Forest',
            ),
          ),
        ],
      ),
      body: BlocConsumer<ForestBloc, ForestState>(
        listener: (context, state) {
          if (state is ForestActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: state.actionMessage,
                isSuccess: true,
              ),
            );
            forestName.clear();
            forestDescription.clear();
            addressName.clear();
            context.read<ForestBloc>().add(
                  FetchForests(),
                );
          } else if (state is ForestActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: 'Error . . . Please Try Again !',
                isSuccess: false,
              ),
            );
            forestName.clear();
            forestDescription.clear();
            addressName.clear();
          }
        },
        builder: (context, state) {
          if (state is ForestLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is ForestSuccess) {
            return PlutoGrid(
              mode: PlutoGridMode.readOnly,
              columns: _buildColumns(context),
              rows: _buildRows(state.forests),
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
          } else if (state is ForestError) {
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

  Future<dynamic> showDialogForCreateCar(BuildContext outerContext) {
    pickedLocationLatLngForForest = const LatLng(0, 0);
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
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
                          'Forest Name',
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
                      controller: forestName,
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
                          'Forest Description',
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
                      controller: forestDescription,
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
                          'Address Details',
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
                      controller: addressName,
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
                        Text(
                          pickedLocationLatLngForForest == const LatLng(0, 0)
                              ? 'Pick Location'
                              : 'Picked Location',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff353438),
                          ),
                        ),
                        pickedLocationLatLngForForest == const LatLng(0, 0)
                            ? IconButton(
                                color: primaryColor,
                                onPressed: () async {
                                  pickedLocationLatLngForForest =
                                      await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const PickLocationPage();
                                      },
                                    ),
                                  );
                                  print(pickedLocationLatLngForForest);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add_location_alt_outlined,
                                  size: 36,
                                ),
                              )
                            : Tooltip(
                                verticalOffset: -60,
                                message: 'Edit Location',
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      12,
                                    ),
                                  ),
                                  hoverColor: primaryColor.withOpacity(0.1),
                                  onTap: () async {
                                    pickedLocationLatLngForForest =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const PickLocationPage();
                                        },
                                      ),
                                    );
                                    print(pickedLocationLatLngForForest);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            12,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: primaryColor,
                                        )),
                                    child: Column(
                                      children: [
                                        Text(
                                          'latitude: ${pickedLocationLatLngForForest!.latitude.toStringAsFixed(
                                            4,
                                          )}',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'longitude: ${pickedLocationLatLngForForest!.longitude.toStringAsFixed(
                                            4,
                                          )}',
                                        )
                                      ],
                                    ),
                                  ),
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
                            outerContext.read<ForestBloc>().add(
                                  CreateForest(
                                    createForestModel:
                                        CreateOrUpdateForestModel(
                                      name: forestName.text,
                                      description: forestDescription.text,
                                      nameAddress: addressName.text,
                                      latitude: pickedLocationLatLngForForest!
                                          .latitude
                                          .toString(),
                                      longitude: pickedLocationLatLngForForest!
                                          .longitude
                                          .toString(),
                                    ),
                                  ),
                                );
                            Navigator.pop(context);
                            pickedLocationLatLngForForest = const LatLng(0, 0);
                          },
                          title: 'Add Forest',
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
        });
      },
    );
  }
}

List<PlutoColumn> _buildColumns(BuildContext outerContext) {
  return [
    PlutoColumn(
      suppressedAutoSize: true,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'ID',
      field: 'ID',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Name',
      field: 'Name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Description',
      field: 'Description',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Forest Address',
      field: 'Forest Address',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Created At',
      field: 'Created At',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Actions',
      field: 'Actions',
      type: PlutoColumnType.number(),
      renderer: (rendererContext) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: outerContext,
                  builder: (context) {
                    return StatefulBuilder(builder: (context, setState) {
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
                                      'Forest Name',
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
                                  controller: forestName,
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    hintText: rendererContext.row.cells.values
                                        .elementAt(1)
                                        .value,
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
                                      'Forest Description',
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
                                  controller: forestDescription,
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    hintText: rendererContext.row.cells.values
                                        .elementAt(2)
                                        .value,
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
                                      'Address Details',
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
                                  controller: addressName,
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    hintText: rendererContext.row.cells.values
                                        .elementAt(3)
                                        .value,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      pickedLocationLatLngForForest ==
                                              const LatLng(0, 0)
                                          ? 'Pick Location'
                                          : 'Picked Location',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff353438),
                                      ),
                                    ),
                                    pickedLocationLatLngForForest ==
                                            const LatLng(0, 0)
                                        ? IconButton(
                                            color: primaryColor,
                                            onPressed: () async {
                                              pickedLocationLatLngForForest =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const PickLocationPage();
                                                  },
                                                ),
                                              );
                                              print(
                                                  pickedLocationLatLngForForest);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.add_location_alt_outlined,
                                              size: 36,
                                            ),
                                          )
                                        : Tooltip(
                                            verticalOffset: -60,
                                            message: 'Edit Location',
                                            child: InkWell(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  12,
                                                ),
                                              ),
                                              hoverColor:
                                                  primaryColor.withOpacity(0.1),
                                              onTap: () async {
                                                pickedLocationLatLngForForest =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return const PickLocationPage();
                                                    },
                                                  ),
                                                );
                                                print(
                                                    pickedLocationLatLngForForest);
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(
                                                        12,
                                                      ),
                                                    ),
                                                    border: Border.all(
                                                      color: primaryColor,
                                                    )),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'latitude: ${pickedLocationLatLngForForest!.latitude.toStringAsFixed(
                                                        4,
                                                      )}',
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'longitude: ${pickedLocationLatLngForForest!.longitude.toStringAsFixed(
                                                        4,
                                                      )}',
                                                    )
                                                  ],
                                                ),
                                              ),
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
                                        outerContext.read<ForestBloc>().add(
                                              UpdateForest(
                                                updateForestId: rendererContext
                                                    .row
                                                    .cells
                                                    .values
                                                    .first
                                                    .value
                                                    .toString(),
                                                updateForestModel:
                                                    CreateOrUpdateForestModel(
                                                  name: forestName.text.isEmpty
                                                      ? rendererContext
                                                          .row.cells.values
                                                          .elementAt(1)
                                                          .value
                                                      : forestName.text,
                                                  description: forestDescription
                                                          .text.isEmpty
                                                      ? rendererContext
                                                          .row.cells.values
                                                          .elementAt(2)
                                                          .value
                                                      : forestDescription.text,
                                                  nameAddress:
                                                      addressName.text.isEmpty
                                                          ? rendererContext
                                                              .row.cells.values
                                                              .elementAt(3)
                                                              .value
                                                          : addressName.text,
                                                  latitude:
                                                      pickedLocationLatLngForForest!
                                                          .latitude
                                                          .toString(),
                                                  longitude:
                                                      pickedLocationLatLngForForest!
                                                          .longitude
                                                          .toString(),
                                                ),
                                              ),
                                            );
                                        Navigator.pop(context);
                                        pickedLocationLatLngForForest =
                                            const LatLng(0, 0);
                                      },
                                      title: 'Update Forest',
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
                    });
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
                                    'Are you sure you want to delete this forest?',
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
                                      outerContext.read<ForestBloc>().add(
                                            DeleteForest(
                                              deleteForestId: rendererContext
                                                  .row.cells.values.first.value
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

List<PlutoRow> _buildRows(List<ForestModel> forests) {
  return forests.map((forest) {
    pickedLocationLatLngForForest =
        LatLng(double.parse(forest.latitude!), double.parse(forest.longitude!));
    return PlutoRow(
      cells: {
        'ID': PlutoCell(value: forest.id),
        'Name': PlutoCell(value: forest.name),
        'Description': PlutoCell(value: forest.description),
        'Forest Address': PlutoCell(value: forest.nameAddress),
        'Created At': PlutoCell(
          value: DateFormatHelper.getFormattedDate(date: forest.createdAt!),
        ),
        'Actions': PlutoCell(value: forest.id),
      },
    );
  }).toList();
}

// Future<void> navigationWithReturnLatitudeAndLongitude(
//     BuildContext context) async {
//   final result = await Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const PickLocationPage(),
//     ),
//   );
//   print(result);
// }
