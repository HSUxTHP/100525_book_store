import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../../data/models/book_model.dart';
import '../../../data/providers/cart_controller.dart';
import '../../../routes/app_pages.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int currentIndex = 0;
  late final Book book;

  @override
  void initState() {
    super.initState();
    book = Get.arguments as Book;
  }

  @override
  Widget build(BuildContext context) {
    // final book = widget.book;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text('Detail Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Center(
          child: SizedBox(
            width: 1400,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          book.imageUrl[currentIndex],
                          height: 550,
                          width: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // IconButton(
                          //   icon: const Icon(Icons.arrow_back),
                          //   onPressed: () {
                          //     if (currentIndex > 0) {
                          //       setState(() {
                          //         currentIndex--;
                          //       });
                          //     }
                          //   },
                          // ),
                          // const SizedBox(width: 16),
                          // IconButton(
                          //   icon: const Icon(Icons.arrow_forward),
                          //   onPressed: () {
                          //     if (currentIndex < book.imageUrl.length - 1) {
                          //       setState(() {
                          //         currentIndex++;
                          //       });
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(book.imageUrl.length, (
                            index,
                          ) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        currentIndex == index
                                            ? Colors.teal
                                            : Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    book.imageUrl[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'ID: ${book.id}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
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
                    Container(
                      width: 700,
                      child: Text(
                        book.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Size: ${book.size}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      'In Stock: ${book.inStock}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Max Buy: ${book.maxBuy}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Date Sell: ${book.dateSell!.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
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

                            final cartController = Get.find<CartController>();

                            // Kiểm tra số lượng đã có trong giỏ hàng
                            int existingQty = cartController.cartItems
                                .where((item) => item.id == newBook.id)
                                .fold(0, (sum, item) => sum + item.quantity);

                            // Kiểm tra vượt quá giới hạn maxBuy
                            if (existingQty >= newBook.maxBuy) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Exceeded purchase limit for this product.',
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }

                            // Kiểm tra nếu tồn kho không đủ
                            if (existingQty >= newBook.inStock) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Not enough stock in stock.'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              return;
                            }

                            // Kiểm tra ngày bán của sản phẩm
                            if (book.dateSell!.isBefore(DateTime.now())) {
                              print("Add to cart: ${newBook.name}");
                              cartController.addToCart(context, newBook);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${book.name} added to cart!'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Item cannot be added because the dateSell is less than today.',
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text("Add to Cart"),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (!(book.dateSell!.isBefore(DateTime.now()))) {
                              print(
                                'Item cannot be added because the dateSell is less than today.',
                              );
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                        'Item cannot be added because the dateSell is less than today.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                              );
                            } else {
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
                              final cartController = Get.find<CartController>();
                              print("Add to cart: ${newBook.name}");
                              await cartController.addToCart(context, newBook);
                              print("Buy now: ${book.name}");
                              Navigator.pop(context);
                              Get.toNamed(Routes.CART, arguments: book);
                            }
                          },
                          icon: const Icon(Icons.shopping_cart),
                          label: const Text("Buy now"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
