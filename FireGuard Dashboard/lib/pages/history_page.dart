// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/task_fire_brigades_bloc/task_fire_brigades_bloc.dart';
import '../core/helper/date_format_helper.dart';
import '../models/task_fire_brigade_model.dart';
import '../widgets/app_button.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'task_fire_brigades_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: BlocBuilder<TaskFireBrigadesBloc, TaskFireBrigadesState>(
          builder: (context, state) {
            if (state is GetTaskFireBrigadesLoading) {
              return const Center(
                child: LoadingWidget(),
              );
            } else if (state is GetTaskFireBrigadesSuccess) {
              return PlutoGrid(
                mode: PlutoGridMode.readOnly,
                columns: _buildColumns(context),
                rows: _buildRows(state.tasks),
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
            } else if (state is GetTaskFireBrigadesError) {
              return ErrorMessageWidget(
                errorMessage: state.errorMessage,
              );
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
          },
        ),
      );
    });
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
      title: 'Fire Brigade',
      field: 'Fire Brigade',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Note',
      field: 'Note',
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
      title: 'Updated At',
      field: 'Updated At',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      enableColumnDrag: false,
      enableSorting: false,
      enableContextMenu: false,
      enableDropToResize: false,
      title: 'Details',
      field: 'Details',
      type: PlutoColumnType.number(),
      renderer: (rendererContext) {
        return AppButton(
          onPressed: () {},
          title: 'Deatils',
        );
      },
    ),
  ];
}

List<PlutoRow> _buildRows(List<TaskFireBrigadeModel> taskFireBrigades) {
  List<TaskFireBrigadeModel> taskFireBrigadesOnFire = [];
  for (var taskFireBrigade in taskFireBrigades) {
    if (taskFireBrigade.status! == FireStatus.COMPLETED.name ||
        taskFireBrigade.status! == FireStatus.CANCELED.name) {
      taskFireBrigadesOnFire.add(taskFireBrigade);
    }
  }
  return taskFireBrigadesOnFire.map((taskFireBrigade) {
    return PlutoRow(
      cells: {
        'ID': PlutoCell(value: taskFireBrigade.id),
        'Fire Brigade': PlutoCell(value: taskFireBrigade.fireBrigade!.name),
        'Note': PlutoCell(value: taskFireBrigade.note ?? ''),
        'Status': PlutoCell(value: taskFireBrigade.status),
        'Updated At': PlutoCell(
          value: DateFormatHelper.getFormattedDate(
            date: taskFireBrigade.updatedAt!,
          ),
        ),
        'Details': PlutoCell(),
      },
    );
  }).toList();
}
