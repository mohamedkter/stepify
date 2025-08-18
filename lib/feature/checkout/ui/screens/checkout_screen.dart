import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_cubit.dart';
import 'package:stepify/feature/cart/ui/cubit/cart_state.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';
import 'package:stepify/feature/checkout/ui/cubit/order_cubit.dart';
import 'package:stepify/feature/checkout/ui/cubit/order_state.dart';
import 'package:go_router/go_router.dart';
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "Cash on Delivery";
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderPlaced) {
          context.read<CartCubit>().clearCart();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text("Success 🎉"),
              content: const Text("Your order has been placed successfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(); // Close popup
                  ctx.go(
                      "/home",
                    );
                  },
                  child: const Text("Go to Home"),
                ),
              ],
            ),
          );
        } else if (state is OrderFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed: ${state.message}")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartUpdated) {
              final items = state.items;
              final total = state.total;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address Section
                    const Text("Delivery Address",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        hintText: "Enter your address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Payment Section
                    const Text("Payment Method",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ListTile(
                      title: const Text("Cash on Delivery"),
                      leading: Radio<String>(
                        value: "Cash on Delivery",
                        groupValue: selectedPayment,
                        onChanged: (value) {
                          setState(() => selectedPayment = value!);
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text("Credit Card (Coming Soon)"),
                      leading: Radio<String>(
                        value: "Card",
                        groupValue: selectedPayment,
                        onChanged: (value) {
                          setState(() => selectedPayment = value!);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Order Summary
                    const Text("Order Summary",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ...items.map((e) => ListTile(
                          leading: Image.network(e.imageUrl,
                              width: 40, height: 40, fit: BoxFit.cover),
                          title: Text(e.name),
                          subtitle: Text("x${e.quantity}"),
                          trailing: Text(
                              "\$${(e.price * e.quantity).toStringAsFixed(2)}"),
                        )),
                    const Divider(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text("Total: \$${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),

                    // Place Order Button
                    ElevatedButton(
                      onPressed: () {
                        final uid = FirebaseAuth.instance.currentUser!.uid;
                        final id =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        final order = OrderEntity(
                          id: id,
                          userId: uid,
                          items: items,
                          totalPrice: total,
                          status: "pending",
                          paymentMethod: selectedPayment,
                          address: addressController.text,
                          createdAt: DateTime.now(),
                        );

                        context.read<OrderCubit>().placeOrder(order);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Place Order"),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
