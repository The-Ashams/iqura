"""Tests du générateur de la base de contenu (python3 -m unittest)."""

import os
import sqlite3
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(__file__))
import build_content  # noqa: E402


class BuildContentTest(unittest.TestCase):
    def test_meta(self):
        with tempfile.TemporaryDirectory() as d:
            out = os.path.join(d, "c.db")
            build_content.build(out)
            con = sqlite3.connect(out)
            meta = dict(con.execute("SELECT key, value FROM content_meta"))
            version = con.execute("PRAGMA user_version").fetchone()[0]
            con.close()
        self.assertEqual(meta["schema_version"], str(build_content.CONTENT_SCHEMA_VERSION))
        self.assertEqual(meta["content_version"], build_content.CONTENT_VERSION)
        self.assertEqual(version, build_content.CONTENT_SCHEMA_VERSION)

    def test_rebuild_replaces_file(self):
        with tempfile.TemporaryDirectory() as d:
            out = os.path.join(d, "c.db")
            build_content.build(out)
            build_content.build(out)
            self.assertEqual(sorted(os.listdir(d)), ["c.db", "c.db.version"])


if __name__ == "__main__":
    unittest.main()
