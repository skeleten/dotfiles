#! /usr/bin/env python2
from subprocess import check_output

def get_pass(account):
    return check_output("pass Mail/" + account, shell = True).splitlines()[0]

def filter_folder_exchange(folder):
    return "INBOX" in folder;
