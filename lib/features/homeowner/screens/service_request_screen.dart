import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';

class ServiceRequestScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final MaterialColor categoryColor;

  const ServiceRequestScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryColor,
  });

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final List<String> _photos = ['/api/placeholder/400/400'];
  String _urgency = 'Medium';
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _issueController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildPhotoUpload() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.camera, size: 20, color: Colors.amber[500]),
                  const SizedBox(width: 8),
                  const Text(
                    'Documentation',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                '${_photos.length}/4 photos',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
            children: [
              ..._photos.map((photo) => _buildPhotoItem(photo)).toList(),
              if (_photos.length < 4) _buildAddPhotoButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(String photo) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[100],
            image: DecorationImage(
              image: NetworkImage(photo),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.x,
              size: 16,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddPhotoButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.plus,
              size: 20,
              color: Colors.amber[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add photo',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.mapPin, size: 20, color: Colors.amber[500]),
              const SizedBox(width: 8),
              const Text(
                'Service Location',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '123 Main Street, Boston, MA 02108',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Default Address',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    LucideIcons.chevronRight,
                    size: 16,
                    color: Colors.amber[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencySelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.alertTriangle,
                  size: 20, color: Colors.amber[500]),
              const SizedBox(width: 8),
              const Text(
                'Urgency Level',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final level in ['Low', 'Medium', 'High'])
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: level != 'High' ? 12 : 0,
                    ),
                    child: InkWell(
                      onTap: () => setState(() => _urgency = level),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: _urgency == level
                              ? LinearGradient(
                                  colors: [
                                    Colors.amber[500]!,
                                    Colors.amber[400]!,
                                  ],
                                )
                              : null,
                          color: _urgency != level ? Colors.grey[50] : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            level,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: _urgency == level
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea({
    required String title,
    required IconData icon,
    required String placeholder,
    required TextEditingController controller,
    double height = 120,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.amber[500]),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: height,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.amber[500]!.withOpacity(0.1),
            Colors.amber[400]!.withOpacity(0.1),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.info,
            size: 20,
            color: Colors.amber[500],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pro Tip',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Detailed descriptions and clear photos help professionals provide more accurate responses',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.amber[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => context.pop(),
                                  child: const Icon(
                                    LucideIcons.chevronLeft,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 24,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber[50],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.amber[100]!),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.sparkles,
                                    size: 16,
                                    color: Colors.amber[500],
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.categoryName,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.amber[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Job Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tell us about your ${widget.categoryName.toLowerCase()} issue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildTextArea(
                        title: 'Describe Your Issue',
                        icon: LucideIcons.info,
                        placeholder:
                            'What needs to be fixed? Please be as specific as possible...',
                        controller: _issueController,
                      ),
                      const SizedBox(height: 20),
                      _buildPhotoUpload(),
                      const SizedBox(height: 20),
                      _buildLocationSelector(),
                      const SizedBox(height: 20),
                      _buildUrgencySelector(),
                      const SizedBox(height: 20),
                      _buildTextArea(
                        title: 'Additional Notes',
                        icon: LucideIcons.clock,
                        placeholder:
                            'Any special instructions or access requirements...',
                        controller: _notesController,
                        height: 80,
                      ),
                      const SizedBox(height: 20),
                      _buildInfoBox(),
                      const SizedBox(height: 100),
                    ]),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber[500]!,
                      Colors.amber[400]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber[500]!.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      context.push('/homeowner/request-service/review', extra: {
                        'categoryId': widget.categoryId,
                        'categoryName': widget.categoryName,
                        'issueDescription': _issueController.text,
                        'photos': _photos,
                        'location':
                            '123 Main Street, Boston, MA 02108', // TODO: Get from location selector
                        'urgency': _urgency,
                        'notes': _notesController.text,
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          'Continue to Review',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
