import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbpath = await sql.getDatabasesPath();
    final sqldb = await sql.openDatabase(
      path.join(dbpath, 'places.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TAABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
    await sqldb.insert(
    table, 
    data, 
    conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
  }
}
