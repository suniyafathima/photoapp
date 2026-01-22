import 'package:flutter/material.dart';
import 'package:photoapp/controller/photoprovider.dart';
import 'package:provider/provider.dart';
import '../model/fetch_photo_model.dart';

class PhotoListPage extends StatefulWidget {
  const PhotoListPage({super.key});

  @override
  State<PhotoListPage> createState() => _PhotoListPageState();
}

class _PhotoListPageState extends State<PhotoListPage> {
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<PhotoProvider>().fetchPhotos();
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Picsum Gallery',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<PhotoProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Text(
                provider.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final photos = provider.photos.reversed.toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                /// TOP IMAGE
                Image.network(
                  photos[0].downloadUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace)  => Container(
                    color: Colors.grey[300],
                    height: 200,
                    child: const Icon(Icons.broken_image, size: 60),
                  ),
                ),

            
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return _PhotoCard(photo: photos[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// BEAUTIFUL CARD WIDGET
class _PhotoCard extends StatelessWidget {
  final Fetchphotomodel photo;

  const _PhotoCard({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
    
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            /// IMAGE
            Image.network(
              photo.downloadUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 60),
              ),
            ),
      
            /// AUTHOR INFO
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: Row(
                children: [
                  /// AVATAR
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Text(
                      photo.author != null && photo.author!.isNotEmpty
                          ? photo.author![0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
      
                  /// AUTHOR NAME
                  Expanded(
                    child: Text(
                      photo.author ?? 'Unknown',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PhotoCard extends StatelessWidget {
  final Fetchphotomodel photo;

  const PhotoCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: AspectRatio(
              aspectRatio: photo.width != null && photo.height != null
                  ? photo.width! / photo.height!
                  : 16 / 9,
              child: Image.network(
                photo.downloadUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, size: 40),
                ),
              ),
            ),
          ),

          /// DETAILS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                /// AUTHOR AVATAR
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: Text(
                    photo.author != null && photo.author!.isNotEmpty
                        ? photo.author![0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                /// AUTHOR NAME
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photo.author ?? 'Unknown',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ID: ${photo.id}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
