#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import argparse
import xml.etree.ElementTree as ET

def depthFisrt(child):
    if child.tag == '':
        return
    else:
        os.makedirs(os.path.join(os.getcwd(),child.tag))
        print(os.path.join(os.getcwd(),child.tag) + '  generated...')
        os.chdir(os.path.join(os.getcwd(),child.tag))
        for subchild in child:
            depthFisrt(subchild)
        os.chdir(os.path.join(os.getcwd(),'..'))

def generateArchiveTree(args):
    print("Generating archieves...")
    tree = ET.parse(args.archiveTree_xml)
    root = tree.getroot()
    path = os.getcwd()
    print(path)
    for child in root:
        depthFisrt(child)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('archiveTree_xml', help='path to xml file describing archiveTree')
    args = parser.parse_args()
    generateArchiveTree(args)
