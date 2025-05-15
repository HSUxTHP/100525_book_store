import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/book_model.dart';

class CartController extends GetxController {
  final cartItems = <BookInCart>[].obs;
  final booksInUser = <BookInCart>[].obs;
  final selectedItemIds = <String>{}.obs;

  bool get isMultiSelecting => selectedItemIds.isNotEmpty;

  int get totalItems => cartItems.length;
  double get totalPrice => cartItems.fold(0, (total, item) => total + item.price * item.quantity);
  int get totalQuantity => cartItems.fold(0, (total, item) => total + item.quantity);

  Future<void> addToCart(BuildContext context, BookInCart item) async {
    bool? isEBook = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select version'),
        content: const Text('Which version do you want to buy??'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Ebook')),
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Hard books')),
        ],
      ),
    );

    if (isEBook == null) return;
    item.isEBook = isEBook;

    if (item.isEBook && booksInUser.any((b) => b.id == item.id && b.isEBook)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Notification'),
          content: const Text('This eBook is already in your library.'),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
        ),
      );
      return;
    }

    int index = cartItems.indexWhere((b) => b.id == item.id && b.isEBook == isEBook);
    if (index != -1) {
      final currentItem = cartItems[index];
      if (currentItem.isEBook) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Notification'),
            content: const Text('Ebook can only be purchased 1 copy.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      } else if (currentItem.quantity < item.maxBuy && currentItem.quantity < item.inStock) {
        currentItem.quantity++;
        cartItems.refresh();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Notification'),
            content: const Text('Maximum purchase limit reached or out of stock.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      }
    } else {
      if (item.dateSell.isBefore(DateTime.now())) {
        if (item.inStock > 0 && item.maxBuy > 0) {
          cartItems.add(item);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Notification'),
              content: const Text('Cannot add to cart because out of stock or purchase limit exceeded.'),
              actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Cannot add because the sale date has not come yet.'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      }
    }
  }

  void decreaseItem(BookInCart item) {
    int index = cartItems.indexWhere((b) => b.id == item.id && b.isEBook == item.isEBook);
    if (index != -1 && !cartItems[index].isEBook) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      cartItems.refresh();
    }
  }

  void updateQuantity(BuildContext context, BookInCart item, int newQuantity) {
    int index = cartItems.indexWhere((b) => b.id == item.id && b.isEBook == item.isEBook);
    if (index != -1 && !item.isEBook) {
      int maxAllowed = item.maxBuy < item.inStock ? item.maxBuy : item.inStock;
      String warning = '';

      if (newQuantity > item.maxBuy && newQuantity > item.inStock) {
        warning = 'The quantity exceeds both purchase limit and inventory.';
      } else if (newQuantity > item.maxBuy) {
        warning = 'The quantity exceeds the purchase limit.';
      } else if (newQuantity > item.inStock) {
        warning = 'The quantity exceeds the inventory.';
      }

      if (warning.isNotEmpty) {
        newQuantity = maxAllowed;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Warning'),
            content: Text('$warning\nAdjusted to: $maxAllowed'),
            actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
          ),
        );
      }

      if (newQuantity < 1) newQuantity = 1;

      cartItems[index].quantity = newQuantity;
      cartItems.refresh();
    }
  }

  void removeItem(BookInCart item) {
    cartItems.removeWhere((b) => b.id == item.id && b.isEBook == item.isEBook);
    selectedItemIds.remove(item.id);
  }

  void clearCart() {
    cartItems.clear();
    selectedItemIds.clear();
  }

  void toggleSelectItem(String id) {
    if (selectedItemIds.contains(id)) {
      selectedItemIds.remove(id);
    } else {
      selectedItemIds.add(id);
    }
  }

  void clearSelectedItems() {
    selectedItemIds.clear();
  }

  void deleteSelectedItems() {
    cartItems.removeWhere((item) => selectedItemIds.contains(item.id));
    selectedItemIds.clear();
  }

  bool isItemSelected(String id) => selectedItemIds.contains(id);

  void checkOut(BuildContext context) {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No items in cart to checkout.')),
      );
      return;
    }

    for (var item in cartItems) {
      if (!booksInUser.any((b) => b.id == item.id && b.isEBook == item.isEBook)) {
        booksInUser.add(item);
      }
    }

    cartItems.clear();
    selectedItemIds.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Checkout successful!')),
    );
  }
}
