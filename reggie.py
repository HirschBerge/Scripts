#!/usr/bin/env python3
import re

in_file = "./modules.ini"
out_file = "./modules.nix"

def main():
    count = 0
    with open(in_file, "r") as file:
        with open(out_file, "w+") as outf:
            for line in file:
                line = line.strip()
                line = re.sub(r'=$', '= ', line)
                search_pattern_1 = r'= '
                search_pattern_2 = r'\[([bar module].*?)\]'
                line = re.sub(';', '#', line)
                if "#" not in line:
                    if re.search(search_pattern_1, line):
                        line = re.sub(r"$", '";', line)
                        line = re.sub('= ', '= "', line)
                        line = re.sub(r'^', r'\t', line)
                        # print(line)
                    if re.search(search_pattern_2, line):
                        # print(line)
                        if count >= 1:
                            line = re.sub(r'\[', '};\n"', line)
                            line = re.sub(r'\]', '" = {', line)
                        count += 1
                if not (re.match(r'^\s*$', line)):
                    print(line)
                    outf.write(f"{line}\n")

if __name__=='__main__':
    main()