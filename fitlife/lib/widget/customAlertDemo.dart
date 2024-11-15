import 'package:flutter/material.dart';

class CustomAlertBoxDemo {
  Future<void> showMyDialog(BuildContext context, String msg) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String? _dialogText = '';
        return AlertDialog(
          title: Text('$msg'),
          content: const SizedBox(
            width: 200, // Set the desired width
          ),

          insetPadding: const EdgeInsets.symmetric(
              horizontal: 20.0), // Adjust the inset padding
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16.0), // Adjust the border radius
          ),
          actions: [
            Center(
              child: Container(
                height: 50,
                width: 150,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: const WidgetStatePropertyAll(
                    const Color.fromRGBO(148, 171, 253, 1.0),
                  )),
                  onPressed: () {
                    Navigator.of(context).pop(_dialogText);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
