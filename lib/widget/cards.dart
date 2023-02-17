import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_error.dart';

class Cards extends StatelessWidget {
  final Map<String, dynamic> mapping;
  const Cards({Key? key, required this.mapping}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              mapping['urlToImage'] ?? ImageError.imgurl,
              errorBuilder: (
                BuildContext context,
                Object error,
                StackTrace? stackTrace,
              ) =>
                  Image.asset('assets/nodatafound.png'),
            ),
            const SizedBox(height: 10.0),
            Text(
              mapping['title'] ?? 'Heading not found'.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              mapping['description'] ?? 'Description not found'.toString(),
              style: const TextStyle(
                fontSize: 17.0,
              ),
            ),
            const SizedBox(height: 10.0),
            RichText(
              text: TextSpan(
                text: "Read full articles",
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    if (await canLaunch(mapping['url'])) {
                      await launch(mapping['url']);
                    } else {
                      throw 'Could not launch';
                    }
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
