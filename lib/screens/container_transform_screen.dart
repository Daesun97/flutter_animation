import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerTransformScreen extends StatefulWidget {
  const ContainerTransformScreen({super.key});

  @override
  State<ContainerTransformScreen> createState() =>
      _ContainerTransformScreenState();
}

class _ContainerTransformScreenState extends State<ContainerTransformScreen> {
  bool _isGrid = false;

  void _toggleGrid() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Transform'),
        actions: [
          IconButton(onPressed: _toggleGrid, icon: const Icon(Icons.grid_4x4))
        ],
      ),
      body: _isGrid
          ? GridView.builder(
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1 / 1.5,
                  crossAxisCount: 3),
              itemBuilder: (context, index) => OpenContainer(
                  closedBuilder: (context, action) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 200,
                            width: 130,
                            child: Image.asset(
                                fit: BoxFit.cover,
                                "assets/coffee/beens/${(index % 4) + 1}.jpg"),
                          ),
                          const Text(
                            '커피콩',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                  openBuilder: (context, action) =>
                      DetailScreen(image: (index % 4) + 1)),
            )
          : ListView.separated(
              itemBuilder: (context, index) => OpenContainer(
                    transitionDuration: const Duration(seconds: 2),
                    openBuilder: (context, action) =>
                        DetailScreen(image: (index % 4) + 1),
                    closedBuilder: (context, action) => ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/coffee/bg_blur/${(index % 4) + 1}.jpg'),
                          ),
                        ),
                      ),
                      title: const Text('노래 제목'),
                      subtitle: const Text('작곡가'),
                      trailing: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
              itemCount: 15),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int image;
  const DetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Column(
        children: [Image.asset("assets/coffee/beens/$image.jpg")],
      ),
    );
  }
}
