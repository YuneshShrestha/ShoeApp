import 'package:flutter/material.dart';

Widget customBlackButton({
  required String text,
  required Function() onPressed,
}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.black,
      ),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

Widget customOutlineButton({
  required String text,
  required Function() onPressed,
}) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: Colors.black),
    ),
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(color: Colors.black),
    ),
  );
}

Widget customRowButton({
  required String text,
  required String image,
  required Function() onPressed,
}) {
  return ElevatedButton(
    
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.black,
      ),
  
    ),
    onPressed: onPressed,
    child: Row(
      children: [
        Image.asset(
          image,
          height: 20,
          width: 20,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
