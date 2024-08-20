import 'package:dio/dio.dart';
import '../core/colors.dart';
import '../core/helper/date_format_helper.dart';
import '../main.dart';
import '../models/create_device_model.dart';
import '../models/forest_model.dart';
import '../widgets/app_button.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/device_bloc/device_bloc.dart';
import '../models/device_model.dart';
import '../widgets/app_snack_bar.dart';
import 'fires_page.dart';
import 'pick_location_for_device.dart';

String selectedForest = '1';
TextEditingController deviceName = TextEditingController();
TextEditingController deviceDescription = TextEditingController();
TextEditingController deviceAddressDetails = TextEditingController();
LatLng? pickedLocationLatLngForDevice = const LatLng(0, 0);

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Devices',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppButton(
              onPressed: () {
                showDialogForCreateDevice(context);
              },
              title: 'Add Device',
            ),
          ),
        ],
      ),
      body: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          print(state);
          if (state is DeviceActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: state.actionMessage,
                isSuccess: true,
              ),
            );
            deviceName.clear();
            deviceDescription.clear();
            deviceAddressDetails.clear();
            context.read<DeviceBloc>().add(FetchDevices());
            taskNoteController.clear();
          } else if (state is DeviceActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: 'Error . . . Please Try Again !',
                isSuccess: false,
              ),
            );
            deviceName.clear();
            deviceDescription.clear();
            deviceAddressDetails.clear();
          }
        },
        builder: (context, state) {
          if (state is DeviceLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is DeviceSuccess) {
            return PlutoGrid(
              columns: _buildColumns(context),
              rows: _buildRow(state.devices),
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
          } else if (state is DeviceError) {
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

  Future<dynamic> showDialogForCreateDevice(BuildContext outerContext) {
    pickedLocationLatLngForDevice = LatLng(0, 0);
    return showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: getForestIds(),
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
                                  'Device Name',
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
                              controller: deviceName,
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
                                  'Device Description',
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
                              controller: deviceDescription,
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
                                  'Address Name',
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
                              controller: deviceAddressDetails,
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
                                  'Choose Forest',
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
                                      fontSize: 17,
                                      color: primaryColor,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedForest,
                                    items: List.generate(snapshot.data!.length,
                                        (index) {
                                      return DropdownMenuItem<String>(
                                        value:
                                            snapshot.data![index].id.toString(),
                                        child: Text(
                                          snapshot.data![index].name!,
                                        ),
                                      );
                                    }),
                                    onChanged: (forest) {
                                      setState(() {
                                        selectedForest = forest!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pickedLocationLatLngForDevice ==
                                          const LatLng(0, 0)
                                      ? 'Pick Location'
                                      : 'Picked Location',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff353438),
                                  ),
                                ),
                                pickedLocationLatLngForDevice ==
                                        const LatLng(0, 0)
                                    ? IconButton(
                                        color: primaryColor,
                                        onPressed: () async {
                                          pickedLocationLatLngForDevice =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PickLocationPage(),
                                            ),
                                          );
                                          print(pickedLocationLatLngForDevice);
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
                                          hoverColor:
                                              primaryColor.withOpacity(0.1),
                                          onTap: () async {
                                            pickedLocationLatLngForDevice =
                                                await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return const PickLocationPage();
                                                },
                                              ),
                                            );
                                            print(
                                              pickedLocationLatLngForDevice,
                                            );
                                            setState(() {});
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
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
                                                  'latitude: ${pickedLocationLatLngForDevice!.latitude.toStringAsFixed(
                                                    4,
                                                  )}',
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'longitude: ${pickedLocationLatLngForDevice!.longitude.toStringAsFixed(
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
                                    outerContext.read<DeviceBloc>().add(
                                          CreateNewDevice(
                                            createDeviceModel:
                                                CreateOrUpdateDeviceModel(
                                              name: deviceName.text,
                                              description:
                                                  deviceDescription.text,
                                              forest: selectedForest,
                                              latitude:
                                                  pickedLocationLatLngForDevice!
                                                      .latitude
                                                      .toString(),
                                              longitude:
                                                  pickedLocationLatLngForDevice!
                                                      .longitude
                                                      .toString(),
                                              nameAddress:
                                                  deviceAddressDetails.text,
                                            ),
                                          ),
                                        );
                                    Navigator.pop(context);
                                    pickedLocationLatLngForDevice =
                                        const LatLng(0, 0);
                                  },
                                  title: 'Add Device',
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
      title: 'Description',
      field: 'Description',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Device Address',
      field: 'Device Address',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Latitude',
      field: 'Latitude',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      title: 'Longitude',
      field: 'Longitude',
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
      title: 'Updated At',
      field: 'Updated At',
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
                      future: getForestIds(),
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
                                              'Device Name',
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
                                          controller: deviceName,
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
                                              'Device Description',
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
                                          controller: deviceDescription,
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
                                              'Address Name',
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
                                          controller: deviceAddressDetails,
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
                                              'Choose Forest',
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
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(12),
                                                ),
                                                underline: Container(),
                                                iconEnabledColor: primaryColor,
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  color: primaryColor,
                                                ),
                                                dropdownColor: Colors.white,
                                                value: selectedForest,
                                                items: List.generate(
                                                    snapshot.data!.length,
                                                    (index) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: snapshot
                                                        .data![index].id
                                                        .toString(),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].name!,
                                                    ),
                                                  );
                                                }),
                                                onChanged: (forest) {
                                                  setState(() {
                                                    selectedForest = forest!;
                                                  });
                                                },
                                              ),
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
                                            Text(
                                              pickedLocationLatLngForDevice ==
                                                      const LatLng(0, 0)
                                                  ? 'Pick Location'
                                                  : 'Picked Location',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff353438),
                                              ),
                                            ),
                                            pickedLocationLatLngForDevice ==
                                                    const LatLng(0, 0)
                                                ? IconButton(
                                                    color: primaryColor,
                                                    onPressed: () async {
                                                      pickedLocationLatLngForDevice =
                                                          await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const PickLocationPage(),
                                                        ),
                                                      );
                                                      print(
                                                          pickedLocationLatLngForDevice);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .add_location_alt_outlined,
                                                      size: 36,
                                                    ),
                                                  )
                                                : Tooltip(
                                                    verticalOffset: -60,
                                                    message: 'Edit Location',
                                                    child: InkWell(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          12,
                                                        ),
                                                      ),
                                                      hoverColor: primaryColor
                                                          .withOpacity(0.1),
                                                      onTap: () async {
                                                        pickedLocationLatLngForDevice =
                                                            await Navigator
                                                                .push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return const PickLocationPage();
                                                            },
                                                          ),
                                                        );
                                                        print(
                                                          pickedLocationLatLngForDevice,
                                                        );
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                    12,
                                                                  ),
                                                                ),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      primaryColor,
                                                                )),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'latitude: ${pickedLocationLatLngForDevice!.latitude.toStringAsFixed(
                                                                4,
                                                              )}',
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              'longitude: ${pickedLocationLatLngForDevice!.longitude.toStringAsFixed(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            AppButton(
                                              onPressed: () {
                                                outerContext
                                                    .read<DeviceBloc>()
                                                    .add(
                                                      UpdateDevice(
                                                        updateDeviceId:
                                                            rendererContext
                                                                .cell
                                                                .row
                                                                .cells
                                                                .values
                                                                .first
                                                                .value
                                                                .toString(),
                                                        updateDeviceModel:
                                                            CreateOrUpdateDeviceModel(
                                                          name: deviceName
                                                                  .text.isEmpty
                                                              ? rendererContext
                                                                  .row
                                                                  .cells
                                                                  .values
                                                                  .elementAt(1)
                                                                  .value
                                                              : deviceName.text,
                                                          description: deviceDescription
                                                                  .text.isEmpty
                                                              ? rendererContext
                                                                  .row
                                                                  .cells
                                                                  .values
                                                                  .elementAt(2)
                                                                  .value
                                                              : deviceDescription
                                                                  .text,
                                                          forest:
                                                              selectedForest,
                                                          latitude:
                                                              pickedLocationLatLngForDevice!
                                                                  .latitude
                                                                  .toString(),
                                                          longitude:
                                                              pickedLocationLatLngForDevice!
                                                                  .longitude
                                                                  .toString(),
                                                          nameAddress:
                                                              deviceAddressDetails
                                                                      .text
                                                                      .isEmpty
                                                                  ? rendererContext
                                                                      .row
                                                                      .cells
                                                                      .values
                                                                      .elementAt(
                                                                          3)
                                                                      .value
                                                                  : deviceAddressDetails
                                                                      .text,
                                                        ),
                                                      ),
                                                    );
                                                Navigator.pop(context);
                                                pickedLocationLatLngForDevice =
                                                    const LatLng(0, 0);
                                              },
                                              title: 'Update Device',
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
                                    'Are you sure you want to delete this device?',
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
                                      outerContext.read<DeviceBloc>().add(
                                            DeleteDevice(
                                              deleteDeviceId: rendererContext
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

List<PlutoRow> _buildRow(List<DeviceModel> devices) {
  return devices.map((device) {
    pickedLocationLatLngForDevice = LatLng(
      double.parse(device.latitude!),
      double.parse(
        device.longitude!,
      ),
    );
    return PlutoRow(cells: {
      'ID': PlutoCell(value: device.id),
      'Name': PlutoCell(value: device.name),
      'Description': PlutoCell(value: device.description),
      'Device Address': PlutoCell(value: device.nameAddress),
      'Latitude': PlutoCell(value: device.latitude),
      'Longitude': PlutoCell(value: device.longitude),
      'Created At': PlutoCell(
        value: DateFormatHelper.getFormattedDate(date: device.createdAt!),
      ),
      'Updated At': PlutoCell(
        value: DateFormatHelper.getFormattedDate(date: device.updatedAt!),
      ),
      'Actions': PlutoCell(value: device.forest!.id),
    });
  }).toList();
}

Future<List<ForestModel>> getForestIds() async {
  final response = await Dio().get(
    'https://firegard.cupcoding.com/backend/public/api/admin/forests',
    options: Options(
      headers: {
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
      },
    ),
  );

  if (response.statusCode == 200) {
    List<ForestModel> forests = List.generate(
      response.data['pagination']['items'].length,
      (index) {
        // print('================================');
        // print(response.data['pagination']['items'][index]);
        return ForestModel.fromMap(
          response.data['pagination']['items'][index],
        );
      },
    );
    // print(response.data['pagination']['items']);
    // print(fireBrigades);
    return forests;
  } else {
    return [];
  }
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