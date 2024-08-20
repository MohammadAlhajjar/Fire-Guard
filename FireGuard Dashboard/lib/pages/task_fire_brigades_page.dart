// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../blocs/task_fire_brigades_bloc/task_fire_brigades_bloc.dart';
import '../core/colors.dart';
import '../core/helper/date_format_helper.dart';
import '../models/create_task_fire_model.dart';
import '../models/task_fire_brigade_model.dart';
import '../widgets/app_button.dart';
import '../widgets/app_snack_bar.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'fires_page.dart';

enum FireStatus {
  COMPLETED,
  CANCELED,
  ONFIRE,
  INPROGRESS,
  DANGEROUS,
}

String selectedTaskFireStatus = FireStatus.ONFIRE.name;

class TaskFireBrigadePage extends StatelessWidget {
  const TaskFireBrigadePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 14),
          //     child: AppButton(
          //       onPressed: () {
          //       },
          //       title: 'Add Task',
          //     ),
          //   ),
          // ],
          title: const Text('Task Fire Brigades'),
        ),
        body: BlocListener<TaskFireBrigadesBloc, TaskFireBrigadesState>(
          listener: (context, state) {
            if (state is TaskFireActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                appSnackBar(
                  screenWidth: screenWidth,
                  title: state.actionMessage,
                  isSuccess: true,
                ),
              );
              context.read<TaskFireBrigadesBloc>().add(FetchTaskFireBrigades());
              taskNoteController.clear();
            } else if (state is TaskFireActionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                appSnackBar(
                  screenWidth: screenWidth,
                  title: 'Error . . . Please Try Again !',
                  isSuccess: false,
                ),
              );
              taskNoteController.clear();
            }
          },
          child: BlocBuilder<TaskFireBrigadesBloc, TaskFireBrigadesState>(
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
                    return FutureBuilder(
                      future: getFireBridgeIds(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Builder(builder: (context) {
                            return BlocProvider.value(
                              value: BlocProvider.of<TaskFireBrigadesBloc>(
                                  outerContext),
                              child:
                                  StatefulBuilder(builder: (context, setState) {
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
                                                'Choose Fire Brigade:',
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
                                                fontSize: 20,
                                                color: primaryColor,
                                              ),
                                              dropdownColor: Colors.white,
                                              isExpanded: true,
                                              value: selectedFireBrigadeId,
                                              items: List.generate(
                                                  snapshot.data!.length,
                                                  (index) {
                                                return DropdownMenuItem<int>(
                                                  value:
                                                      snapshot.data![index].id,
                                                  child: Text(
                                                    snapshot.data![index].name!,
                                                  ),
                                                );
                                              }),
                                              // items: const [
                                              //   DropdownMenuItem(
                                              //     value: 1,
                                              //     child: Text('Al-Qadmous Brigade'),
                                              //   ),
                                              //   DropdownMenuItem(
                                              //     value: 2,
                                              //     child: Text('Safita Fire Brigade'),
                                              //   ),
                                              // ],
                                              onChanged: (fireBrigadeId) {
                                                selectedFireBrigadeId =
                                                    fireBrigadeId!;
                                                setState(() {});
                                              },
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
                                                'Task Note',
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
                                            controller: taskNoteController,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Task Status',
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
                                                  value: selectedTaskFireStatus,
                                                  items: List.generate(
                                                      FireStatus.values.length,
                                                      (index) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: FireStatus
                                                          .values[index].name,
                                                      child: Text(
                                                        FireStatus
                                                            .values[index].name,
                                                      ),
                                                    );
                                                  }),
                                                  // items:  [
                                                  //   DropdownMenuItem(
                                                  //     child: Text('COMPLETED'),
                                                  //     value: FireStatus.COMPLETED.name,
                                                  //   ),
                                                  // ],
                                                  onChanged: (taskFireStatus) {
                                                    selectedTaskFireStatus =
                                                        taskFireStatus!;
                                                    setState(() {});
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
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: primaryColor,
                                                  foregroundColor: Colors.white,
                                                ),
                                                onPressed: () {
                                                  print(selectedFireBrigadeId);
                                                  print(
                                                      taskNoteController.text);
                                                  outerContext
                                                      .read<
                                                          TaskFireBrigadesBloc>()
                                                      .add(
                                                        UpdateTaskFire(
                                                          rendererContext
                                                              .row
                                                              .cells
                                                              .values
                                                              .first
                                                              .value
                                                              .toString(),
                                                          updateTaskFireModel:
                                                              CreateOrUpdateTaskFireModel(
                                                            fire:
                                                                rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .first
                                                                    .value
                                                                    .toString(),
                                                            fireBrigade:
                                                                selectedFireBrigadeId
                                                                    .toString(),
                                                            status:
                                                                selectedTaskFireStatus,
                                                            note: taskNoteController
                                                                    .text
                                                                    .isEmpty
                                                                ? rendererContext
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .elementAt(
                                                                        2)
                                                                    .value
                                                                : taskNoteController
                                                                    .text,
                                                          ),
                                                        ),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                    const Text('Update Task'),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              AppOutlineButton(
                                                onPressed: () {
                                                  taskNoteController.clear();
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
                              }),
                            );
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
                                    'Are you sure you want to delete this task?',
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
                                          .read<TaskFireBrigadesBloc>()
                                          .add(
                                            DeleteTaskFire(
                                              taskFireId: rendererContext
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
        // return ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: primaryColor,
        //     foregroundColor: Colors.white,
        //   ),
        //   onPressed: () {
        //     print(rendererContext.row.cells.values.first.value);
        //   },
        //   child: const Text('Fire Details'),
        // );
      },
    ),
  ];
}

List<PlutoRow> _buildRows(List<TaskFireBrigadeModel> taskFireBrigades) {
  List<TaskFireBrigadeModel> taskFireBrigadesOnFire = [];
  for (var taskFireBrigade in taskFireBrigades) {
    if (taskFireBrigade.status! == FireStatus.ONFIRE.name) {
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
        'Actions': PlutoCell(),
      },
    );
  }).toList();
}
