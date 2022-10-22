import re
import socket
from flask import Flask, render_template, request
import subprocess
UPLOAD_FOLDER = '~/'
app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def upload():
    if request.method == "POST":
        if 'file' not in request.files:
            return ("no files :(")
        file = request.files['files']
        if file:
            f = os.path.join.app.config['UPLOAD_FOLDER'], file.filename
            file.save(f)
            if os.stat(f).st_size != 0:
                crack_hash(f)
                return "Nice"
# curl -X POST -F file=@hash.txt http://127.0.0.1:5000
app.run()

def crack_hash(f):
    command = "sudo john --format=LM --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt > cracked.txt"
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    print(proc.pid)
    return True


def format_hash():
    with open(r"C:\Temp\hash.txt",'r') as d:
        data = d.read()

    d.close()

    x = re.findall("User : [a-zA-Z0-9\r\w\n\t\s]* Hash NTLM: [a-zA-Z0-9]*", data)
    with open(r"C:\Temp\NTLM_hash.txt",'w')as w:
        for NTLM in x:
            segs = NTLM.split(": ")
            user = segs[1].split("\n")[0]
            hash = segs[2]
            w.write(f'{user}:{hash}\n')
            # print(f"{user}:{hash}")
    # john --format=LM --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt > cracked.txt

    return True

# format_hash()

