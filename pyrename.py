#!/bin/python3

import os
import tkinter as tk
from tkinter import filedialog


currentdir = os.getcwd()
files_to_rename = []


def convertTuple(tup):
    str = ''.join(tup)
    return str


def get_filelocation():
    root = tk.Tk()
    root.withdraw()
    global namesfile
    namesfile = filedialog.askopenfilenames()
    namesfile = convertTuple(namesfile)
    print(namesfile)


def get_contents():
    for file in os.listdir(currentdir):
        if file.endswith(".mp4"):
            current_item = os.path.join(file)
            files_to_rename.append(current_item)

    print(files_to_rename)
    global dirsize
    dirsize = len(files_to_rename)


def get_filelength():
    file = open(namesfile, "r")
    line_count = 0
    for line in file:
        if line != "\n":
            line_count += 1
    file.close()
    print("The length of ", namesfile, " is: ", line_count)


def main():
    get_filelocation()
    get_contents()
    get_filelength()


main()
