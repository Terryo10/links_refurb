import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_refurb/bloc/cache_bloc/cache_bloc.dart';
import 'package:link_refurb/ui/auth/welcome.dart';
import 'package:link_refurb/ui/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CacheBloc, CacheBlocState>(
      listener: (context, state) {},
      child: Scaffold(
        body: BlocBuilder<CacheBloc, CacheBlocState>(
          builder: (context, state) {
            if (state is CacheNotFoundState) {
              return WelcomePage();
            } else if (state is CacheFoundState) {
              // user is authenticated
              print('found token');
              return HomePage();
            }
            return Container(
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/links_splash_adobespark.png'))),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
