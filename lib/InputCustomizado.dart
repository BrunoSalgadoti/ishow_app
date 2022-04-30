import 'package:flutter/material.dart';

class InputCustomizado extends StatelessWidget {

  final String? hint;
  final bool obscure;
  final Icon? icon;
  final String? labelText;

  InputCustomizado(
      {@required this.hint,
        this.labelText,
        this.obscure = false,
        this.icon = const Icon(Icons.person)
      }
      );

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),

      child: TextField(
        obscureText: obscure,
        decoration: InputDecoration(
            icon: icon,
            border: InputBorder.none,
            hintText: hint,
            labelText: labelText,
            hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 18
            )
        ),
      ),

    );
  }
}
