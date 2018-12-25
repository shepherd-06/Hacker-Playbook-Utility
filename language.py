class Language:
    line_hashes = '###############################################'
    line_apprx = '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
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

    def main_menu(self, last_item):
        sentence_list = self._make_sentences()
        count = 0
        while count < last_item:
            new_sentence = sentence_list[count]
            new_sentence = new_sentence.format(' [ Completed ] -')
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


if __name__ == '__main__':
    # print(Language().menu_form(-12))
    pass