import 'package:book_store/app/data/providers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Set<int> selectedIndexes = {};

  bool get isSelectionMode => selectedIndexes.isNotEmpty;

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  void clearSelection() {
    setState(() {
      selectedIndexes.clear();
    });
  }

  void deleteSelected(CartController cartController) {
    final itemsToRemove = selectedIndexes.map((i) => cartController.cartItems[i]).toList();
    for (var item in itemsToRemove) {
      cartController.removeItem(item);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${itemsToRemove.length} items removed')),
    );
    clearSelection();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isSelectionMode ? '${selectedIndexes.length} selected' : 'Your Cart',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        actions: isSelectionMode
            ? [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              deleteSelected(cartController);
            },
          )
        ]
            : null,
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(
            child: Text(
              '🛒 Your cart is empty! 🛒',
              style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          );
        }

        return Center(
          child: SizedBox(
            width: 1000,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartController.cartItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      final isSelected = selectedIndexes.contains(index);

                      return GestureDetector(
                        onLongPress: () => toggleSelection(index),
                        onTap: () {
                          if (isSelectionMode) {
                            toggleSelection(index);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.deepPurple.withOpacity(0.1) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  item.imageUrl[0],
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    if (item.isEBook)
                                      const Text(
                                        'eBook',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${item.price}',
                                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove_circle_outline,
                                                  color: Colors.redAccent),
                                              onPressed: () {
                                                cartController.decreaseItem(item);
                                              },
                                            ),
                                            Text('${item.quantity}',
                                                style: const TextStyle(
                                                    fontSize: 14, color: Colors.black54)),
                                            IconButton(
                                              icon: const Icon(Icons.add_circle_outline,
                                                  color: Colors.green),
                                              onPressed: () {
                                                cartController.updateQuantity(
                                                    context, item, item.quantity + 1);
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete_outline,
                                                  color: Colors.grey),
                                              onPressed: () {
                                                cartController.removeItem(item);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content:
                                                    Text('${item.name} removed from cart'),
                                                    duration: const Duration(seconds: 2),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Text(
                          'Total price: \$${cartController.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      ElevatedButton.icon(
                        onPressed: () {
                          cartController.checkOut(context);
                        },
                        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                        label: const Text('Checkout'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
