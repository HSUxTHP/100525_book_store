import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/data/models/book_model.dart';
import '../app/data/controllers/cart_controller.dart';
import '../app/routes/app_pages.dart';

class ProductCart extends StatelessWidget {
  final Book book;
  final CartController cartController = Get.find<CartController>();

  ProductCart({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    book.imageUrl[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              book.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              '\$${book.price}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            if (book.dateSell != null && book.dateSell!.isAfter(DateTime.now()))
              Text(
                'Available until: ${book.dateSell!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.4),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(Routes.DETAIL, arguments: book);
                  },
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                  label: const Text('Detail'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    BookInCart newBook = BookInCart(
                      id: book.id,
                      name: book.name,
                      price: book.price,
                      imageUrl: book.imageUrl,
                      description: book.description,
                      size: book.size,
                      inStock: book.inStock,
                      maxBuy: book.maxBuy,
                      dateSell: book.dateSell,
                      data: book.data,
                      dataNum: book.dataNum,
                    );

                    int existingQty = cartController.cartItems
                        .where((item) => item.id == newBook.id)
                        .fold(0, (sum, item) => sum + item.quantity);

                    if (existingQty >= newBook.maxBuy) {
                      Get.snackbar('Warning', 'Exceeded purchase limit for this product.',
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    if (existingQty >= newBook.inStock) {
                      Get.snackbar('Warning', 'Not enough stock', snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    cartController.addToCart(context, newBook);

                    if (book.dateSell!.isBefore(DateTime.now())) {
                      Get.snackbar('Success', '${book.name} has been added to cart!',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  label: const Text('Add to cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
