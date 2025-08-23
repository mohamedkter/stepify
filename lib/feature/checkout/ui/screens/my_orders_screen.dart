import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stepify/feature/checkout/ui/cubit/my_orders_cubit.dart';
import 'package:stepify/feature/checkout/ui/cubit/my_orders_state.dart';
import 'order_details_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrdersCubit>().start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
        builder: (context, state) {
          if (state is MyOrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MyOrdersError) {
            return Center(child: Text(state.message));
          }
          if (state is MyOrdersLoaded) {
            if (state.orders.isEmpty) {
              return const Center(child: Text("No orders yet."));
            }
            return RefreshIndicator(
              onRefresh: () => context.read<MyOrdersCubit>().refresh(),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemCount: state.orders.length,
                itemBuilder: (context, i) {
                  final o = state.orders[i];
                  final date = DateFormat.yMMMd().add_jm().format(o.createdAt);

                  // first item preview
                  final preview = o.items.isNotEmpty ? o.items.first : null;

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => OrderDetailsScreen(order: o),
                      ));
                    },
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                preview?.imageUrl ?? "",
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 54,
                                  height: 54,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("#${o.id}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${o.items.length} item(s) • \$${o.totalPrice.toStringAsFixed(2)}",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(date,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            _StatusChip(status: o.status),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  Color _colorFor(String s) {
    switch (s.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "shipped":
        return Colors.blue;
      case "delivered":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(status),
      backgroundColor: _colorFor(status).withOpacity(.12),
      labelStyle: TextStyle(color: _colorFor(status)),
      padding: const EdgeInsets.symmetric(horizontal: 6),
    );
  }
}
