import 'package:flutter/material.dart';
import 'package:news/presentation/home/widgets/artical_card.dart';
import 'package:news/presentation/home/cubit/home_cubit.dart';
import 'package:news/presentation/home/cubit/home_state.dart';
import 'package:news/domain/usecases/get_top_headlines_usecase.dart';
import 'package:news/data/repo/domain_repo_impl.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Categories
  final List<String> categories = [
    'All',
    'Business',
    'Entertainment',
    'Health',
    'Science',
    'Sports',
    'Technology',
  ];

  // Selected category index
  int selectedIndex = 0;

  HomeCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _initCubit();
  }

  Future<void> _initCubit() async {
    final repo = await DomainRepoImpl.create();
    final usecase = GetTopHeadlinesUseCase(repo);
    setState(() {
      _cubit = HomeCubit(usecase);
    });
    _cubit!.loadHeadlines(country: 'us', category: _categoryApiValue());
  }

  @override
  void dispose() {
    _cubit?.close();
    super.dispose();
  }

  String _categoryApiValue() {
    final name = categories[selectedIndex];
    if (name == 'All') return 'general';
    return name.toLowerCase();
  }

  String _timeAgo(DateTime? dt) {
    if (dt == null) return '';
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _cubit == null
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
              : StreamBuilder<HomeState>(
                  stream: _cubit!.stream,
                  initialData: _cubit!.state,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    return RefreshIndicator(
                      color: Colors.blue,
                      onRefresh: () => _cubit!.loadHeadlines(
                        country: 'us',
                        category: _categoryApiValue(),
                      ),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Image.asset(
                                  'assets/splash.png',
                                  width: 100,
                                  height: 70,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Categories
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                itemCount: categories.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final isSelected = selectedIndex == index;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      _cubit!.loadHeadlines(
                                        country: 'us',
                                        category: _categoryApiValue(),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        categories[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 35),

                            if (state is HomeLoading) ...[
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            ] else if (state is HomeError) ...[
                              const SizedBox(height: 80),
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      state.message.isEmpty
                                          ? 'Something went wrong.'
                                          : state.message,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    ElevatedButton.icon(
                                      onPressed: () => _cubit!.loadHeadlines(
                                        country: 'us',
                                        category: _categoryApiValue(),
                                      ),
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            ] else if (state is HomeLoaded) ...[
                              if (state.articles.isEmpty) ...[
                                const SizedBox(height: 80),
                                const Center(
                                  child: Text(
                                    'No articles available.',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                for (final a in state.articles)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: ArticleCard(
                                      imageUrl: a.urlToImage ?? '',
                                      category: a.source?.name ?? '',
                                      headline: a.title ?? '',
                                      source: a.source?.name ?? '',
                                      timeAgo: _timeAgo(a.publishedAt),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          '/article-detail',
                                          arguments: a,
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ] else ...[
                              const SizedBox.shrink(),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
