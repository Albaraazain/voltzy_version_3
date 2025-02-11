import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String amount;
  final String time;
  final String status;
  final String type;

  const TransactionCard({
    super.key,
    required this.title,
    required this.amount,
    required this.time,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isEarning = type == 'earning';
    final iconBgColor = isEarning ? Colors.green.shade50 : Colors.amber.shade50;
    final iconColor = isEarning ? Colors.green.shade600 : Colors.amber.shade600;
    final amountColor =
        isEarning ? Colors.green.shade600 : Colors.amber.shade600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isEarning ? Icons.attach_money : Icons.shopping_bag,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isEarning ? '+' : '-'}\$$amount',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: amountColor,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
