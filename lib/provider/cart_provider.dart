import 'package:cart_with_provider/model/cart_item.dart';
import 'package:cart_with_provider/util/custom_toast.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = <CartItem>[];
  List<CartItem> get cartItems => _cartItems;

  void addItemOrIncreaseQuantity(item) {
    bool exists = false;
    int index = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      if (item.name == _cartItems[i].product.name) {
        exists = true;
        index = i;
        break;
      }
    }

    if (exists) {
      _cartItems[index] = CartItem(
        product: item,
        quantity: _cartItems[index].quantity + 1,
      );
      showToast("Product has been added to the cart!", Colors.yellow.shade800);
      notifyListeners();
    } else {
      _cartItems.add(
        CartItem(
          quantity: 1,
          product: item,
        ),
      );
      showToast("Product has been added to the cart!", Colors.yellow.shade800);
      notifyListeners();
    }
  }

  void removeItemOrDecreaseQuantity(item) {
    int index = 0;
    for (var i = 0; i < _cartItems.length; i++) {
      if (item.name == _cartItems[i].product.name) {
        index = i;
        break;
      }
    }
    if (_cartItems[index].quantity == 1) {
      _cartItems.removeAt(index);
      notifyListeners();
    } else {
      _cartItems[index] = CartItem(
        product: item,
        quantity: _cartItems[index].quantity - 1,
      );
      notifyListeners();
    }
  }

  void clearItem(item) {
    if (_cartItems.contains(item)) {
      _cartItems.remove(item);
      showToast("Item removed from the cart!", Colors.yellow.shade800);
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int calculatePrice() {
    int result = 0;
    cartItems.forEach((element) {
      result += (element.quantity * element.product.price);
    });
    return result;
  }
}
