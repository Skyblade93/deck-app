import 'dartmath';
import 'packagefluttermaterial.dart';

class FlipCard extends StatefulWidget {
  final Widget front;

  const FlipCard({super.key, required this.front});

  @override
  StateFlipCard createState() = _FlipCardState();
}

class _FlipCardState extends StateFlipCard
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync this,
      duration const Duration(milliseconds 600),
    );
  }

  void flip() {
    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }
    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap flip,
      child AnimatedBuilder(
        animation controller,
        builder (context, child) {
          final angle = controller.value  pi;

          return Transform(
            alignment Alignment.center,
            transform Matrix4.rotationY(angle),
            child widget.front,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}