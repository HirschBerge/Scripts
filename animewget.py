#!/usr/bin/env python3
import os
import sys
from datetime import datetime
from alive_progress import alive_bar
import argparse
import contextlib
import subprocess

parser = argparse.ArgumentParser(description="Downloading anime")
parser.add_argument(
    "-t",
    "--type",
    choices=["episode", "season"],
    required=True,
    help="Choose between a single episode and a text file with a season",
)
parser.add_argument("-u", "--url", required=False, help="Direct URL to video file.")
parser.add_argument(
    "-f", "--file", required=False, help="Path to text file with URLs, one per line."
)
parser.add_argument(
    "--progress",
    action="store_true",
    help="Show only overall progress for downloading a season.",
)
parser.add_argument(
    "-s",
    "--season",
    required=True,
    help="Numeric number of the season you're downloading.",
)
parser.add_argument(
    "-e",
    "--episode",
    required=False,
    default=None,
    help="Numeric value of the episode you are downloading. (Single only.)",
)
args = vars(parser.parse_args())


def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{} \033[38;2;255;255;255m".format(r, g, b, text)


class anime_wget:
    def __init__(self, anime, season, episode, file_name=None):
        self.anime = anime
        self.season = season
        self.episode = episode
        self.file_name = file_name

    def overall_downloader(self):
        with open(self.anime, "r") as f:
            lines = f.readlines()
            string = f"S{self.season.zfill(2)}E"
            for count, line in enumerate(lines):
                cnt = str(count + 1).zfill(2)
                filnm = f"{string}{cnt}.mp4"
                with alive_bar(len(lines), title=f"Now Downloading {filnm}") as bar:
                    eoline = line[-50:]
                    awkd = """awk -F"/" '{ print $2 }' """
                    # os.system(
                    #     (
                    #         f"""echo "{eoline}" | {awkd} |sed -e 's/+-+/ E/g' -e 's/+/ /g' -e 's/\.mp4?stream=1//g' """
                    #     )
                    # )
                    now_downloading = f"Now Downloading: {filnm}"
                    # bar.text(now_downloading)
                    with contextlib.redirect_stdout(None):
                        os.system(
                            f"""axel -q -k -a -n 6 "{line}" --out="{filnm}" --no-clobber 2>/dev/null"""
                        )
                    bar()

    def downloader(self):
        with open(self.anime, "r") as f:
            lines = f.readlines()
            string = f"S{self.season.zfill(2)}E"
            for count, line in enumerate(lines):
                cnt = str(count + 1).zfill(2)
                filnm = f"{string}{cnt}.mp4"
                eoline = line[-50:]
                awkd = """awk -F"/" '{ print $2 }' """
                os.system(
                    (
                        f"""echo "{eoline}" | {awkd} |sed -e 's/+-+/ E/g' -e 's/+/ /g' -e 's/\.mp4?stream=1//g' """
                    )
                )
                now_downloading = f"Now Downloading: {filnm}"
                print(now_downloading)
                os.system(f"""axel -k -a -n 6 "{line}" --out="{filnm}" --no-clobber""")

    def downloader_single(self):
        if self.episode is None:
            print(
                colored(
                    255,
                    0,
                    0,
                    "Episode Error: You must include an episode to download single episodes through this script.",
                )
            )
            exit(1)
        else:
            pass
        eoline = self.anime[-50:]
        awkd = """awk -F"/" '{ print $2 }' """
        os.system(
            (
                f"""echo "{eoline}" | {awkd} |sed -e 's/+-+/ E/g' -e 's/+/ /g' -e 's/\.mp4?stream=1//g' """
            )
        )
        os.system(
            f"""axel -a -n 6 -k "{self.anime}" --out="{self.file_name}" --no-clobber"""
        )


def get_info():
    if args["type"].lower() == "episode":
        content = args["url"]
    else:
        content = args["file"]
    # try:
    #     season = sys.argv[2]
    # except IndexError:
    #     print(
    #         colored(
    #             255,
    #             0,
    #             0,
    #             "Season Error: You must include a season to download anime through this script.",
    #         )
    #     )
    #     exit(1)
    season = str(args["season"]).zfill(2)
    if not args["episode"] and args["type"] == "episode":
        print("You need to include an episode # w/ --episode")
        exit(1)
    else:
        episode = str(args["episode"]).zfill(2)
    filnm = f"S{season}E{episode}.mp4"
    return content, season, episode, filnm


def time_it(func):
    start = datetime.now()
    try:
        func()
    except TypeError:
        pass
    end = datetime.now()
    timing = str(end - start)
    os.system(f"""clear ; exa -lah --group-directories-first --icons""")
    print(f"{colored(0,255,0,'Download complete!')}")
    print(f"Time taken: {colored(0, 255, 0, timing[:10])}")


def get_anime_title():
    return subprocess.getoutput(
        """pwd |awk -F"Anime/" '{ print $2 }' |awk -F"/" '{ print $1 }'"""
    )


def notify_send():
    ani_title = get_anime_title()
    os.system(
        f"""notify-send -t 3000 -u normal \"Finished downloading from anime: {ani_title}\" """
    )
    SOUND_FILE = "/usr/share/sounds/freedesktop/stereo/complete.oga"
    os.system(f"""[ -f {SOUND_FILE} ] && paplay {SOUND_FILE}""")


def main():
    ani_title = get_anime_title()
    content, season, episode, filnm = get_info()
    get_anime = anime_wget(content, season, episode, filnm)
    if args["type"] == "episode":
        now_downloading = f"Now Downloading: {ani_title}: {filnm}"
        print(colored(255, 0, 0, now_downloading))
        time_it(get_anime.downloader_single)
        notify_send()
        exit(0)

    if args["type"].lower() == "season" and args["progress"]:
        time_it(get_anime.overall_downloader)
        notify_send()
    else:
        time_it(get_anime.downloader())
        notify_send()


if __name__ == "__main__":
    main()
