class Language:

    line_hashes = '###############################################'
    line_apprx = '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    line_non_linux_distro = "This script must run in a Kali or any Linux distro.\nGood bye! :)\n"
    line_not_python3 = "Need python3 to run this script\nGood bye! :)\n"
    line_not_kali = "You are not using Kali OS! Please at least use these in a VirtualBOX so that you can " \
                    "roll back more easily!"
    line_non_superuser = "You need to be a superuser or run this script in super user mode.\nGood bye. :)"
    line_thats_wrap = "~~~~~~~~~~~~~~That's a wrap baby!~~~~~~~~~~~~~~"

    line_0 = "Choose your options:" \
             "{}" \
             "\n** Press [ 13 ] to download ** all scripts **" \
             "\n\n** Press [ 14 ] to terminate the script"
    line_1 = '\n**{} Discover Script (Former Backtrack Script)'
    line_2 = '\n**{} SMBExec (grab hashes out of Domain Controller and reverse shells)'
    line_3 = '\n**{} Veil 3.0 (to create Python based Metepreter executable)'
    line_4 = '\n**{} PeepingTom (to take snapshots of web pages) (NOT AVAILABLE NOW***)'
    line_5 = '\n**{} Eye Witness (to take snapshots of web pages'
    line_6 = '\n**{} Powersploit (to create Powershell script)'
    line_7 = '\n**{} Responder (to gain NTLM challenge/hashes)'
    line_8 = '\n**{} Social Engineering Toolkit'
    line_9 = '\n**{} bypassUAC (NOT AVAILABLE NOW***)'
    line_10 = '\n**{} beEF for cross site scripting'
    line_11 = '\n**{} Fuzzing Lists (for Social Engineering Campaign)'
    line_12 = '\n**{} other necessary scripts like' \
              '\n   - WCE (Windows Credential Editor), Mimikatz (to recover password from memory),' \
              '\n   - Custom password list from Skull Security and Crackstation, ' \
              '\n   - & NMap scripts (for quicker scanning and smarter identification'

    def __init__(self):
        # These will be all the folders in a selected machine
        self.folder_name = ['discover', 'smbexec', 'Veil', 'EyeWitness', 'PowerSploit', 
        'Responder', 'set', 'beEF', 'SecLists']
        self.password_folders = ['mimikatz_trunk.zip',
         'crackstation-human-only.txt.gz', 'rockyou.txt.bz2']

        self.opt_status = dict()
        self.wget_status = dict()
        self.folder_to_index = {
            1: 'discover',
            2: 'smbexec',
            3: 'Veil',
            4: '',
            5: 'EyeWitness',
            6: 'PowerSploit',
            7: 'Responder',
            8: 'set',
            9: '',
            10: 'beEF',
            11: 'SecLists',
            12: 'mimikatz_trunk.zip',
            13: 'crackstation-human-only.txt.gz',
            14: 'rockyou.txt.bz2',
        }

    def main_menu_v2(self):
        self.item_status() # this will update the dicts inside __init__
        sentence_list = self._make_sentences()
        final_line = ''
        for index in range(0, 12):
            folder_name = self.folder_to_index[index + 1]
            if index < 11:
                folder_status = self.opt_status[folder_name] if folder_name != '' else False
            else:
                folder_status = self.wget_status[folder_name] if folder_name != '' else False
            new_sentence = sentence_list[index]
            if folder_status:
                new_sentence = new_sentence.format(' [ Completed ] | [ {} ] to re-install/download again'.format(index + 1))
            else:
                new_sentence = new_sentence.format('Press [ {} ] to install'.format(index + 1))
            sentence_list[index] = new_sentence
        all_lines = ''
        for sentence in sentence_list:
            all_lines += sentence
        final_line = self.line_0.format(all_lines)
        return final_line


    def main_menu(self, last_item):
        # its deprecated
        last_item = int(last_item)
        last_item = 12 if last_item > 12 else last_item
        sentence_list = self._make_sentences()
        count = 0
        while count < last_item:
            new_sentence = sentence_list[count]
            new_sentence = new_sentence.format(' [ Completed ] | Press [ {} ] to re-install/download again'.format(count + 1))
            sentence_list[count] = new_sentence
            count += 1

        while count < len(sentence_list):
            new_sentence = sentence_list[count]
            if count == len(sentence_list):
                new_sentence = new_sentence.format('Press [ {} ] to download & install'.format(count + 1))
            else:
                new_sentence = new_sentence.format('Press [ {} ] to install'.format(count + 1))
            sentence_list[count] = new_sentence
            count += 1

        # now this will create 12 sentences inside a list.
        big_line = ''
        for sentence in sentence_list:
            big_line += sentence
        final_line = self.line_0.format(big_line)
        return final_line

    def _make_sentences(self):
        sentence_array = list()
        sentence_array.append(self.line_1)
        sentence_array.append(self.line_2)
        sentence_array.append(self.line_3)
        sentence_array.append(self.line_4)
        sentence_array.append(self.line_5)
        sentence_array.append(self.line_6)
        sentence_array.append(self.line_7)
        sentence_array.append(self.line_8)
        sentence_array.append(self.line_9)
        sentence_array.append(self.line_10)
        sentence_array.append(self.line_11)
        sentence_array.append(self.line_12)
        return sentence_array

    def item_status(self):
        """
        update the status of items /opt and wget magic.
        """
        # update the status of all files in opt/
        all_opt_files = self.list_dir()
        for files in self.folder_name:
            if files in all_opt_files:
                self.opt_status[files] = True
            else:
                self.opt_status[files] = False

        # update the status over backup password and mimikatz
        import os
        mimikatz_path = '~/backup_wget/'
        password_list = '~/backup_wget/password_list/'
        mimikatz_bkup = self.list_dir(path = os.path.expanduser(mimikatz_path))
        if self.password_folders[0] in mimikatz_bkup:
            self.wget_status[self.password_folders[0]] = True
        else:
            self.wget_status[self.password_folders[0]] = False

        all_wget_files = self.list_dir(path = os.path.expanduser(password_list))
        for files in self.password_folders[1:]:
            if files in all_wget_files:
                self.wget_status[files] = True
            else:
                self.wget_status[files] = False
        return
        

    @staticmethod
    def list_dir(path = '/opt/'):
        """
        returns a list of all the folders in a directory given.
        """
        import os
        # this program is suppose to run in sudo mode
        return os.listdir(path)


if __name__ == '__main__':
    #print(Language().main_menu_v2())
    pass
