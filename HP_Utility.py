import os
import sys
import subprocess
import stat
import platform
import time
import distro
from language import Language


# noinspection PyExceptClausesOrder
class Utility:
    """
    Utility class holds all the working functions!
    """

    @staticmethod
    def is_root():
        """
        if the current user has root privileges or not!
        :return: boolean
        """
        is_root = False
        try:
            if not os.path.exists('/etc/foo'):
                os.makedirs('/etc/foo')
            else:
                os.rename('/etc/foo', '/etc/bar')
            is_root = True
        except IOError as e:
            if 'Permission denied' in str(e):
                print("You need root permissions to do this (O_o)")
            Utility().terminate("Permission Denied!")
        finally:
            if os.path.exists('/etc/foo'):
                os.rmdir('/etc/foo')
            if os.path.exists('/etc/bar'):
                os.rmdir('/etc/bar')
            return is_root

    @staticmethod
    def system_upgrade(is_test=False):
        """
        :param is_test -> if true, upgrade command will run in force yes mode.
        run system update upgrade before doing anything.
        :return:
        """
        return_code = 200
        error_message = ""
        try:
            file_status = os.stat('bash_scripts/updater.sh')
            os.chmod('bash_scripts/updater.sh', file_status.st_mode | stat.S_IEXEC)
            result = subprocess.Popen(['./bash_scripts/updater.sh', str(is_test)])
            result.communicate()
            return_code = result.returncode
            del file_status
            del result
        except IOError as error:
            return_code = 255
            error_message = str(error)
        except subprocess.CalledProcessError as error:
            return_code = 255
            error_message = str(error)
        except OSError as error:
            return_code = 255
            error_message = str(error)
        except KeyboardInterrupt as error:
            return_code = 255
            error_message = str(error)
        finally:
            if return_code != 0:
                # error occurred in the process
                Utility().terminate("Error Code --> " + str(return_code) + " " + error_message)
            return return_code

    @staticmethod
    def install_psql(is_test=False):
        """
        Install Postgresql and Metasploit Framework related stuff
        :return: 0 on success
        """
        return_code = 200
        error_message = ""
        try:
            file_status = os.stat('bash_scripts/psql.sh')
            os.chmod('bash_scripts/psql.sh', file_status.st_mode | stat.S_IEXEC)
            result = subprocess.Popen(['./bash_scripts/psql.sh', str(is_test)])
            result.communicate()
            return_code = result.returncode
            del result
            del file_status
        except IOError as error:
            return_code = 255
            error_message = str(error)
        except subprocess.CalledProcessError as error:
            return_code = 255
            error_message = str(error)
        except OSError as error:
            return_code = 255
            error_message = str(error)
        except KeyboardInterrupt as error:
            return_code = 255
            error_message = str(error)
        finally:
            if return_code != 0:
                Utility().terminate("Error Code --> " + str(return_code) + " " + error_message)
            return return_code

    @staticmethod
    def install_metasploit(is_test=False):
        """
        installs metasploit framework in the system.
        :param is_test: :bool
        :return: :Integer | exit value
        """
        return_code = 200
        error_message = ""
        try:
            metasploit = os.stat('bash_scripts/metasploit.sh')
            os.chmod('bash_scripts/metasploit.sh', metasploit.st_mode | stat.S_IEXEC)

            if distro.linux_distribution(False)[0] == 'kali':
                result = subprocess.Popen(['./bash_scripts/metasploit.sh', 'Kali', str(is_test)])
            else:
                result = subprocess.Popen(['./bash_scripts/metasploit.sh', 'Linux', str(is_test)])
            result.communicate()
            return_code = result.returncode
            del result
            del metasploit
        except IOError as error:
            return_code = 255
            error_message = str(error)
        except subprocess.CalledProcessError as error:
            return_code = 255
            error_message = str(error)
        except OSError as error:
            return_code = 255
            error_message = str(error)
        except KeyboardInterrupt as error:
            return_code = 255
            error_message = str(error)
        finally:
            if return_code != 0:
                Utility().terminate("Error Code --> " + str(return_code) + " " + error_message)
            return return_code

    @staticmethod
    def chmod_scripts():
        """
        Installing scripts and apps inside /opt/
        :return:
        """
        return_code = 0
        error_message = ""
        try:
            file_status = os.stat('bash_scripts/install_scripts.sh')
            os.chmod('bash_scripts/install_scripts.sh', file_status.st_mode | stat.S_IEXEC)
            del file_status
        except IOError as error:
            return_code = 255
            error_message = str(error)
        except subprocess.CalledProcessError as error:
            return_code = 255
            error_message = str(error)
        except OSError as error:
            return_code = 255
            error_message = str(error)
        except KeyboardInterrupt as error:
            return_code = 255
            error_message = str(error)
        finally:
            if return_code != 0:
                Utility().terminate("Error Code --> " + str(return_code) + " " + error_message)
            return return_code

    @classmethod
    def terminate(cls, message=None):
        """
        force the python script before exiting
        :param message: exit message
        :return: none
        """
        sys.exit(message)

    @classmethod
    def baby_step(cls, is_test=False):
        """
        baby step takes care of the installing scripts
        :param is_test: boolean
        :return:
        """
        return_code = 0
        error_message = ""
        language = Language()
        first_time = language.main_menu_v2()  # since there is no last item
        print(first_time)
        try:
            while True:
                user_input = input("Your option:: ")
                if user_input == "14":
                    # terminate the loop
                    time.sleep(3)
                    print(language.line_apprx + '\n' + language.line_apprx
                          + '\n' + language.line_thats_wrap + '\n'
                          + language.line_apprx + '\n' + language.line_apprx)
                    sys.exit(0)  # The END
                elif user_input == "13":
                    # install all
                    return_code = Utility.__do_it_all(is_test)
                    if return_code != 0:
                        Utility().terminate("System terminated!")
                    else:
                        time.sleep(3)
                        print(language.line_apprx + '\n' + language.line_apprx
                              + '\n' + language.line_thats_wrap + '\n'
                              + language.line_apprx + '\n' + language.line_apprx)
                else:
                    time.sleep(5)
                    result = subprocess.Popen(['./bash_scripts/install_scripts.sh', str(is_test), user_input])
                    result.communicate()
                    return_code = result.returncode
                    del result
                    if return_code != 0:
                        Utility().terminate("System terminated!")

                current_menu = language.main_menu_v2()
                print(current_menu)
        except subprocess.CalledProcessError as error:
            return_code = 255
            error_message = str(error)
        except OSError as error:
            return_code = 255
            error_message = str(error)
        except KeyboardInterrupt as error:
            return_code = 255
            error_message = str(error)
        finally:
            if return_code != 0:
                Utility().terminate("System terminated! " + str(error_message))

    @classmethod
    def __do_it_all(cls, is_test=False):
        """
        do it install all the scripts in a linear fashion.
        :param is_test: bool
        :return: integer (success = 0, failure = 255)
        """
        return_code = 0
        error_message = None
        for user_input in range(1, 14):
            try:
                time.sleep(2)
                result = subprocess.Popen(['./bash_scripts/install_scripts.sh', str(is_test), str(user_input)])
                result.communicate()
                return_code = result.returncode
                del result
                if return_code != 0:
                    Utility().terminate("System terminated!")
            except subprocess.CalledProcessError as error:
                return_code = 255
                error_message = str(error)
            except OSError as error:
                return_code = 255
                error_message = str(error)
            except KeyboardInterrupt as error:
                return_code = 255
                error_message = str(error)
            finally:
                if return_code != 0:
                    Utility().terminate("System terminated! " + str(error_message))
        return return_code


def main():
    language = Language()
    util = Utility()
    if util.is_root():
        if platform.system() != 'Linux':
            print(language.line_hashes + '\n' + language.line_hashes )
            sys.stderr.write(language.line_non_linux_distro)
            print(language.line_hashes + '\n' + language.line_hashes)
            sys.exit(255)

        if sys.version_info < (3, 0, 0):
            print(language.line_hashes + '\n' + language.line_hashes)
            sys.stderr.write(language.line_not_python3)
            print(language.line_hashes + '\n' + language.line_hashes)
            sys.exit(255)

        if distro.linux_distribution(False)[0] != 'kali':
            print(language.line_apprx + '\n' + language.line_not_kali + '\n' + language.line_apprx)

        time.sleep(5)
        # call the utility functions
        util.system_upgrade()
        util.install_psql()
        util.install_metasploit()
        util.chmod_scripts()
        util.baby_step()
    else:
        print(language.line_hashes + '\n' + language.line_hashes + '\n' + language.line_non_superuser)
        sys.exit("Permission Denied!\n{}\n{}".format(language.line_hashes, language.line_hashes))


if __name__ == '__main__':
    main()
