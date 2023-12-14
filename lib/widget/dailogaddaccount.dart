import 'package:flutter/material.dart';

class AddAccountDialog extends StatefulWidget {
  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  Color textFieldColor = const Color.fromARGB(255, 240, 198, 198);
  Color borderColor = Colors.grey;
  OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.blue),
    borderRadius: BorderRadius.circular(8.0),
  );
  OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    focusedBorder: focusedBorder,
                    enabledBorder: defaultBorder.copyWith(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    hintText: 'ادخل تصنيف 1',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    setState(() {
                      textFieldColor = Colors.blue;
                      borderColor = Colors.blue;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    focusedBorder: focusedBorder,
                    enabledBorder: defaultBorder.copyWith(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    hintText: 'ادخل تصنيف 2',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    setState(() {
                      textFieldColor = Colors.green;
                      borderColor = Colors.green;
                    });
                  },
                ),
              ),
            ),
            ListTile(
              title: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: textFieldColor,
                    focusedBorder: focusedBorder,
                    enabledBorder: defaultBorder.copyWith(
                      borderSide: BorderSide(color: borderColor),
                    ),
                    hintText: 'ادخل تصنيف 3',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    setState(() {
                      textFieldColor = Colors.orange;
                      borderColor = Colors.orange;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                // Add logic for adding the data
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
