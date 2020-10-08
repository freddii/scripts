import subprocess
import hashlib
import os
import sys
import time
 
def GetCurrentHash():
    with open(txtFile) as file_to_check: 
        # read contents of the file 
        data = file_to_check.read()
        # pipe contents of the file through 
        md5_returned = hashlib.md5(data.encode('utf-8')).hexdigest()
        return md5_returned
 
 
def SpeakToText(message):
    print(message)
    os.system("sh ~/programs_setup/speak_text/chat2voice_speak.sh " + str(message))
 
 
def SplitString(text):
    splitted = str(text).split(": ")
    return splitted[1]
 
if __name__ == "__main__":
 
 
 
    #SpeakToText("Dies ist ein".encode('utf8'))
    print("Text To Speech SL Chat Log")
    txtFile = r'/home/debian/.secondlife/xyz_resident/chat.txt'
 
    beforeHash = '' 
    # Open,close, read file and calculate MD5 on its contents 
    with open(txtFile) as file_to_check: 
        # read contents of the file 
        data = file_to_check.read()
        # pipe contents of the file through 
        md5_returned = hashlib.md5(data.encode('utf-8')).hexdigest()
        beforeHash = md5_returned
 
 
    while True:
        if GetCurrentHash() != beforeHash:
            beforeHash = GetCurrentHash()
 
            with open(txtFile, 'r') as f:
                lines = f.readlines()
                lastLine = lines[len(lines)-1]
                print(SplitString(lastLine))
                SpeakToText(SplitString(lastLine).encode('utf8').splitlines()[0])
                time.sleep(1.5)