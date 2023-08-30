#!/usr/bin/env python3

import os
from datetime import datetime


def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{} \033[38;2;255;255;255m".format(r, g, b, text)


def time_it(func):
    start = datetime.now()
    try:
        func()
    except TypeError:
        pass
    end = datetime.now()
    timing = str(end - start)
    # os.system(f"""clear ; exa -lah --group-directories-first --icons""")
    print(f"{colored(0,255,0,'Download complete!')}")
    print(f"Time taken: {colored(0, 255, 0, timing[:10])}")


def scan_data(directory):
    jpg_png_files = []
    total_size = 0
    for root, _, files in os.walk(directory):
        for file in files:
            if file.lower().endswith((".jpg", ".png")):
                total_size += os.path.getsize(f"{root}/{file}")
                jpg_png_files.append(os.path.join(root, file))
    hr_size = "{:.2f} GB".format(total_size / (1024 * 1024 * 1024))
    return jpg_png_files, hr_size


directory_to_search = "/mnt/NAS/Manga"
# directory_to_search = "/mnt/NAS/Backups/Yuri/"


def main():
    jpg_png_files, hr_size = scan_data(directory_to_search)
    total = f"{len(jpg_png_files):,}"
    print(
        f"{colored(255, 165, 0, 'The total amount of PNGs and JPGs is:')} {colored(255, 36, 0, total)}"
    )
    print(
        f"{colored(255,165,0, 'The total size of all these images is:')} {colored(255, 36,0, hr_size)}"
    )


if __name__ == "__main__":
    time_it(main)
