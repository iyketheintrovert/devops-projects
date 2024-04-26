import unittest
from my_code import add_numbers


class TestAddNumbers(unittest.TestCase):
    def test_add_positive_numbers(self):
        result = add_numbers(2, 3)
        self.assertEqual(result, 5)

    def test_add_negative_numbers(self):
        result = add_numbers(-2, -3)
        self.assertEqual(result, 5)

    def test_add_mixed_numbers(self):
        result = add_numbers(2, -3)
        self.assertEqual(result, -1)

    def test_add_zero(self):
        result = add_numbers(0, 5)
        self.assertEqual(result, 5)


if __name__ == "__main__":
    unittest.main()
