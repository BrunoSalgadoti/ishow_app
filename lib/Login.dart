import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ishow_app/BotaoAnimado.dart';
import 'package:ishow_app/InputCustomizado.dart';
import 'package:flutter/scheduler.dart' show timeDilation; //Recurso para camera lenta

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300 ),
        vsync: this
    );

    _animacaoBlur = Tween<double>(
      begin: 5,
      end: 0,
    ).animate( CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease
    ));

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate( CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint
    ));

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate( CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate
    ));

    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    timeDilation = 10; // Camera lenta dos efeitos ADD import 'package:flutter/scheduler.dart'

    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [

            AnimatedBuilder(
                animation: _animacaoBlur!,
                builder: (context, widget){

                  return Container(
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("imagens/fundo.png"),
                            fit: BoxFit.fill
                        )
                    ),

                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animacaoBlur!.value,
                        sigmaY: _animacaoBlur!.value,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade!,
                                child: Image.asset("imagens/detalhe1.png"),
                              )
                          ),
                          Positioned(
                              left: 10,
                              child: FadeTransition(
                                opacity: _animacaoFade!,
                                child: Image.asset("imagens/detalhe2.png"),
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                }),

            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                children: [

                  AnimatedBuilder(
                      animation: _animacaoSize!,
                      builder: (context, widget){

                        return  Container(
                          width: _animacaoSize!.value,
                          padding:  const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),

                              boxShadow:   const [
                                BoxShadow(
                                    color: Color(0xffd1d7d6),
                                    blurRadius: 17,
                                    spreadRadius: 0
                                )
                              ]
                          ),
                          child: Column(
                            children:  [

                              InputCustomizado(
                                hint: "Email",
                                labelText: "Email",
                                icon:  const Icon(Icons.person),
                              ),

                              InputCustomizado(
                                hint: "Senha",
                                labelText: "Senha",
                                obscure: true,
                                icon:  const Icon(Icons.lock),
                              ),
                            ],
                          ),
                        );
                      }),

                  const SizedBox(height: 20,),

                  BotaoAnimado(controller: _controller),

                  const SizedBox(height: 10),

                  FadeTransition(
                    opacity: _animacaoFade!,
                    child: const Text("Esqueci minha Senha!" , style:  TextStyle(
                        color: Color.fromRGBO(255, 100, 127, 1)
                    ),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
