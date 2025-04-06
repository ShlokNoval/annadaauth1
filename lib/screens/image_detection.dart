import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageDetectionPage extends StatefulWidget {
  const ImageDetectionPage({super.key});

  @override
  State<ImageDetectionPage> createState() => _ImageDetectionPageState();
}

class _ImageDetectionPageState extends State<ImageDetectionPage> {
  File? _image;
  final TextEditingController _cropController = TextEditingController();
  String? _resultText;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _resultText = null; // Reset result when new image is picked
      });
    }
  }

  void _analyzeCrop() {
    setState(() {
      _resultText =
      'Analyzing "${_cropController.text}"...\nSample result: The crop shows signs of pest damage.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Image Detection")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : const Center(
                      child: Icon(Icons.add, size: 50, color: Colors.grey),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.upload_file),
                      label: const Text("Upload Image"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Take Photo"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _cropController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter crop type',
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _image != null && _cropController.text.isNotEmpty
                      ? _analyzeCrop
                      : null,
                  child: const Text("Upload & Analyze"),
                ),

                const SizedBox(height: 20),

                if (_resultText != null)
                  Text(
                    _resultText!,
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
            ),
        );
    }
}