import 'package:flutter/material.dart';
import 'package:stepify/feature/search/ui/screen/search_screen.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Material(
              elevation: 2,
              shadowColor: Colors.grey[300],
              borderRadius: BorderRadius.circular(14),
              child: GestureDetector(
                onTap: () {
                  print('Search bar tapped');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ));
                },
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Looking for shoes',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[400],
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
