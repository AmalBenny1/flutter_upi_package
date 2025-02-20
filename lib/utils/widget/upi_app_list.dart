import 'dart:io';
import 'package:flutter/material.dart';
import '../../flutter_pay_upi_manager.dart';
import '../../model/ios_upi_app.dart';
import '../../model/upi_app_model.dart';

class UPIAppList extends StatefulWidget {
  final Function(String?) onClick;

  const UPIAppList({super.key, required this.onClick});

  @override
  State<UPIAppList> createState() => _UPIAppListState();
}

class _UPIAppListState extends State<UPIAppList> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return FutureBuilder<List<UpiApp>>(
          future: FlutterPayUpiManager.getListOfAndroidUpiApps(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onClick(snapshot.data![index].app);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.memory(
                              snapshot.data![index].icon!,
                              width: 40,
                              height: 40,
                            ),
                            SizedBox(height: 10),
                            Text(
                              snapshot.data![index].name!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          });
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: iosUPIApps.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.onClick(iosUPIApps[index].appName);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      // iosUPIApps[index].appIcon!,
                      iosUPIApps[index].appIcon!,
                      width: 60,
                      height: 60, package: "flutter_pay_upi",
                    ),
                    SizedBox(height: 10),
                    Text(
                      iosUPIApps[index].appName!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
