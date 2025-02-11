import 'package:flutter/material.dart';
import 'package:voltzy_version_3/shared/widgets/app_bar.dart';
import 'package:voltzy_version_3/shared/widgets/buttons.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({super.key});

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltzyAppBar(
        title: 'Request Service',
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 3) {
                setState(() {
                  _currentStep++;
                });
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep--;
                });
              }
            },
            steps: [
              _buildServiceTypeStep(),
              _buildLocationStep(),
              _buildDetailsStep(),
              _buildScheduleStep(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Step _buildServiceTypeStep() {
    return Step(
      title: const Text('Service Type'),
      content: Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Select Service Category',
            ),
            items: const [], // TODO: Add service categories
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a service category';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Select Specific Service',
            ),
            items: const [], // TODO: Add specific services
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a specific service';
              }
              return null;
            },
          ),
        ],
      ),
      isActive: _currentStep >= 0,
    );
  }

  Step _buildLocationStep() {
    return Step(
      title: const Text('Location'),
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Address',
              prefixIcon: Icon(Icons.location_on),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Map will be displayed here'),
              ),
            ),
          ),
        ],
      ),
      isActive: _currentStep >= 1,
    );
  }

  Step _buildDetailsStep() {
    return Step(
      title: const Text('Details'),
      content: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description of the Issue',
              hintText: 'Please describe the problem in detail',
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe the issue';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Urgency Level',
            ),
            items: const [
              DropdownMenuItem(value: 'low', child: Text('Low')),
              DropdownMenuItem(value: 'medium', child: Text('Medium')),
              DropdownMenuItem(value: 'high', child: Text('High')),
              DropdownMenuItem(value: 'emergency', child: Text('Emergency')),
            ],
            onChanged: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select urgency level';
              }
              return null;
            },
          ),
        ],
      ),
      isActive: _currentStep >= 2,
    );
  }

  Step _buildScheduleStep() {
    return Step(
      title: const Text('Schedule'),
      content: Column(
        children: [
          ListTile(
            title: const Text('As Soon as Possible'),
            leading: Radio<bool>(
              value: true,
              groupValue: true, // TODO: Replace with actual state
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: const Text('Schedule for Later'),
            leading: Radio<bool>(
              value: false,
              groupValue: true, // TODO: Replace with actual state
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Preferred Date and Time',
              prefixIcon: Icon(Icons.calendar_today),
            ),
            enabled:
                false, // TODO: Enable when "Schedule for Later" is selected
            onTap: () {
              // TODO: Show date/time picker
            },
          ),
        ],
      ),
      isActive: _currentStep >= 3,
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: PrimaryButton(
          label: _currentStep == 3 ? 'Submit Request' : 'Continue',
          onPressed: () {
            if (_currentStep == 3) {
              if (_formKey.currentState?.validate() ?? false) {
                // TODO: Submit service request
              }
            } else {
              setState(() {
                _currentStep++;
              });
            }
          },
        ),
      ),
    );
  }
}
