import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Input extends StatefulWidget {
  var texto = "";
  var controller = TextEditingController();
  Function func;

  Input({this.texto, this.controller, this.func});

  @override
  _InputState createState() => _InputState();
}

String resultado;

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    var alcoolController = MoneyMaskedTextController();
    var gasolinaController = MoneyMaskedTextController();

    return Row(
      children: [
        Container(
          width: 100,
          alignment: Alignment.center,
          child: Text(
            widget.texto,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            onTap: widget.func,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
            controller: widget.controller,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 35,
            ),
          ),
        )
      ],
    );
  }
}
