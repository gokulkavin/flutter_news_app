import 'package:flutter/material.dart';
import '../model/data_provider.dart';
import 'package:provider/provider.dart';
import 'cards.dart';

class Sports extends StatefulWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  @override
  Widget build(BuildContext context) {
    context.read<Sport>().getData();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<Sport>().getData();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Center(
            child: Consumer<Sport>(
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
