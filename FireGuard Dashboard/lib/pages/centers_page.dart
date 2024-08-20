import '../blocs/center_bloc/center_bloc.dart';
import '../core/colors.dart';
import '../core/helper/date_format_helper.dart';
import '../models/create_center_model.dart';
import 'fires_page.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../models/center_model.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snack_bar.dart';
import 'pick_location_for_device.dart';

TextEditingController centerName = TextEditingController();
TextEditingController centerDescription = TextEditingController();
TextEditingController centerPhone = TextEditingController();
TextEditingController centerAddressdetails = TextEditingController();

List<Map<String, dynamic>> centerStatus = [
  {
    'label': 'On Work',
    'value': 'OnWork',
  },
  {
    'label': 'Maintenance',
    'value': 'Maintenance',
  },
  {
    'label': 'Off Duty',
    'value': 'OffDuty',
  },
];
LatLng? pickedLocationLatLngForCenter = const LatLng(0, 0);

String selectedCenterStatus = centerStatus[0]['value'];

class CentersPage extends StatefulWidget {
  const CentersPage({super.key});

  @override
  State<CentersPage> createState() => _CentersPageState();
}

class _CentersPageState extends State<CentersPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centers'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppButton(
              onPressed: () {
                showDialogForCreateCenter(context);
              },
              title: 'Add Center',
            ),
          ),
        ],
      ),
      body: BlocConsumer<CenterBloc, CenterState>(
        listener: (context, state) {
          print(state);
          if (state is CenterActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: state.actionMessage,
                isSuccess: true,
              ),
            );
            centerName.clear();
            centerPhone.clear();
            centerDescription.clear();
            centerAddressdetails.clear();
            context.read<CenterBloc>().add(
                  FetchCenters(),
                );
          } else if (state is CenterActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              appSnackBar(
                screenWidth: screenWidth,
                title: 'Error . . . Please Try Again !',
                isSuccess: false,
              ),
            );
            centerName.clear();
            centerPhone.clear();
            centerDescription.clear();
            centerAddressdetails.clear();
          }
        },
        builder: (context, state) {
          if (state is CenterLoading) {
            return const Center(
              child: LoadingWidget(),
            );
          } else if (state is CenterSuccess) {
            return PlutoGrid(
              columns: _buildColumns(context),
              rows: _buildRows(state.centers),
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
          } else if (state is CenterError) {
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

  Future<dynamic> showDialogForCreateCenter(BuildContext outerContext) {
    pickedLocationLatLngForCenter = LatLng(0, 0);
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
                          'Center Name',
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
                      controller: centerName,
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
                          'Center Description',
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
                      controller: centerDescription,
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
                          'Center Phone',
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
                      controller: centerPhone,
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
                      controller: centerAddressdetails,
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
                          'Choose Status',
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
                            value: selectedCenterStatus,
                            items: List.generate(centerStatus.length, (index) {
                              return DropdownMenuItem<String>(
                                value: centerStatus[index]['value'],
                                child: Text(
                                  centerStatus[index]['label'],
                                ),
                              );
                            }),
                            onChanged: (newCenterStatus) {
                              print(newCenterStatus);
                              setState(() {
                                selectedCenterStatus = newCenterStatus!;
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
                          pickedLocationLatLngForCenter == const LatLng(0, 0)
                              ? 'Pick Location'
                              : 'Picked Location',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color(0xff353438),
                          ),
                        ),
                        pickedLocationLatLngForCenter == const LatLng(0, 0)
                            ? IconButton(
                                color: primaryColor,
                                onPressed: () async {
                                  pickedLocationLatLngForCenter =
                                      await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const PickLocationPage();
                                      },
                                    ),
                                  );
                                  print(pickedLocationLatLngForCenter);
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
                                    pickedLocationLatLngForCenter =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const PickLocationPage();
                                        },
                                      ),
                                    );
                                    print(pickedLocationLatLngForCenter);
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
                                          'latitude: ${pickedLocationLatLngForCenter!.latitude.toStringAsFixed(
                                            4,
                                          )}',
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'longitude: ${pickedLocationLatLngForCenter!.longitude.toStringAsFixed(
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
                            print(pickedLocationLatLngForCenter);
                            print(
                              CreateOrUpdateCenterModel(
                                name: centerName.text,
                                description: centerDescription.text,
                                phoneNumber: centerPhone.text,
                                status: selectedCenterStatus,
                                latitude: pickedLocationLatLngForCenter!
                                    .latitude
                                    .toString(),
                                longitude: pickedLocationLatLngForCenter!
                                    .latitude
                                    .toString(),
                                nameAddress: centerAddressdetails.text,
                              ),
                            );
                            outerContext.read<CenterBloc>().add(
                                  CreateCenter(
                                    createCenterModel:
                                        CreateOrUpdateCenterModel(
                                      name: centerName.text,
                                      description: centerDescription.text,
                                      phoneNumber: centerPhone.text,
                                      status: selectedCenterStatus,
                                      latitude: pickedLocationLatLngForCenter!
                                          .latitude
                                          .toString(),
                                      longitude: pickedLocationLatLngForCenter!
                                          .latitude
                                          .toString(),
                                      nameAddress: centerAddressdetails.text,
                                    ),
                                  ),
                                );
                            Navigator.pop(context);
                            pickedLocationLatLngForCenter = const LatLng(0, 0);
                          },
                          title: 'Add Center',
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
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'ID',
      field: 'ID',
      type: PlutoColumnType.text(),
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
        type: PlutoColumnType.text()),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Phone Number',
      field: 'Phone Number',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Center Address',
      field: 'Center Address',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Status',
      field: 'Status',
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
                                      'Center Name',
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
                                  controller: centerName,
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
                                      'Center Description',
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
                                  controller: centerDescription,
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
                                      'Center Phone',
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
                                  controller: centerPhone,
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
                                  controller: centerAddressdetails,
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    hintText: rendererContext.row.cells.values
                                        .elementAt(4)
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
                                    const Text(
                                      'Choose Status',
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
                                        padding:
                                            const EdgeInsets.only(left: 10),
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
                                        value: selectedCenterStatus,
                                        items: List.generate(
                                            centerStatus.length, (index) {
                                          return DropdownMenuItem<String>(
                                            value: centerStatus[index]['value'],
                                            child: Text(
                                              centerStatus[index]['label'],
                                            ),
                                          );
                                        }),
                                        onChanged: (newCenterStatus) {
                                          print(newCenterStatus);
                                          setState(() {
                                            selectedCenterStatus =
                                                newCenterStatus!;
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
                                      pickedLocationLatLngForCenter ==
                                              const LatLng(0, 0)
                                          ? 'Pick Location'
                                          : 'Picked Location',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff353438),
                                      ),
                                    ),
                                    pickedLocationLatLngForCenter ==
                                            const LatLng(0, 0)
                                        ? IconButton(
                                            color: primaryColor,
                                            onPressed: () async {
                                              pickedLocationLatLngForCenter =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return const PickLocationPage();
                                                  },
                                                ),
                                              );
                                              print(
                                                  pickedLocationLatLngForCenter);
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
                                                pickedLocationLatLngForCenter =
                                                    await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return const PickLocationPage();
                                                    },
                                                  ),
                                                );
                                                print(
                                                    pickedLocationLatLngForCenter);
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
                                                      'latitude: ${pickedLocationLatLngForCenter!.latitude.toStringAsFixed(
                                                        4,
                                                      )}',
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'longitude: ${pickedLocationLatLngForCenter!.longitude.toStringAsFixed(
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
                                        outerContext.read<CenterBloc>().add(
                                              UpdateCenter(
                                                updateCenterId: rendererContext
                                                    .row
                                                    .cells
                                                    .values
                                                    .first
                                                    .value
                                                    .toString(),
                                                updateCenterModel:
                                                    CreateOrUpdateCenterModel(
                                                  name: centerName.text.isEmpty
                                                      ? rendererContext
                                                          .row.cells.values
                                                          .elementAt(1)
                                                          .value
                                                      : centerName.text,
                                                  description: centerDescription
                                                          .text.isEmpty
                                                      ? rendererContext
                                                          .row.cells.values
                                                          .elementAt(2)
                                                          .value
                                                      : centerDescription.text,
                                                  phoneNumber:
                                                      centerPhone.text.isEmpty
                                                          ? rendererContext
                                                              .row.cells.values
                                                              .elementAt(3)
                                                              .value
                                                          : centerPhone.text,
                                                  status: selectedCenterStatus,
                                                  latitude:
                                                      pickedLocationLatLngForCenter!
                                                          .latitude
                                                          .toString(),
                                                  longitude:
                                                      pickedLocationLatLngForCenter!
                                                          .longitude
                                                          .toString(),
                                                  nameAddress:
                                                      centerAddressdetails
                                                              .text.isEmpty
                                                          ? rendererContext
                                                              .row.cells.values
                                                              .elementAt(4)
                                                              .value
                                                          : centerAddressdetails
                                                              .text,
                                                ),
                                              ),
                                            );
                                        Navigator.pop(context);
                                        pickedLocationLatLngForCenter =
                                            const LatLng(0, 0);
                                      },
                                      title: 'Update Center',
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
                                    'Are you sure you want to delete this center?',
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
                                      outerContext.read<CenterBloc>().add(
                                            DeleteCenter(
                                              deleteCenterId: rendererContext
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

List<PlutoRow> _buildRows(List<CenterModel> centers) {
  return centers.map((center) {
    pickedLocationLatLngForCenter =
        LatLng(double.parse(center.latitude!), double.parse(center.longitude!));
    return PlutoRow(cells: {
      'ID': PlutoCell(value: center.id),
      'Name': PlutoCell(value: center.name),
      'Description': PlutoCell(value: center.description),
      'Phone Number': PlutoCell(value: center.phoneNumber),
      'Center Address': PlutoCell(value: center.nameAddress),
      'Status': PlutoCell(value: center.status),
      'Created At': PlutoCell(
        value: DateFormatHelper.getFormattedDate(date: center.createdAt!),
      ),
      'Actions': PlutoCell(value: center.id),
    });
  }).toList();
}


        // return Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     IconButton(
        //       color: primaryColor,
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.edit,
        //       ),
        //     ),
        //     IconButton(
        //       color: primaryColor,
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.delete,
        //       ),
        //     ),
        //   ],
        // );