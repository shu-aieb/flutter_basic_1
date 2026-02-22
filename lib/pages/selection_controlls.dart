import 'package:flutter/material.dart';

enum DownloadQuality { low, medium, high }

class SelectionControlsPage extends StatefulWidget {
  const SelectionControlsPage({super.key});

  @override
  _SelectionControlsPageState createState() => _SelectionControlsPageState();
}

class _SelectionControlsPageState extends State<SelectionControlsPage> {
  bool _notificationsEnabled = true;
  bool _biometricsEnabled = false;

  bool _emailUpdates = true;
  bool _smsUpdates = false;
  bool _termsAccepted = false;

  DownloadQuality _selectedQuality = DownloadQuality.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Settings & Preferences"),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("System Settings (Switch)"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text("Push Notifications"),
                    subtitle: Text("Receive alerts instantly"),
                    secondary: Icon(
                      Icons.notifications_active,
                      color: Colors.blue,
                    ),
                    value: _notificationsEnabled,
                    activeColor: Colors.blue,
                    onChanged: (bool value) {
                      setState(() => _notificationsEnabled = value);
                    },
                  ),
                  Divider(height: 1),
                  SwitchListTile.adaptive(
                    title: Text("Biometric Login"),
                    subtitle: Text("Use FaceID or Fingerprint"),
                    secondary: Icon(Icons.fingerprint, color: Colors.purple),
                    value: _biometricsEnabled,
                    activeTrackColor: Colors.purpleAccent,
                    onChanged: (bool value) {
                      setState(() => _biometricsEnabled = value);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),
            _sectionHeader("Subscriptions (Checkbox)"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: Text("Email Newsletter"),
                    value: _emailUpdates,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.teal,
                    onChanged: (bool? value) {
                      setState(() => _emailUpdates = value!);
                    },
                  ),
                  CheckboxListTile(
                    title: Text("SMS Alerts"),
                    value: _smsUpdates,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.teal,
                    onChanged: (bool? value) {
                      setState(() => _smsUpdates = value!);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _termsAccepted,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onChanged: (val) =>
                              setState(() => _termsAccepted = val!),
                        ),
                        Expanded(
                          child: Text(
                            "I agree to the Terms & Privacy Policy",
                            style: TextStyle(
                              decoration: _termsAccepted
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                              color: _termsAccepted
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            _sectionHeader("Download Quality (Radio)"),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  RadioListTile<DownloadQuality>(
                    title: Text("Low Quality"),
                    subtitle: Text("Save data (128kbps)"),
                    value: DownloadQuality.low,
                    groupValue: _selectedQuality,
                    onChanged: (DownloadQuality? value) {
                      setState(() => _selectedQuality = value!);
                    },
                  ),
                  RadioListTile<DownloadQuality>(
                    title: Text("Medium Quality"),
                    subtitle: Text("Standard (256kbps)"),
                    value: DownloadQuality.medium,
                    groupValue: _selectedQuality,
                    onChanged: (DownloadQuality? value) {
                      setState(() => _selectedQuality = value!);
                    },
                  ),
                  RadioListTile<DownloadQuality>(
                    title: Text("High Quality"),
                    subtitle: Text("Best audio (320kbps)"),
                    value: DownloadQuality.high,
                    groupValue: _selectedQuality,
                    activeColor: Colors.redAccent,
                    onChanged: (DownloadQuality? value) {
                      setState(() => _selectedQuality = value!);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper for Headers
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          fontSize: 12,
        ),
      ),
    );
  }
}
