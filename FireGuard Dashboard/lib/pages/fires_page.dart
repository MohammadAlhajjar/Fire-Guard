import 'package:dio/dio.dart';
import '../blocs/fires_bloc/fires_bloc.dart';
import '../blocs/task_fire_brigades_bloc/task_fire_brigades_bloc.dart';
import '../core/colors.dart';
import '../models/create_task_fire_model.dart';
import '../models/fire_brigade_model.dart';
import '../models/fire_model.dart';

import 'task_fire_brigades_page.dart';
import '../widgets/app_snack_bar.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../core/helper/date_format_helper.dart';
import '../main.dart';

TextEditingController taskNoteController = TextEditingController();
int selectedFireBrigadeId = 1;

class FireGridPage extends StatefulWidget {
  const FireGridPage({super.key});

  @override
  State<FireGridPage> createState() => _FireGridPageState();
}

class _FireGridPageState extends State<FireGridPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FiresBloc()
            ..add(
              FetchFiresEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => TaskFireBrigadesBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fires'),
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
          child: BlocBuilder<FiresBloc, FiresState>(
            builder: (context, state) {
              if (state is FiresLoading) {
                return const Center(
                  child: LoadingWidget(),
                );
              } else if (state is FiresSuccess) {
                if (state.fires.isEmpty) {
                  return const Center(
                    child: Text('There is no data'),
                  );
                }
                return PlutoGrid(
                  mode: PlutoGridMode.readOnly,
                  columns: _buildColumns(context),
                  rows: _buildRows(state.fires),
                  configuration: const PlutoGridConfiguration(
                    columnSize: PlutoGridColumnSizeConfig(
                      autoSizeMode: PlutoAutoSizeMode.scale,
                    ),
                    style: PlutoGridStyleConfig(
                      gridBackgroundColor: Colors.white,
                      activatedColor: Colors.white,
                      activatedBorderColor: Colors.grey,
                      gridBorderRadius: BorderRadius.zero,
                    ),
                  ),
                );
              } else if (state is FiresError) {
                return ErrorMessageWidget(errorMessage: state.errorMessage);
              }
              return const Center(
                child: LoadingWidget(),
              );
            },
          ),
        ),
      ),
    );
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
        title: 'Status',
        field: 'Status',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        title: 'Forest',
        field: 'Forest',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        enableColumnDrag: false,
        enableSorting: false,
        enableContextMenu: false,
        enableDropToResize: false,
        title: 'Last Updated',
        field: 'Last Updated',
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
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
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
                                outerContext,
                              ),
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
                                                  context
                                                      .read<
                                                          TaskFireBrigadesBloc>()
                                                      .add(
                                                        CreateNewTaskFire(
                                                          createTaskFireModel:
                                                              CreateOrUpdateTaskFireModel(
                                                            fire:
                                                                rendererContext
                                                                    .cell
                                                                    .row
                                                                    .cells
                                                                    .values
                                                                    .first
                                                                    .value
                                                                    .toString(),
                                                            //       .toString(),
                                                            fireBrigade:
                                                                selectedFireBrigadeId
                                                                    .toString(),
                                                            status: FireStatus
                                                                .ONFIRE.name,
                                                            note:
                                                                taskNoteController
                                                                    .text,
                                                          ),
                                                        ),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Add Task'),
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
                // showCreateTaskDialog(
                //   context,
                //   fireId: rendererContext.cell.row.cells.values.first.value
                //       .toString(),
                //   fireBrigadeId: '1',
                //   taskNote: 'NOTE',
                //   status: FireStatus.ONFIRE.name,
                // );
                // print(rendererContext.cell.row.cells.values.first.value);
                // context.read<TaskFireBrigadesBloc>().add(
                //       CreateNewTaskFire(
                //         createTaskFireModel: CreateTaskFireModel(
                //           fire: rendererContext.cell.row.cells.values.first.value,
                //           fireBrigade: ,
                //           status: FireStatus.ONFIRE.name,
                //           note: 'NOTE',
                //         ),
                //       ),
                //     );
              },
              child: const Text('Add Task'),
            ),
          );
        },
      ),
    ];
  }

  List<PlutoRow> _buildRows(List<FireModel> fires) {
    List<FireModel> firesOnFire = [];
    for (var fire in fires) {
      if (fire.status!.value == FireStatus.ONFIRE.name) {
        firesOnFire.add(fire);
      }
    }
    return firesOnFire.map((fireOnFire) {
      return PlutoRow(
        cells: {
          'ID': PlutoCell(value: fireOnFire.id),
          'Status': PlutoCell(value: fireOnFire.status!.label),
          'Forest': PlutoCell(value: fireOnFire.forest!.name),
          'Last Updated': PlutoCell(
            value:
                DateFormatHelper.getFormattedDate(date: fireOnFire.createdAt),
          ),
          'Details': PlutoCell(value: fireOnFire.device!.id),
        },
      );
    }).toList();
  }
}

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        side: const BorderSide(
          color: primaryColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}

// void showCreateTaskDialog(
//   BuildContext outerContext, {
//   required String fireId,
//   required String fireBrigadeId,
//   required String taskNote,
//   String? status,
// }) {
//   String slectedFireBrigadeId = '1';
//   showDialog(
//     context: outerContext,
//     builder: (dialogContext) {
//       return BlocProvider.value(
//         value: BlocProvider.of<TaskFireBrigadesBloc>(outerContext),
//         child: Dialog(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 50,
//             ),
//             child: SizedBox(
//               width: 400,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       const Text('Choose Fire Brigade'),
//                       StatefulBuilder(builder: (context, setState) {
//                         return Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                             color: primaryColor,
//                           )),
//                           child: DropdownButton<String>(
//                             value: slectedFireBrigadeId,
//                             items: const [
//                               DropdownMenuItem(
//                                 value: '1',
//                                 child: Text('Fire Brigade 1'),
//                               ),
//                               DropdownMenuItem(
//                                 value: '2',
//                                 child: Text('Fire Brigade 2'),
//                               ),
//                             ],
//                             onChanged: (fireBrigadeId) {
//                               print(fireBrigadeId);
//                               slectedFireBrigadeId = fireBrigadeId!;
//                               setState;
//                             },
//                           ),
//                         );
//                       }),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       outerContext.read<TaskFireBrigadesBloc>().add(
//                             CreateNewTaskFire(
//                               createTaskFireModel: CreateTaskFireModel(
//                                 fire: fireId,
//                                 fireBrigade: fireBrigadeId,
//                                 status: status ?? FireStatus.ONFIRE.name,
//                                 note: taskNote,
//                               ),
//                             ),
//                           );
//                     },
//                     child: const Text('Add Task'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

Future<List<FireBrigadeModel>> getFireBridgeIds() async {
  final response = await Dio().get(
    'https://firegard.cupcoding.com/backend/public/api/admin/fire-brigades',
    options: Options(
      headers: {
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}'
      },
    ),
  );

  if (response.statusCode == 200) {
    List<FireBrigadeModel> fireBrigades = List.generate(
      response.data['pagination']['items'].length,
      (index) {
        print(
          FireBrigadeModel.fromMap(
            response.data['pagination']['items'][index],
          ),
        );
        // print('================================');
        // print(response.data['pagination']['items'][index]);
        return FireBrigadeModel.fromMap(
          response.data['pagination']['items'][index],
        );
      },
    );
    // print(response.data['pagination']['items']);
    // print(fireBrigades);
    return fireBrigades;
  } else {
    return [];
  }
}
