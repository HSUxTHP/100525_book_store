import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/book_card.dart';
import '../../../data/providers/cart_controller.dart';
import '../../../routes/app_pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      body: Obx(() {
        final books = cartController.booksInUser;

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

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 2.135,
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];

                  if (book.isEBook) {
                    return InkWell(
                      onTap: () {
                        print("Read: ${book.name}");
                        Get.toNamed(Routes.READ, arguments: book);
                      },
                      child: BookCard(book: book),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
