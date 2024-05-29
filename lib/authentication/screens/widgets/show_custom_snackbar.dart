import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/_core/kangoolist_routes.dart';

showCustomSnackBar({
  required BuildContext context,
  required String message,
  bool isError = true,
  bool showContinue = false,
}) {
  SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: (isError) ? Colors.red : Colors.green,
    action: showContinue
        ? SnackBarAction(
            label: "Tela Inicial",
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushReplacementNamed(context, KangooListRoutes.home);
            },
          )
        : null,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
