import '../core/helper/date_format_helper.dart';
import '../models/device_value_model.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/device_values_bloc/device_values_bloc.dart';

class DeviceValuesPage extends StatelessWidget {
  const DeviceValuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeviceValuesBloc()..add(FetchDeviceValues()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Device Values',
          ),
        ),
        body: BlocBuilder<DeviceValuesBloc, DeviceValuesState>(
          builder: (context, state) {
            if (state is DeviceValuesLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is DeviceValuesSuccess) {
              return PlutoGrid(
                columns: _buildColumns(),
                rows: _buildRows(state.deviceValues),
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
            } else if (state is DeviceValuesError) {
              return ErrorMessageWidget(
                errorMessage: state.errorMessage,
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

List<PlutoColumn> _buildColumns() {
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
      title: 'Device Name',
      field: 'Device Name',
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
      title: 'Temperature',
      field: 'Temperature',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Humidity',
      field: 'Humidity',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Gas',
      field: 'Gas',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Read Time',
      field: 'Read Time',
      type: PlutoColumnType.text(),
    ),
  ];
}

List<PlutoRow> _buildRows(List<DeviceValueModel> deviceValues) {
  return deviceValues.map((deviceValue) {
    return PlutoRow(
      cells: {
        'ID': PlutoCell(value: deviceValue.id),
        'Device Name': PlutoCell(value: deviceValue.device!.name),
        'Status': PlutoCell(value: deviceValue.status),
        'Temperature': PlutoCell(value: deviceValue.valueHeat),
        'Humidity': PlutoCell(value: deviceValue.valueMoisture),
        'Gas': PlutoCell(value: deviceValue.valueGas),
        'Read Time': PlutoCell(
          value: DateFormatHelper.getFormattedDate(date: deviceValue.date!),
        ),
      },
    );
  }).toList();
}
