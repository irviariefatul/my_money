import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final ImageProvider<Object> image;

  const MenuItem({
    required this.title,
    required this.image, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: image,
          height: MediaQuery.sizeOf(context).height /
              6, //Menguabah tinggi gambar sesuai kebutuhan
          width: MediaQuery.sizeOf(context).height /
              6, // Mengubah lebar gambar sesuai kebutuhan
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color:  Color(0xFF737373),
          ),
        ),
      ],
    );
  }
}
