#! /usr/bin/env python2
from subprocess import check_output

def get_pass(account):
    return check_output("pass Mail/" + account, shell = True).splitlines()[0]

def filter_folder_exchange(folder):
    if "Calender" in folder:
        return False;
    if "Contacts" in folder:
        return False;
    if "Journal" in folder:
        return False;
    if "Notes" in folder:
        return False;
    if "Synchronisierungsprobleme" in folder:
        return False;
    return True;
