import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {    
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size biggest = constraints.biggest;
          return Container(
            height: biggest.height,
            width: biggest.width,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                radius: 0.7,
                colors: [Color(0xFF565ABB), Color(0xFF2B2E74)]),
            ),
            child: Stack(
              children: <Widget>[
                PositionedTransition(
                    rect: RelativeRectTween(
                      begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width / 2 - 75,
                              biggest.height / 2, 150, 150),
                          biggest),
                      end: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width / 2 - 75,
                              biggest.height / 2 - 40, 150, 150),
                          biggest),
                    ).animate(CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOut,
                    )),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/logo.svg',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeTransition(
                          opacity: _animation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/dip_mart.svg',
                                color: Colors.white,
                                width: 120,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SvgPicture.asset(
                                'assets/phrase.svg',
                                color: Colors.white,
                                width: 120,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                // Positioned(
                //   top: biggest.height / 2 + 100,
                //   child: Container(
                //     width: biggest.width,
                //     height: 50,
                //     decoration: BoxDe,
                //   ),
                // )
              ],
            ),
          );
        },      
    );
  }
}
