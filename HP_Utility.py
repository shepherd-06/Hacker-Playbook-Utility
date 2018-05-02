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
        finally:
            if return_code != 0:
                Utility().terminate("Error Code --> " + str(return_code) + " " + error_message)
            return return_code

    @staticmethod
    def install_scripts():
        """
        Installing scripts and apps inside /opt/
        :return:
        """
        return_code = 0
        error_message = ""
        try:
            file_status = os.stat('bash_scripts/install_scripts.sh')
            os.chmod('bash_scripts/install_scripts.sh', file_status.st_mode | stat.S_IEXEC)
            # result = subprocess.Popen(['./bash_scripts/install_scripts.sh', str(is_test)])
            # result.communicate()
            # return_code = result.returncode
            # del result
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
        try:
            while True:
                print("Choose your options:"
                      "\n** Press [ 1 ] to install Discover Script (Former Backtrack Script)"
                      "\n** Press [ 2 ] to install SMBExec (grab hashes out of Domain Controller and reverse shells)"
                      "\n** Press [ 3 ] to install Veil 3.0 (to create Python based Metepreter executable)"
                      "\n** Press [ 4 ] to install PeepingTom (to take snapshots of web pages) (NOT AVAILABLE NOW***)"
                      "\n** Press [ 5 ] to install Eye Witness (to take snapshots of web pages"
                      "\n** Press [ 6 ] to install Powersploit (to create Powershell script)"
                      "\n** Press [ 7 ] to install Responder (to gain NTLM challenge/hashes)"
                      "\n** Press [ 8 ] to install Social Engineering Toolkit"
                      "\n** Press [ 9 ] to install bypassUAC (NOT AVAILABLE NOW***)"
                      "\n** Press [ 10 ] to install beEF for cross site scripting"
                      "\n** Press [ 11 ] to install Fuzzing Lists (for Social Engineering Campaign)"
                      "\n** Press [ 12 ] to download & install other necessary scripts like\n   - WCE (Windows "
                      "Credential "
                      "Editor), "
                      "\n   - Mimikatz (to recover password from memory),\n   - Custom password list from Skull "
                      "Security "
                      "and "
                      "Crackstation,\n   - & NMap scripts (for quicker scanning and smarter identification"
                      "\n\n** Press [ 13 ] to terminate the script")

                user_input = input("Your option:: ")
                if user_input == "13":
                    # terminate the loop
                    time.sleep(3)
                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                    print("~~~~~~~~~~~~~~That's a wrap baby!~~~~~~~~~~~~~~")
                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                    sys.exit(0)  # The END
                else:
                    time.sleep(5)
                    result = subprocess.Popen(['./bash_scripts/install_scripts.sh', str(is_test), user_input])
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
        finally:
            if return_code != 0:
                Utility().terminate("System terminated! "+str(error_message))


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

        # call the utility functions
        util.system_upgrade()
        util.install_psql()
        util.install_metasploit()
        util.install_scripts()
        util.baby_step()
    else:
        print("###############################################")
        print("###############################################")
        print("You need to be a superuser or run this script in super user mode.\nGood bye. :)")
        sys.exit("Permission Denied!\n###############################################\n"
                 "###############################################")


if __name__ == '__main__':
    main()
