import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/image_controller.dart';

class ImagePage extends StatelessWidget {
  final MyImageController imageController = Get.put(MyImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker with GetX'),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 36, 80),
      body: Obx(
        () => Column(
          children: [
            ElevatedButton(
              onPressed: () {
                imageController.pickImageFromGallery();
              },
              child: const Text('Ambil Dari Galeri'),
            ),
            ElevatedButton(
              onPressed: () {
                imageController.pickImageFromCamera();
              },
              child: const Text('Ambil Dari Kamera'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: imageController.imageList.length,
                itemBuilder: (context, index) {
                  final imageItem = imageController.imageList[index];

                  return Card(
                    child: Column(
                      children: [
                        if (imageItem.path.isNotEmpty)
                          Image.file(
                            File(imageItem.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller:
                                TextEditingController(text: imageItem.title),
                            onChanged: (newTitle) {
                              imageItem.title = newTitle;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Judul Gambar'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: TextEditingController(
                                text: imageItem.description),
                            onChanged: (newDescription) {
                              imageItem.description = newDescription;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Deskripsi Gambar'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
