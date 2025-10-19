import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starkzapp_project/data/models/user_model.dart';
import 'package:starkzapp_project/presentation/providers/user_provider.dart';

class ProfileDetailScreen extends StatelessWidget {
  final UserModel user;
  final int index;

  const ProfileDetailScreen({
    super.key,
    required this.user,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isLiked = userProvider.isLiked(index);

    return Scaffold(
      appBar: AppBar(title: Text('Profile Detail Screen',style: TextStyle(color: const Color.fromARGB(255, 200, 199, 199)),),backgroundColor: Colors.black,),
      body: Stack(
        children: [
          Hero(
            tag: 'user-image-${user.imageUrl}',
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(user.imageUrl, fit: BoxFit.cover),
            ),
          ),

          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.15, 
            minChildSize: 0.15, 
            maxChildSize: 0.3, 
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: ListView(
                  controller: scrollController,
                  children: [
                    
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName}, ${user.age}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.city,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 32,
                          ),
                          onPressed: () {
                            userProvider.toggleLike(index);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      'Additional details of the user can go here.Bio,hobbies, interests etc. can be added',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
