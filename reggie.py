#!/usr/bin/env python3
import re
import sys

# This script is to partially automate the process of porting a traditional polybar config for use with NixOS home-manager.
# it should still be inspected and any necessary changes made.
in_file = f"{sys.argv[1]}"
out_file = f"{sys.argv[2]}"


def main():
    with open(in_file, "r") as file:
        with open(out_file, "w+") as outf:
            outf.write("{")
            for line in file:
                line = line.strip()
                line = re.sub(r"^\s*;", "#", line)
                search_pattern_1 = r"= "
                search_pattern_2 = r"\[([bar module].*?)\]"
                if not re.search(r"^\s*#", line):
                    if re.search(search_pattern_1, line):
                        line = re.sub(r"$", '";', line)
                        line = re.sub("= ", '= "', line)
                        line = re.sub(r"^", r"\t", line)
                        # print(line)
                    if re.search(search_pattern_2, line):
                        line = re.sub(r"\[", '};\n"', line)
                        # print(line)
                        line = re.sub(r"\]", '" = {', line)
                if not (re.match(r"^\s*$", line)):
                    line = re.sub('""', '"', line)
                    line = re.sub(r"\{\};", "{", line)
                    line = re.sub('" " ', '"', line)
                    line = re.sub(r"=$", '= " ";', line)
                    line = re.sub("inherit", '"inherit"', line)
                    if "#" not in line:
                        print(line)
                        outf.write(f"{line}\n")
            outf.write("}")


if __name__ == "__main__":
    main()
