from unittest import TestCase
from HP_Utility import Utility


class TestUtility(TestCase):

    def test_is_root(self):
        self.assertFalse(Utility().is_root(), "Script is not root enabled for the machine!")

    def test_system_upgrade(self):
        self.assertEqual(Utility().system_upgrade(True), 0)

    def test_install_psql(self):
        self.assertEqual(Utility.install_psql(True), 0)

    def test_install_metasploit(self):
        self.assertTrue(Utility.install_metasploit(True), 0)

    def test_install_scripts(self):
        # TODO: later. Need to modify the entire script! Much of an hassle!
        pass
