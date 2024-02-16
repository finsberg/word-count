from pathlib import Path
import sys

here = Path(__file__).parent
sys.path.append((here / ".." / "code").as_posix())

from count import count_words


def test_word_count():
    assert count_words("hello hello world") == {"hello": 2, "world": 1}
