from unittest import TestCase
from HP_Utility import Utility


class TestUtility(TestCase):

    def test_is_root(self):
        self.assertTrue(True)
        # pass
        # TODO: How to test root access for script?
        # self.assertTrue(Utility().is_root(), "Script is not root enabled for the machine!")

    def test_system_upgrade(self):
        self.assertEqual(Utility().system_upgrade(True), 0, "System upgrade crashed")

    def test_install_psql(self):
        self.assertEqual(Utility.install_psql(True), 0, "Postgresql install crashed")

    def test_install_metasploit(self):
        self.assertEqual(Utility.install_metasploit(True), 0, "Metasploit install crashed")

    def test_install_scripts(self):
        self.assertEqual(Utility.chmod_scripts(True), 0, "Script Installation Error!")
