import 'package:flutter/material.dart';

import 'ui/icons_v1.dart';
import 'ui/icons_v2.dart';

void main() {
  runApp(const IcoMoonExampleApp());
}

class IcoMoonExampleApp extends StatelessWidget {
  const IcoMoonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IcoMoon Generator',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff9b8cff),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff11121a),
        useMaterial3: true,
      ),
      home: const IcoMoonHomePage(),
    );
  }
}

class IcoMoonHomePage extends StatelessWidget {
  const IcoMoonHomePage({super.key});

  static const _v1Icons = <(String, IconData)>[
    ('home', V1Icons.home),
    ('office', V1Icons.office),
    ('pencil', V1Icons.pencil),
    ('image', V1Icons.image),
    ('camera', V1Icons.camera),
    ('music', V1Icons.music),
    ('play', V1Icons.play),
    ('film', V1Icons.film),
    ('dice', V1Icons.dice),
    ('pacman', V1Icons.pacman),
    ('spades', V1Icons.spades),
    ('connection', V1Icons.connection),
  ];

  static const _v2Icons = <(String, IconData)>[
    ('bookmark', V2Icons.bookmark),
    ('bell', V2Icons.bell),
    ('users', V2Icons.users),
    ('link', V2Icons.link),
    ('fire', V2Icons.fire),
    ('shield', V2Icons.shield),
    ('bolt', V2Icons.bolt),
    ('wrench', V2Icons.wrench),
    ('rocket', V2Icons.rocket),
    ('cloud', V2Icons.cloud),
    ('pen', V2Icons.pen),
    ('thumbs-up', V2Icons.thumbsUp),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 28),
                  _buildHero(context),
                  const SizedBox(height: 18),
                  _buildIconGallery(
                    context,
                    title: 'IcoMoon v1 · Legacy',
                    subtitle: 'icons[].properties',
                    icons: _v1Icons,
                    color: const Color(0xffee9a65),
                  ),
                  const SizedBox(height: 18),
                  _buildIconGallery(
                    context,
                    title: 'IcoMoon v2 · Current UI',
                    subtitle: 'glyphs[].extras',
                    icons: _v2Icons,
                    color: const Color(0xff9b8cff),
                  ),
                  const SizedBox(height: 18),
                  _buildWorkflow(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final brand = Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffa493ff), Color(0xff6c5ce7)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'IC',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'icomoon_generator',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Flutter example',
                    style: TextStyle(color: Color(0xffa1a2b3), fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        );
        final status = const Chip(
          label: Text('UI v2 ready'),
          side: BorderSide.none,
          backgroundColor: Color(0xff1c2c29),
        );

        if (constraints.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [brand, const SizedBox(height: 12), status],
          );
        }

        return Row(
          children: [Expanded(child: brand), const SizedBox(width: 12), status],
        );
      },
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff29244a), Color(0xff191a29)],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xff40386a)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 24,
        children: [
          const SizedBox(
            width: 560,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Build your icon language.',
                  style: TextStyle(
                    fontSize: 34,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Compare both IcoMoon export formats in one Flutter app. '
                  'Each version uses its own JSON, font asset, and generated '
                  'typed icon class.',
                  style: TextStyle(
                    color: Color(0xffc2bfd7),
                    height: 1.5,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: Color(0xff3a355d),
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            child: const Text(
              'Generated with Dart',
              style: TextStyle(
                color: Color(0xffd3cff0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconGallery(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<(String, IconData)> icons,
    required Color color,
  }) {
    return _SectionCard(
      title: title,
      subtitle: subtitle,
      trailing: Text(
        '${icons.length} icons',
        style: TextStyle(color: color),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: icons.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          mainAxisExtent: 112,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final (name, icon) = icons[index];
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xff1b1c28),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: color),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(color: Color(0xffb0b0c1)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkflow(BuildContext context) {
    return _SectionCard(
      title: 'How it works',
      child: const Row(
        children: [
          _Step(
              number: '01', title: 'Export', text: 'Copy a URL from IcoMoon.'),
          _Step(
              number: '02', title: 'Generate', text: 'Run the Dart generator.'),
          _Step(
            number: '03',
            title: 'Use',
            text: 'Import V1Icons or V2Icons in Flutter.',
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
    this.trailing,
    this.subtitle,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff171822),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xff292a39)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(
                color: Color(0xff8e8f9e),
                fontSize: 12,
              ),
            ),
          ],
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.title,
    required this.text,
  });

  final String number;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Color(0xff9b8cff),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(
              text,
              style: const TextStyle(color: Color(0xffa1a2b3), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
