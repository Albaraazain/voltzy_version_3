import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart' as active_job;
import '../../providers/job_stages/job_stage_providers.dart';

class QuoteCreationView extends ConsumerWidget {
  const QuoteCreationView({
    super.key,
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteState = ref.watch(quoteStateProvider);

    return Scaffold(
      body: SafeArea(
        child: switch (quoteState) {
          AsyncData<void>() => _buildContent(context, ref),
          AsyncLoading<void>() =>
            const Center(child: CircularProgressIndicator()),
          AsyncError<void>(error: final e) => Center(
              child: Text('Error: ${e.toString()}'),
            ),
          _ => const Center(child: Text('Unknown state')),
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DiagnosisSummary(job: job),
          const SizedBox(height: 16),
          _ServiceItemsList(),
          const SizedBox(height: 16),
          _MaterialsList(),
          const SizedBox(height: 16),
          _LaborCostField(),
          const SizedBox(height: 16),
          _AdditionalNotesField(),
          const SizedBox(height: 24),
          _QuoteSummary(),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _submitQuote(ref),
            child: const Text('Submit Quote'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitQuote(WidgetRef ref) async {
    try {
      await ref.read(quoteStateProvider.notifier).submitQuote(job);
      if (!ref.context.mounted) return;

      // Update job stage
      await ref
          .read(active_job.activeJobStageProvider.notifier)
          .updateStage(JobStage.inProgress);
    } catch (e) {
      debugPrint('Error submitting quote: $e');
    }
  }
}

class _DiagnosisSummary extends StatelessWidget {
  const _DiagnosisSummary({
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diagnosis Summary',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Issue: Water Heater Malfunction', // TODO: Get from diagnosis
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'The water heater is not maintaining temperature and shows signs of sediment buildup. Recommend thorough cleaning and possible replacement of heating elements.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItemsList extends StatelessWidget {
  const _ServiceItemsList();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Service Items',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('No service items added yet'),
          ],
        ),
      ),
    );
  }
}

class _ServiceItemTile extends StatelessWidget {
  const _ServiceItemTile({
    required this.name,
    required this.price,
    required this.isSelected,
    required this.onChanged,
  });

  final String name;
  final double price;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(name),
      subtitle: Text('\$${price.toStringAsFixed(2)}'),
      value: isSelected,
      onChanged: onChanged,
    );
  }
}

class _MaterialsList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hardcoded materials for now
    final materials = [
      {
        'name': 'Heating Element',
        'quantity': 2,
        'price': 45.0,
      },
      {
        'name': 'Anode Rod',
        'quantity': 1,
        'price': 30.0,
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Materials',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Material'),
                  onPressed: () => _showAddMaterialDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...materials.map((material) => ListTile(
                  title: Text(material['name'] as String),
                  subtitle: Text('Quantity: ${material['quantity']}'),
                  trailing: Text(
                      '\$${(material['price'] as double).toStringAsFixed(2)}'),
                )),
          ],
        ),
      ),
    );
  }

  void _showAddMaterialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Material'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Material Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Price per Unit',
                prefixText: '\$',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Implement material addition
              Navigator.pop(context);
            },
            child: const Text('Add Material'),
          ),
        ],
      ),
    );
  }
}

class _LaborCostField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Labor Cost',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Labor Cost',
                prefixText: '\$',
                helperText: 'Enter the total labor cost for this job',
              ),
              keyboardType: TextInputType.number,
              controller:
                  TextEditingController(text: '180.00'), // Hardcoded for now
            ),
          ],
        ),
      ),
    );
  }
}

class _AdditionalNotesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Notes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Add any additional notes or comments...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _QuoteSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quote Summary',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildSummaryRow(context, 'Service Items:', '\$360.00'),
            _buildSummaryRow(context, 'Materials:', '\$120.00'),
            _buildSummaryRow(context, 'Labor:', '\$180.00'),
            const Divider(),
            _buildSummaryRow(
              context,
              'Total:',
              '\$660.00',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String amount, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            amount,
            style: isTotal
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
