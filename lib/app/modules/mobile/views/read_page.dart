import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/models/book_model.dart';

class ReadPage extends StatelessWidget {
  const ReadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Book book = Get.arguments as Book;
    return Scaffold(
      appBar: AppBar(title: Text(book.name), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị thông tin của Book
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${book.price}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Size: ${book.size}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(book.description, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const Divider(),

            // Display images from the book.data folder
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Images:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(book.dataNum, (index) {
                      final assetPath = '${book.data}/${index + 1}.jpg';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.asset(
                          assetPath,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
