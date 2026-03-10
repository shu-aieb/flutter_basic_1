import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerPage extends StatelessWidget {
  const WorkManagerPage({super.key});

  static final DOWNLOADTASK = 'download_task';
  static final UPLOADTASK = 'upload_task';

  static final WM_NORMAL_WORK_ID = '23334343999';
  static final WM_REPEATING_WORK_ID = '23334343993';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Work Manager')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Workmanager().registerOneOffTask(
                          WM_NORMAL_WORK_ID,
                          DOWNLOADTASK,
                          initialDelay: Duration(seconds: 5),
                          inputData: {'url': 'https://iram.org'},
                        );
                      },
                      label: Text(
                        'Start Download',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      icon: Icon(Icons.download),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Workmanager().registerPeriodicTask(
                          WM_REPEATING_WORK_ID,
                          UPLOADTASK,
                          frequency: Duration(minutes: 1),
                          constraints: Constraints(
                            networkType: NetworkType.notRequired,
                            requiresCharging: false,
                            requiresBatteryNotLow: false,
                          ),
                        );
                      },
                      label: Text(
                        'Start Upload',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      icon: Icon(Icons.upload),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Workmanager().cancelByUniqueName(WM_NORMAL_WORK_ID);
                    Workmanager().cancelByUniqueName(WM_REPEATING_WORK_ID);
                  },
                  label: Text(
                    'Stop Download and Upload',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(Icons.upload),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
