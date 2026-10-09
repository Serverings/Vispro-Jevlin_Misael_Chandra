// =============================================================================
// game_vault_test.dart — the nine layout tests, automated, for GameVault
//
// Put this file at  test/game_vault_test.dart  and run:
//   flutter test test/game_vault_test.dart
//
// Every test sets a screen size (and sometimes a keyboard, a notch, a text
// scale or a data set), pumps the app, and fails if Flutter reports ANY layout
// error ("A RenderFlex overflowed…", "unbounded height", RangeError, …).
//
// NOTE: flutter test draws text with a test font in which every letter is a
// full square, so text is much wider than on a phone. If a test fails but the
// harness looks fine, that text has no overflow strategy (maxLines + ellipsis,
// or room to wrap).
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homework2/app.dart';
import 'package:homework2/core/features/games/data/game_data.dart';
import 'package:homework2/core/features/games/models/game.dart';
import 'package:homework2/core/features/games/presentation/screens/game_detail_screen.dart';
import 'package:homework2/core/features/games/presentation/widgets/game_card.dart';
import 'package:homework2/core/theme/app_theme.dart';

const Size small = Size(320, 568);
const Size large = Size(430, 932);
const Size tablet = Size(800, 1280);

const List<(String, Size)> screens = [
  ('small phone', small),
  ('large phone', large),
  ('tablet', tablet),
];

// ---- test data --------------------------------------------------------------

final String _long200 = List.filled(200, 'W').join(); // worst case: no spaces

final List<Game> longNameGames = [
  Game(
    title: _long200,
    genre: _long200,
    description: _long200,
    status: GameStatus.playing,
    progress: 100,
  ),
  Game(
    title: List.filled(13, 'Very long title').join(' '), // wraps at spaces
    genre: List.filled(13, 'Very long genre').join(' '),
    description: List.filled(40, 'Very long description').join(' '),
    status: GameStatus.backlog,
    progress: 0,
  ),
];

final List<Game> bigGames = List.generate(
  500,
  (i) => Game(
    title: 'Game ${i + 1}',
    genre: 'Genre ${i % 7}',
    description: 'Description ${i + 1}',
    status: GameStatus.values[i % GameStatus.values.length],
    progress: i % 101,
  ),
);

// ---- helpers ----------------------------------------------------------------

/// Sets the fake screen, pumps the app and lets every animation finish.
Future<void> pumpApp(
  WidgetTester tester,
  Size size, {
  List<Game> games = gameData,
  double keyboard = 0,
  double topInset = 0,
  double bottomInset = 0,
  double textScale = 1.0,
  ThemeMode theme = ThemeMode.light,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
  tester.view.padding = FakeViewPadding(top: topInset, bottom: bottomInset);
  tester.view.viewPadding = FakeViewPadding(top: topInset, bottom: bottomInset);
  tester.platformDispatcher.textScaleFactorTestValue = textScale;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearAllTestValues);

  await tester.pumpWidget(GameVaultApp(games: games, themeMode: theme));
  await tester.pumpAndSettle();
}

/// Pumps the detail screen on its own (it is normally reached by tapping a card).
Future<void> pumpDetail(
  WidgetTester tester,
  Size size,
  Game game, {
  ThemeMode dark = ThemeMode.light,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: dark,
      home: GameDetailScreen(game: game),
    ),
  );
  await tester.pumpAndSettle();
}

/// Fails with Flutter's own message, so you can read widget, axis and pixels.
/// If several errors happened at once, scroll up in the output to read each.
void expectNoLayoutErrors(WidgetTester tester) {
  final Object? error = tester.takeException();
  expect(error, isNull, reason: 'Layout error:\n$error');
}

/// The main vertical scroll view of the library screen.
Finder get mainScrollable => find
    .descendant(
      of: find.byType(CustomScrollView),
      matching: find.byType(Scrollable),
    )
    .first;

