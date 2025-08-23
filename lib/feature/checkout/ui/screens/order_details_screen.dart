import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stepify/feature/checkout/domain/entities/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderEntity order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat.yMMMd().add_jm().format(order.createdAt);

    return Scaffold(
      appBar: AppBar(title: Text("Order #${order.id}")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Status"),
            subtitle: Text(order.status),
            trailing: Text(date, style: const TextStyle(fontSize: 12)),
          ),
          const Divider(),
          const SizedBox(height: 8),
          const Text("Items", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...order.items.map((e) => ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    e.imageUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                title: Text(e.name),
                subtitle: Text("x${e.quantity}"),
                trailing:
                    Text("\$${(e.price * e.quantity).toStringAsFixed(2)}"),
              )),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Delivery Address"),
            subtitle: Text(order.address),
          ),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Payment"),
            subtitle: Text(order.paymentMethod),
            trailing: Text(
              "\$${order.totalPrice.toStringAsFixed(2)}",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
