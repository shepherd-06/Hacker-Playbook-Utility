import os
import sys
import subprocess
import stat


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
        subprocess.call(['./metasploit.sh'])
    except IOError as error:
        sys.exit(str(error))
    except subprocess.CalledProcessError as error:
        sys.exit(str(error))
    except OSError as error:
        sys.exit((str(error)))
    finally:
        return 1


if __name__ == '__main__':
    if sys.version_info < (3, 0, 0):
        sys.stderr.write("You need python 3.0.0 or later to run this script\n")
        exit(1)
    if ask_sudo():
        system_update_upgrade()
        install_phase_alpha()
        print("\n\n\n\nDone? May be.....")
        sys.exit(0)  # The END
    else:
        sys.exit("Permission Denied!")