void main() {
  group('GameVault — the unbreakable screen', () {
    testWidgets('1 · small phone, 320 dp', (tester) async {
      await pumpApp(tester, small);
      expectNoLayoutErrors(tester);
    });

    testWidgets('2 · large phone, 430 dp', (tester) async {
      await pumpApp(tester, large);
      expectNoLayoutErrors(tester);
    });

    testWidgets('3 · tablet, 800 dp — the layout changes, it does not stretch',
        (tester) async {
      await pumpApp(tester, tablet);
      expectNoLayoutErrors(tester);

      final cards = find.byType(GameCard);
      expect(cards, findsNWidgets(gameData.length));
      expect(
        tester.getTopLeft(cards.at(0)).dy,
        tester.getTopLeft(cards.at(1)).dy,
        reason: 'At 800 dp the first two cards should sit side by side (grid).',
      );
    });

    testWidgets('3 · small phone stays a single column', (tester) async {
      await pumpApp(tester, small);
      final cards = find.byType(GameCard);
      expect(
        tester.getTopLeft(cards.at(1)).dy,
        greaterThan(tester.getTopLeft(cards.at(0)).dy),
      );
    });

    for (final (name, size) in screens) {
      testWidgets('4 · landscape — $name', (tester) async {
        await pumpApp(tester, size.flipped);
        expectNoLayoutErrors(tester);
      });
    }

    for (final (name, size) in screens) {
      testWidgets('5 · a 200-character game title — $name', (tester) async {
        await pumpApp(tester, size, games: longNameGames);
        expectNoLayoutErrors(tester);
      });
    }

    testWidgets('5 · detail screen with 200-character text — small phone',
        (tester) async {
      await pumpDetail(tester, small, longNameGames.first);
      expectNoLayoutErrors(tester);
    });

    testWidgets('5 · detail screen with long text — landscape', (tester) async {
      await pumpDetail(tester, small.flipped, longNameGames.last);
      expectNoLayoutErrors(tester);
    });

    testWidgets('6 · zero games shows an empty state', (tester) async {
      await pumpApp(tester, small, games: const <Game>[]);
      expectNoLayoutErrors(tester);
      expect(find.byKey(const Key('empty-state')), findsOneWidget);
    });

    testWidgets('6 · empty state with keyboard open in landscape',
        (tester) async {
      await pumpApp(tester, small.flipped, games: const <Game>[], keyboard: 180);
      expectNoLayoutErrors(tester);
    });

    testWidgets('7 · 500 games — built lazily, scrolled hard', (tester) async {
      await pumpApp(tester, small, games: bigGames);
      expectNoLayoutErrors(tester);
      expect(
        find.byType(GameCard).evaluate().length,
        lessThan(100),
        reason: 'Only the visible cards should be built.',
      );

      for (var i = 0; i < 5; i++) {
        await tester.fling(mainScrollable, const Offset(0, -2000), 3000);
        await tester.pumpAndSettle();
      }
      expectNoLayoutErrors(tester);
    });

    testWidgets('7 · 500 games on tablet grid', (tester) async {
      await pumpApp(tester, tablet, games: bigGames);
      expectNoLayoutErrors(tester);
      expect(find.byType(GameCard).evaluate().length, lessThan(100));
      await tester.fling(mainScrollable, const Offset(0, -3000), 3000);
      await tester.pumpAndSettle();
      expectNoLayoutErrors(tester);
    });

    testWidgets('8 · keyboard open on a short screen — content stays reachable',
        (tester) async {
      await pumpApp(tester, small, keyboard: 260);
      expectNoLayoutErrors(tester);

      final field = tester.getRect(find.byKey(const Key('search-field')));
      expect(
        field.bottom,
        lessThanOrEqualTo(small.height - 260),
        reason: 'The search field is hidden behind the keyboard.',
      );
      expect(
        tester.getRect(mainScrollable).bottom,
        lessThanOrEqualTo(small.height - 260),
        reason: 'The scrollable content should end above the keyboard.',
      );
    });

    testWidgets('8 · keyboard open in landscape', (tester) async {
      await pumpApp(tester, small.flipped, keyboard: 180);
      expectNoLayoutErrors(tester);
    });

    for (final (name, size) in screens) {
      testWidgets('9 · dark mode — $name', (tester) async {
        await pumpApp(tester, size, theme: ThemeMode.dark);
        expectNoLayoutErrors(tester);
        // Legibility is checked by eye: run the app with the system in dark mode.
      });
    }

    testWidgets('Bonus · notch and gesture bar', (tester) async {
      await pumpApp(tester, small, topInset: 32, bottomInset: 20);
      expectNoLayoutErrors(tester);

      await tester.fling(mainScrollable, const Offset(0, -1000), 3000);
      await tester.pumpAndSettle();

      final last = tester.getRect(find.byType(GameCard).last);
      expect(
        last.bottom,
        lessThanOrEqualTo(small.height - 20),
        reason: 'The last card sits under the gesture bar. '
            'Which widget keeps content out of it?',
      );
    });

    testWidgets('Bonus · text scale 2.0 — small phone', (tester) async {
      await pumpApp(tester, small, textScale: 2.0);
      expectNoLayoutErrors(tester);
    });

    testWidgets('Bonus · text scale 2.0 — tablet grid', (tester) async {
      await pumpApp(tester, tablet, textScale: 2.0);
      expectNoLayoutErrors(tester);
    });
  });

  group('GameVault — behaviour still works', () {
    testWidgets('search filters the list', (tester) async {
      await pumpApp(tester, small);
      await tester.enterText(find.byKey(const Key('search-field')), 'hades');
      await tester.pumpAndSettle();
      expect(find.byType(GameCard), findsOneWidget);
    });

    testWidgets('search with no match shows the empty state', (tester) async {
      await pumpApp(tester, small);
      await tester.enterText(find.byKey(const Key('search-field')), 'zzz');
      await tester.pumpAndSettle();
      expectNoLayoutErrors(tester);
      expect(find.byKey(const Key('empty-state')), findsOneWidget);
      expect(find.text('No games found for "zzz".'), findsOneWidget);
    });

    testWidgets('status filter filters the list', (tester) async {
      await pumpApp(tester, large);
      await tester.tap(find.byType(DropdownButtonFormField<GameStatus?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('finished'));
      await tester.pumpAndSettle();
      expectNoLayoutErrors(tester);
      expect(find.byType(GameCard), findsOneWidget); // only Hades
    });

    testWidgets('tapping a card opens the detail screen', (tester) async {
      await pumpApp(tester, small);
      await tester.tap(find.text('Hades'));
      await tester.pumpAndSettle();
      expectNoLayoutErrors(tester);
      expect(find.byType(GameDetailScreen), findsOneWidget);
    });
  });
}