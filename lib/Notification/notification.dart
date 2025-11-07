import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Your Appointment Confirmed!',
      'message': 'Your car wash appointment has been confirmed for tomorrow at 10:00 AM.',
      'time': '2h ago',
      'icon': Icons.check_circle,
      'color': const Color(0xFF00E676),
      'unread': true,
    },
    {
      'title': 'Service Reminder',
      'message': 'It\'s time for your routine maintenance check-up.',
      'time': '1d ago',
      'icon': Icons.build_circle,
      'color': const Color(0xFFFFB800),
      'unread': false,
    },
    {
      'title': 'Discount Offer',
      'message': 'Get 15% off your next detailing service! Offer ends this week.',
      'time': '3d ago',
      'icon': Icons.local_offer,
      'color': const Color(0xFF00B8D4),
      'unread': true,
    },
    {
      'title': 'Payment Successful',
      'message': 'Your payment for "Brake Service" has been successfully processed.',
      'time': '5d ago',
      'icon': Icons.attach_money,
      'color': const Color(0xFFAA00FF),
      'unread': false,
    },
    {
      'title': 'New Service Added',
      'message': '"Wheel Alignment" is now available at our center!',
      'time': '1w ago',
      'icon': Icons.straighten,
      'color': const Color(0xFFFF6B6B),
      'unread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Back Button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Mark all as read
                      setState(() {
                        for (var n in notifications) {
                          n['unread'] = false;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.done_all,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(notification);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isUnread = notification['unread'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2328),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread
              ? notification['color'].withOpacity(0.5)
              : notification['color'].withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            notification['unread'] = false;
          });
          _showNotificationDetails(notification);
        },
        leading: CircleAvatar(
          backgroundColor: notification['color'].withOpacity(0.15),
          radius: 28,
          child: Icon(
            notification['icon'],
            color: notification['color'],
            size: 28,
          ),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            color: Colors.white,
            fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            notification['message'],
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 13,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              notification['time'],
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
            if (isUnread)
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: notification['color'],
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Color(0xFF1E2328),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: notification['color'].withOpacity(0.15),
                    radius: 28,
                    child: Icon(
                      notification['icon'],
                      color: notification['color'],
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      notification['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                notification['message'],
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                notification['time'],
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}