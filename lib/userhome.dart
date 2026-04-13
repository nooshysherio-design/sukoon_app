import 'package:flutter/material.dart';

// ── COLOR PALETTE ──────────────────────────────────────────────────────────
class SukoonColors {
  static const deep = Color(0xFF0A3D42);
  static const teal = Color(0xFF0D5C63);
  static const mid = Color(0xFF44A1A0);
  static const light = Color(0xFF78CDD7);
  static const pale = Color(0xFFD6F0F2);
  static const cream = Color(0xFFFAFAF6);
  static const text = Color(0xFF1A2E30);
  static const muted = Color(0xFF607B7D);
}

// ── HOME PAGE (Stateful) ───────────────────────────────────────────────────
class SukoonHomePage extends StatefulWidget {
  const SukoonHomePage({super.key});

  @override
  State<SukoonHomePage> createState() => _SukoonHomePageState();
}

class _SukoonHomePageState extends State<SukoonHomePage> {
  int _selectedNavIndex = 0;
  final List<String> _navLabels = ['Home', 'Therapists', 'Activities', 'About'];

  void _onNavTap(int index) => setState(() => _selectedNavIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SukoonColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _NavBar(
                selectedIndex: _selectedNavIndex,
                navLabels: _navLabels,
                onNavTap: _onNavTap,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _Carousel(),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _HeroBanner(),
                    const SizedBox(height: 24),
                    const _StatsRow(),
                    const SizedBox(height: 24),

                    // ── THERAPISTS SECTION ──────────────────────────────
                    _Section(
                      title: 'Professional Therapists',
                      subtitle: 'Matched to your unique needs and preferences',
                      viewAllLabel: 'View All',
                      cards: const [
                        _ServiceCard(
                          tag: 'One-on-One',
                          description:
                              'Connect privately with certified therapists carefully matched to your emotional needs and goals.',
                          imagePath: 'images/talking1.jpg.jpeg', // 🔁 your file
                          fallbackIcon: Icons.person_outline,
                          fallbackColor: Color(0xFF78CDD7),
                        ),
                        _ServiceCard(
                          tag: 'Safe Space',
                          description:
                              'Secure, confidential sessions built for emotional safety, personal growth, and lasting progress.',
                          imagePath: 'images/talking2.jpg.jpeg', // 🔁 your file
                          fallbackIcon: Icons.shield_outlined,
                          fallbackColor: Color(0xFF44A1A0),
                        ),
                        _ServiceCard(
                          tag: 'Flexible Access',
                          description:
                              'Attend sessions from wherever you are — seamlessly integrated into your schedule, on any device.',
                          imagePath:
                              'images/talking13.jpg.jpeg', // 🔁 your file
                          fallbackIcon: Icons.devices_outlined,
                          fallbackColor: Color(0xFF0D5C63),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── ACTIVITIES SECTION ──────────────────────────────
                    _Section(
                      title: 'Healing Activities',
                      subtitle: 'Curated by mental health professionals',
                      viewAllLabel: 'Explore All',
                      cards: const [
                        _ServiceCard(
                          tag: 'Mindfulness',
                          description:
                              'Guided mindfulness, relaxation techniques, and emotional grounding practices for daily life.',
                          imagePath:
                              'assets/images/activity1.jpg', // 🔁 your file
                          fallbackIcon: Icons.self_improvement,
                          fallbackColor: Color(0xFF78CDD7),
                        ),
                        _ServiceCard(
                          tag: 'Daily Routines',
                          description:
                              'Structured wellness routines designed to build resilience and support long-term mental well-being.',
                          imagePath:
                              'assets/images/activity2.jpg', // 🔁 your file
                          fallbackIcon: Icons.calendar_today_outlined,
                          fallbackColor: Color(0xFF44A1A0),
                        ),
                        _ServiceCard(
                          tag: 'Expert Curated',
                          description:
                              'Every activity is reviewed and curated by licensed mental health professionals for maximum benefit.',
                          imagePath:
                              'assets/images/activity3.jpg', // 🔁 your file
                          fallbackIcon: Icons.verified_outlined,
                          fallbackColor: Color(0xFF0D5C63),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
              const _FooterStrip(),
            ],
          ),
        ),
      ),
    );
  }
}

// ── NAVBAR ─────────────────────────────────────────────────────────────────
class _NavBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> navLabels;
  final ValueChanged<int> onNavTap;

  const _NavBar({
    required this.selectedIndex,
    required this.navLabels,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          const Text(
            'Sukoon',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              color: SukoonColors.deep,
            ),
          ),
          const Spacer(),
          ...List.generate(
            navLabels.length,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 24),
              child: GestureDetector(
                onTap: () => onNavTap(i),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      navLabels[i],
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: i == selectedIndex
                            ? SukoonColors.teal
                            : SukoonColors.muted,
                      ),
                    ),
                    const SizedBox(height: 3),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 2,
                      width: i == selectedIndex ? 20 : 0,
                      decoration: BoxDecoration(
                        color: SukoonColors.teal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            decoration: BoxDecoration(
              color: SukoonColors.teal,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── CAROUSEL (Stateful) ────────────────────────────────────────────────────
class _Carousel extends StatefulWidget {
  const _Carousel();

  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  int _current = 0;
  final PageController _ctrl = PageController();

  // 🔁 Replace imagePath values with your actual asset paths
  final List<Map<String, dynamic>> _slides = [
    {
      'label': 'Stop & Breathe',
      'imagePath': 'assets/images/slide1.png', // 🔁 your file
      'fallbackColor': const Color(0xFF0A3D42),
    },
    {
      'label': 'Find Your Peace',
      'imagePath': 'assets/images/slide2.jpg', // 🔁 your file
      'fallbackColor': const Color(0xFF0D5C63),
    },
    {
      'label': 'Grow Every Day',
      'imagePath': 'assets/images/slide3.jpg', // 🔁 your file
      'fallbackColor': const Color(0xFF44A1A0),
    },
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    setState(() => _current = index);
    _ctrl.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: 240,
        child: Stack(
          children: [
            // ── slides ──
            PageView.builder(
              controller: _ctrl,
              itemCount: _slides.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, i) {
                final slide = _slides[i];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      slide['imagePath'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              slide['fallbackColor'] as Color,
                              SukoonColors.mid,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    // gradient overlay so text stays readable
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.50),
                            Colors.black.withOpacity(0.10),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 38,
                      left: 28,
                      child: Text(
                        slide['label'] as String,
                        style: const TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 28,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // ── dot indicators ──
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (i) {
                  final active = i == _current;
                  return GestureDetector(
                    onTap: () => _goTo(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 22 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: active ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // ── arrows ──
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowBtn(
                  icon: Icons.chevron_left,
                  onTap: () {
                    if (_current > 0) _goTo(_current - 1);
                  },
                ),
              ),
            ),
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: _ArrowBtn(
                  icon: Icons.chevron_right,
                  onTap: () {
                    if (_current < _slides.length - 1) _goTo(_current + 1);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ArrowBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

// ── HERO BANNER (Stateful) ─────────────────────────────────────────────────
class _HeroBanner extends StatefulWidget {
  const _HeroBanner();

  @override
  State<_HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<_HeroBanner> {
  bool _btnHovered = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        child: Stack(
          children: [
            // background asset image
            Positioned.fill(
              child: Image.asset(
                'assets/images/hero_bg.jpg', // 🔁 your file
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        SukoonColors.deep,
                        SukoonColors.teal,
                        SukoonColors.mid,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            // teal gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      SukoonColors.deep.withOpacity(0.88),
                      SukoonColors.teal.withOpacity(0.75),
                      SukoonColors.mid.withOpacity(0.55),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // content
            Padding(
              padding: const EdgeInsets.all(36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // eyebrow pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: SukoonColors.light.withOpacity(0.4),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Text(
                      'MENTAL WELLNESS PLATFORM',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.6,
                        color: SukoonColors.light,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Your journey to inner\npeace begins here',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Confidential, compassionate care from certified professionals — available whenever you need support.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.white.withOpacity(0.72),
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(height: 26),
                  // animated CTA
                  MouseRegion(
                    onEnter: (_) => setState(() => _btnHovered = true),
                    onExit: (_) => setState(() => _btnHovered = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.translationValues(
                        0,
                        _btnHovered ? -2 : 0,
                        0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              _btnHovered ? 0.2 : 0.13,
                            ),
                            blurRadius: _btnHovered ? 30 : 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Get Started',
                            style: TextStyle(
                              color: SukoonColors.teal,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            color: SukoonColors.teal,
                            size: 16,
                          ),
                        ],
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

// ── STATS ROW ──────────────────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  const _StatsRow();

  static const _stats = [
    ('1,200+', 'Certified\nTherapists'),
    ('50K+', 'Sessions\nCompleted'),
    ('98%', 'Satisfaction\nRate'),
    ('24/7', 'Support\nAvailable'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_stats.length, (i) {
        final s = _stats[i];
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < _stats.length - 1 ? 12 : 0),
            padding: const EdgeInsets.symmetric(vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: SukoonColors.light.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                Text(
                  s.$1,
                  style: const TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: SukoonColors.teal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s.$2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: SukoonColors.muted,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ── SECTION ────────────────────────────────────────────────────────────────
class _Section extends StatelessWidget {
  final String title;
  final String subtitle;
  final String viewAllLabel;
  final List<_ServiceCard> cards;

  const _Section({
    required this.title,
    required this.subtitle,
    required this.viewAllLabel,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: SukoonColors.light.withOpacity(0.15)),
      ),
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: SukoonColors.deep,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: SukoonColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    viewAllLabel,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: SukoonColors.teal,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward,
                    color: SukoonColors.teal,
                    size: 13,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, i) => SizedBox(width: 220, child: cards[i]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── SERVICE CARD (Stateful) ────────────────────────────────────────────────
class _ServiceCard extends StatefulWidget {
  final String tag;
  final String description;
  final String imagePath;
  final IconData fallbackIcon;
  final Color fallbackColor;

  const _ServiceCard({
    required this.tag,
    required this.description,
    required this.imagePath,
    required this.fallbackIcon,
    required this.fallbackColor,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: SukoonColors.cream,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: SukoonColors.light.withOpacity(0.25)),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: SukoonColors.deep.withOpacity(0.11),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── image ──
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: SizedBox(
                height: 140,
                width: double.infinity,
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: widget.fallbackColor.withOpacity(0.2),
                    child: Center(
                      child: Icon(
                        widget.fallbackIcon,
                        color: widget.fallbackColor,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ── text body ──
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tag.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: SukoonColors.mid,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF444444),
                      height: 1.6,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      Text(
                        'Learn more',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: SukoonColors.teal,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        color: SukoonColors.teal,
                        size: 12,
                      ),
                    ],
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

// ── FOOTER STRIP ───────────────────────────────────────────────────────────
class _FooterStrip extends StatelessWidget {
  const _FooterStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
      decoration: BoxDecoration(
        color: SukoonColors.deep,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Text(
            '© 2025 Sukoon. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.white38),
          ),
          const Spacer(),
          Wrap(
            spacing: 20,
            children: ['About', 'Contact', 'Privacy', 'Terms']
                .map(
                  (l) => Text(
                    l,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: Colors.white38,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
