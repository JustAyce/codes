import os
import subprocess
from flask import render_template
from flask import Flask, flash, redirect, request

UPLOAD_FOLDER = '/home/kali/Desktop'
app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER


@app.route('/', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        if 'file' not in request.files:
            return ('No file :(')

        file = request.files['file']
        if file:
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], file.filename))
            if os.stat(os.path.join(app.config['UPLOAD_FOLDER'], file.filename)).st_size != 0:
                print('yep')
                crack_hash(f)
                return ('nice')
            return "empty file"
    # curl -X POST -F file=@hash.txt http://127.0.0.1:5000
    return ('upload.html')

def crack_hash(f):
    command = "sudo john --format=LM --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt > cracked.txt"
    proc = subprocess.Popen(command, stdout=subprocess.PIPE, shell=True)
    print(proc.pid)
    return True

if __name__ == '__main__':
    app.run()
