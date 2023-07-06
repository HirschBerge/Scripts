#!/usr/bin/env python3
import re

in_file = "./modules.ini"
out_file = "./modules.nix"

def main():
    with open(in_file, "r") as file:
        with open(out_file, "w+") as outf:
            for line in file:
                line = line.strip()
                search_pattern_1 = r'= '
                search_pattern_2 = r'\[([bar|module].*?)\]'
                line = re.sub(';', '#', line)
                if re.search(search_pattern_1, line):
                    line = re.sub(r"$", '";', line)
                    line = re.sub('= ', '= "', line)
                    line = re.sub(r'^', r'\t', line)
                    # print(line)
                if re.search(search_pattern_2, line):
                    line = re.sub(r'\[', '};\n"', line)
                    line = re.sub(r'\]', '" = {', line)
                print(line)
                outf.write(f"{line}\n")

if __name__=='__main__':
    main()