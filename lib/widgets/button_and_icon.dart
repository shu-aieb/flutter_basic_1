import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonAndIcon extends StatefulWidget {
  const ButtonAndIcon({super.key});

  @override
  State<ButtonAndIcon> createState() => _ButtonAndIconState();
}

class _ButtonAndIconState extends State<ButtonAndIcon> {
  TextEditingController _textEditingController = TextEditingController();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        title: Text(
          'Button & Icon Example',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'DeliusSwash',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade600,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.woman_2, size: 100, color: Colors.red),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onEditingComplete: () {
                    setState(() {
                      // text = _textEditingController.text;
                    });
                  },
                ),
              ),
              Text(
                _textEditingController.text,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontFamily: 'DeliusSwash',
                  fontWeight: FontWeight.bold,
                ),
              ),
              // FilledButton.icon(
              //   onPressed: () {
              //     _showToast('Filled Button Pressed');
              //   },
              //   style: ButtonStyle(
              //     backgroundColor: WidgetStateProperty.all(Colors.red.shade600),
              //   ),
              //   label: Text('Filled Button'),
              //   icon: Icon(Icons.save),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     _showSnakbar(context, 'Elevated Button Pressed');
              //   },
              //   child: Text('Elevated Button'),
              // ),
              // OutlinedButton.icon(
              //   onPressed: () {},
              //   icon: Icon(Icons.shopping_bag),
              //   label: Text('Outlined Button'),
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.red.shade600,
        child: Icon(Icons.alarm, color: Colors.white),
      ),
    );
  }
}

void _showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void _showSnakbar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
