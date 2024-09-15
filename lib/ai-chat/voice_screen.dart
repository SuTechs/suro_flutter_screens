import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AIVoiceChatScreen(),
    );
  }
}

class AIVoiceChatScreen extends StatelessWidget {
  const AIVoiceChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff14151C),
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// appbar
              const VoiceChatAppbar(),

              /// message container
              const BotMessageContainer(),

              /// voice visualizer image
              Image.network(
                "https://i.postimg.cc/NFBtBxgw/sira-KRDESIGN-i-T-f2.png",
                fit: BoxFit.cover,
              ),

              /// question text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "How is the weather today?",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              /// bottom voice actions
              const BottomVoiceActions(),
            ],
          ),
        ),
      ),
    );
  }
}

/// appbar
class VoiceChatAppbar extends StatelessWidget {
  const VoiceChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// back button
          CircularIconButton(
            iconData: Icons.arrow_back,
            onTap: () {},
          ),

          /// title
          const Text(
            "Speaking to My bot",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "Poppins",
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          /// more option button
          CircularIconButton(
            iconData: Icons.more_vert,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

/// bot message container
class BotMessageContainer extends StatelessWidget {
  const BotMessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///
        const Flexible(
          child: Divider(
            color: Color(0xff484848),
            thickness: 1,
          ),
        ),

        ///
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  28.0,
                ),
                border: Border.all(color: const Color(0xff484848), width: 1)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "Go ahead, I'm listening",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),

        ///
        const Flexible(
          child: Divider(
            color: Color(0xff484848),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

/// bottom voice actions
class BottomVoiceActions extends StatelessWidget {
  const BottomVoiceActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// menu button
          CircularIconButton(
            iconData: Icons.menu_rounded,
            onTap: () {},
          ),

          /// voice control
          CircularIconButton(
            iconData: Icons.settings_voice_outlined,
            fillColor: const Color(0xff323437),
            iconSize: 34,
            onTap: () {},
          ),

          /// cancel button
          CircularIconButton(
            iconData: Icons.close,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

/// circular action button
class CircularIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  final Color? fillColor;
  final double iconSize;

  const CircularIconButton(
      {super.key,
      required this.iconData,
      required this.onTap,
      this.fillColor,
      this.iconSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: fillColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            size: iconSize,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
