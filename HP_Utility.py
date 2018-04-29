import os
import sys
import subprocess
import stat
import platform
import time
import distro


class Utility:
    """
    Utility class holds all the working functions!
    """
    @staticmethod
    def is_root():
        """

        :return: if the current user has root privileges or not!
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
        return_code = 0
        try:
            file_status = os.stat('bash_scripts/updater.sh')
            os.chmod('bash_scripts/updater.sh', file_status.st_mode | stat.S_IEXEC)
            result = subprocess.Popen(['./bash_scripts/updater.sh', is_test])
            result.communicate()
            return_code = result.returncode
            del file_status
            del result
        except IOError as error:
            return_code = 200
            sys.exit(str(error))
        except subprocess.CalledProcessError as error:
            return_code = 201
            sys.exit(str(error))
        except OSError as error:
            return_code = 202
            sys.exit((str(error)))
        finally:
            if return_code != 0:
                # error occurred in the process
                Utility().terminate("An Error Occurred during system update!")
            return return_code

    @staticmethod
    def install_psql(is_test=False):
        """
        Install Postgresql and Metasploit Framework related stuff
        :return: 0 on success
        """
        return_code = 0
        try:
            file_status = os.stat('bash_scripts/psql.sh')
            os.chmod('bash_scripts/psql.sh', file_status.st_mode | stat.S_IEXEC)
            result = subprocess.Popen(['./bash_scripts/psql.sh', is_test])

            result.communicate()
            return_code = result.returncode
            del result
            del file_status
        except IOError as error:
            return_code = 255
            sys.exit(str(error))
        except subprocess.CalledProcessError as error:
            return_code = 255
            sys.exit(str(error))
        except OSError as error:
            return_code = 255
            sys.exit((str(error)))
        finally:
            if return_code != 0:
                Utility().terminate("Error occurred in PostgreSQL installation!")
            return return_code

    @staticmethod
    def install_metasploit(is_test=False):
        """
        installs metasploit framework in the system.
        :param is_test: :bool
        :return: :Integer | exit value
        """
        return_code = 0
        try:
            metasploit = os.stat('bash_scripts/metasploit.sh')
            os.chmod('bash_scripts/metasploit.sh', metasploit.st_mode | stat.S_IEXEC)

            if distro.linux_distribution(False)[0] == 'kali':
                result = subprocess.Popen(['./bash_scripts/metasploit.sh', 'Kali', is_test])
            else:
                result = subprocess.Popen(['./bash_scripts/metasploit.sh', 'Linux', is_test])
            result.communicate()
            return_code = result.returncode
            del result
            del metasploit
        except IOError as error:
            return_code = 255
            sys.exit(str(error))
        except subprocess.CalledProcessError as error:
            return_code = 255
            sys.exit(str(error))
        except OSError as error:
            return_code = 255
            sys.exit((str(error)))
        finally:
            if return_code != 0:
                Utility().terminate("Error occurred in Metasploit Framework!")
            return return_code

    @staticmethod
    def install_scripts(is_test=False):
        """
        Installing scripts and apps inside /opt/
        :param is_test: :bool
        :return:
        """
        return_code = 0
        try:
            file_status = os.stat('bash_scripts/install_scripts.sh')
            os.chmod('bash_scripts/install_scripts.sh', file_status.st_mode | stat.S_IEXEC)
            result = subprocess.Popen(['./bash_scripts/install_scripts.sh', is_test])
            result.communicate()
            return_code = result.returncode
            del result
            del file_status
        except IOError as error:
            sys.exit(str(error))
        except subprocess.CalledProcessError as error:
            sys.exit(str(error))
        except OSError as error:
            sys.exit((str(error)))
        finally:
            if return_code != 0:
                Utility().terminate("Error occurred!")
            return return_code

    @classmethod
    def terminate(cls, message=None):
        """
        force the python script before exiting
        :param message: exit message
        :return: none
        """
        sys.exit(message)


def main():
    util = Utility()
    if util.is_root():
        if platform.system() != 'Linux':
            print("###############################################")
            print("###############################################")
            sys.stderr.write("This script must run in a Kali or any Linux distro.\nGood bye! :)\n")
            print("###############################################")
            print("###############################################")
            sys.exit(255)

        if sys.version_info < (3, 0, 0):
            print("###############################################")
            print("###############################################")
            sys.stderr.write("Need python3 to run this script\nGood bye! :)\n")
            print("###############################################")
            print("###############################################")
            sys.exit(255)

        if distro.linux_distribution(False)[0] != 'kali':
            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            print("You are not using Kali OS! Please at least use these in a VirtualBOX so that you can roll back more "
                  "easily!")
            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

        # try:
        #     file_status = os.stat('bash_scripts/terminator.sh')
        #     os.chmod('bash_scripts/terminator.sh', file_status.st_mode | stat.S_IEXEC)
        #     del file_status  # no needie anymore
        # except OSError as err:
        #     sys.exit((str(err)))

        # call the utility functions
        print(util.system_upgrade())
        util.install_psql()
        util.install_metasploit()
        util.install_scripts()

        time.sleep(3)
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("~~~~~~~~~~~~~~That's a wrap baby!~~~~~~~~~~~~~~")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        sys.exit(0)  # The END
    else:
        print("###############################################")
        print("###############################################")
        print("You need to be a superuser or run this script in super user mode.\nGood bye. :)")
        sys.exit("Permission Denied!\n###############################################\n"
                 "###############################################")


if __name__ == '__main__':
    main()

# kill $(pgrep -f 'HP-Utility')
