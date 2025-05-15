import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/book_card.dart';
import '../../../data/providers/cart_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      body: Obx(() {
        final books = cartController.booksInUser;
        AppBar(
          centerTitle: true,
          title: const Text(
            'Your Books',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.deepPurple,
        );


            if (books.isEmpty) {
              return const Center(
                child: Text(
                  '📚 No books found! 📚',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: books.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final book = books[index];

                if (book.isEBook) {
                  return InkWell(
                    onTap: () {
                      print("Read: ${book.name}");
                      Navigator.pushNamed(context, '/read', arguments: book);
                    },
                    child: BookCard(book: book),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          }),
    );
  }
}

