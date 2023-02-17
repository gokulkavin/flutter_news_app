import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../model/data_provider.dart';
import 'cards.dart';

class Science extends StatefulWidget {
  const Science({Key? key}) : super(key: key);

  @override
  _ScienceState createState() => _ScienceState();
}

class _ScienceState extends State<Science> {
  @override
  Widget build(BuildContext context) {
    context.read<DataProvider>().getData();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<DataProvider>().getData();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Center(
            child: Consumer<DataProvider>(
              builder: (context, values, _) {
                return values.mmap.isEmpty && !values.error
                    ? const CircularProgressIndicator()
                    : values.error
                        ? const Text("Something went wrong")
                        : ListView.builder(
                            itemCount: values.mmap['articles'].length,
                            itemBuilder: (context, index) {
                              return Cards(
                                mapping: values.mmap['articles'][index],
                              );
                            },
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
