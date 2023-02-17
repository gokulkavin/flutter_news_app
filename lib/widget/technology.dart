import 'package:flutter/material.dart';
import '../model/data_provider.dart';
import 'package:provider/provider.dart';

import 'cards.dart';

class Technology extends StatefulWidget {
  const Technology({Key? key}) : super(key: key);

  @override
  _TechnologyState createState() => _TechnologyState();
}

class _TechnologyState extends State<Technology> {
  @override
  Widget build(BuildContext context) {
    context.read<Tech>().getData();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<Tech>().getData();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Center(
            child: Consumer<Tech>(
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
