import 'package:flutter/material.dart';

class ThemeConfig {
  static const List<GameTheme> themes = [
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF10B981), Color(0xFF059669)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF10B981), Color(0xFF059669)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF64748B), Color(0xFF475569)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
      ),
    ),
    GameTheme(
      player1Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF64748B), Color(0xFF475569)],
      ),
      player2Gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
      ),
      previewGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF64748B), Color(0xFF475569)],
      ),
    ),
  ];

  static GameTheme getTheme(int index) {
    if (index < 0 || index >= themes.length) {
      return themes[0];
    }
    return themes[index];
  }
}

class GameTheme {
  final Gradient player1Gradient;
  final Gradient player2Gradient;
  final Gradient previewGradient;

  const GameTheme({
    required this.player1Gradient,
    required this.player2Gradient,
    required this.previewGradient,
  });
}
