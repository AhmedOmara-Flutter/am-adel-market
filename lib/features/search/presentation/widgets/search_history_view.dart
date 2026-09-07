import '../../../../core/utils/app_imports.dart';

class SearchHistoryView extends StatelessWidget {
  SearchHistoryView({super.key});

  final List<String> history = ["تفاح", "تفاح", "تفاح", "تفاح"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "عمليات البحث الأخيرة",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              /// Clear All
              TextButton(
                onPressed: () {
                  // clear all logic
                },
                child: const Text(
                  "حذف الكل",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              dense: true,
              leading: InkWell(
                onTap: () {},
                child: const Icon(Icons.close, size: 18),
              ),
              title: Text(history[index], style: const TextStyle(fontSize: 14)),
              trailing: const Icon(Icons.history, size: 18, color: Colors.grey),
              onTap: () {
                // re-search item
              },
            );
          },
        ),
      ],
    );
  }
}
