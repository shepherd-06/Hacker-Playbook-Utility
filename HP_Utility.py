import os
import sys
import subprocess
import stat
import platform
import time


def ask_sudo():
    """

    :return: if the current user has root privileges or not!
    """
    is_sudo = False
    try:
        if not os.path.exists('/etc/foo'):
            os.makedirs('/etc/foo')
        else:
            os.rename('/etc/foo', '/etc/bar')
        is_sudo = True
    except IOError as e:
        if 'Permission denied' in str(e):
            print("You need root permissions to do this (O_o)")
    finally:
        if os.path.exists('/etc/foo'):
            os.rmdir('/etc/foo')
        if os.path.exists('/etc/bar'):
            os.rmdir('/etc/bar')
        return is_sudo


def system_update_upgrade():
    """
    run system update upgrade before doing anything.
    :return:
    """
    try:
        file_status = os.stat('updater.sh')
        os.chmod('updater.sh', file_status.st_mode | stat.S_IEXEC)
        subprocess.call(['./updater.sh'])
    except IOError as error:
        sys.exit(str(error))
    except subprocess.CalledProcessError as error:
        sys.exit(str(error))
    except OSError as error:
        sys.exit((str(error)))
    finally:
        return 1


def install_phase_alpha():
    """
    Install Postgresql and Metasploit Framework related stuff
    :return:
    """
    try:
        file_status = os.stat('psql.sh')
        os.chmod('psql.sh', file_status.st_mode | stat.S_IEXEC)
        subprocess.call(['./psql.sh'])

        metasploit_file = os.stat('metasploit.sh')
        os.chmod('metasploit.sh', metasploit_file.st_mode | stat.S_IEXEC)

        if distro.linux_distribution(False) == 'kali':
            subprocess.call(['./metasploit.sh', 'Kali'])
        else:
            subprocess.call(['./metasploit.sh', 'Linux'])

    except IOError as error:
        sys.exit(str(error))
    except subprocess.CalledProcessError as error:
        sys.exit(str(error))
    except OSError as error:
        sys.exit((str(error)))
    finally:
        return 1


def install_phase_bravo():
    """
    Installing scripts and apps inside /opt/
    Discover, SMBExec, Veil (new)
    :return:
    """
    try:
        file_status = os.stat('phase_bravo.sh')
        os.chmod('phase_bravo.sh', file_status.st_mode | stat.S_IEXEC)
        subprocess.call(['./phase_bravo.sh'])
    except IOError as error:
        sys.exit(str(error))
    except subprocess.CalledProcessError as error:
        sys.exit(str(error))
    except OSError as error:
        sys.exit((str(error)))
    finally:
        return 1


def main():
    if ask_sudo():
        if platform.system() != 'Linux':
            print("###############################################")
            print("###############################################")
            sys.stderr.write("This script must run in a Kali or any Linux distro.\nGood bye! :)\n")
            print("###############################################")
            print("###############################################")
            exit(1)

        if sys.version_info < (3, 0, 0):
            print("###############################################")
            print("###############################################")
            sys.stderr.write("Need python3 to run this script\nGood bye! :)\n")
            print("###############################################")
            print("###############################################")
            exit(1)

        try:
            import distro
        except IOError as error:
            sys.exit((str(error)))
        except subprocess.CalledProcessError as error:
            sys.exit((str(error)))
        except UnicodeError as error:
            sys.exit((str(error)))

        if distro.linux_distribution(False) != 'kali':
            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            print("You are not using Kali OS! Please at least use these in a VirtualBOX so that you can roll back more "
                  "easily!")
            print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

        try:
            file_status = os.stat('terminator.sh')
            os.chmod('terminator.sh', file_status.st_mode | stat.S_IEXEC)
        except OSError as err:
            sys.exit((str(err)))

        system_update_upgrade()
        install_phase_alpha()
        install_phase_bravo()
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
