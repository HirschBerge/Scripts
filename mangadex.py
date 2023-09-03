#!/usr/bin/env python3.11
import MangaDexPy
from MangaDexPy import downloader
import os, contextlib, sys, logging, string, re, shutil, uuid
from datetime import datetime
from alive_progress import alive_bar
from helper import *


def sort_chapters(chapters: list):
    # skipped_chapters = [
    #     x for x in chapters if x.uploader.username == "NotXunder" if x.chapter
    # ]
    # sorted_skipped_chapters = sorted(
    #     skipped_chapters, key=lambda chap: float(chap.chapter)
    # )
    # print(
    #     f"Skipped chapters uploaded by Mangaplus: {''.join(str(colored(255,0,0,c.chapter)) for c in sorted_skipped_chapters)}."
    # )
    eng_chapters = [
        x
        for x in chapters
        if x.language == "en"
        if x.uploader.username != "MangaDex"
        if x.uploader.username != "comikey"
        if x.uploader.username != "NotXunder"
        if x.uploader.username != "AzukiTeam"
        if x.uploader.username != "inkrcomics"
        if x.chapter
    ]
    # test = [[x.uploader.username, x.chapter] for x in eng_chapters if x.chapter == "2"]
    # print(test)
    sorted_chapters = sorted(eng_chapters, key=lambda chap: float(chap.chapter))
    unique_chapters_dict = {}
    for chapter in sorted_chapters:
        chapter_number = chapter.chapter
        if chapter_number not in unique_chapters_dict:
            unique_chapters_dict[chapter_number] = chapter
    # Extracting the unique chapter objects
    sorted_chapters = list(unique_chapters_dict.values())
    return sorted_chapters


def notify_send(title, new_chapters, cover_url=None):
    os.system(
        f"""dunstify -i ~/.cache/mdex.jpg -u normal \"Downloaded {new_chapters} new chapters of {title} from MangaDex\" """
    )
    d = DiscordWebHook(f"{title}")
    if cover_url and new_chapters > 0:
        d.send_message(
            f"Downloaded ***{new_chapters}*** new chapters of ***{title}*** from MangaDex",
            image_url=cover_url,
            Ping=True,
        )
    elif new_chapters > 0:
        d.send_message(
            f"Downloaded ***{new_chapters}*** new chapters of ***{title}*** from MangaDex",
            Ping=True,
        )
    else:
        d.send_message(f"No new chapters of ***{title}*** from MangaDex")


def download_chapters(sorted_chapters: list, manga, overwrite=False):
    # name_manga = f"{manga.title['en']}"
    try:
        name_manga = manga.title["en"]
    except KeyError as e:
        name_manga = manga.title["ja-ro"]
    new_chapters = 0
    skipped = 0
    with alive_bar(len(sorted_chapters), title=name_manga) as bar:
        for chapter in sorted_chapters:
            if chapter.title is None:
                chapter.title = ""

            title = chapter.title
            if chapter.volume:
                volume = f"Volume {chapter.volume}"
            else:
                volume = "No Volume"
            pattern = "[\!\?\,\[\]\+\@\#\$\%\^\&\*\.\(\)'\"]"
            title = re.sub(pattern, "", title)
            m_title = re.sub(pattern, "", name_manga)
            bar.text(f" Chapter {chapter.chapter}: {title}")
            already_done = []
            # bar.text(colored(0, 255, 0, "Now downloading chapter..."))
            if chapter.title:
                path_loc = (
                    f"/mnt/NAS/Manga/{m_title}/{volume}/{chapter.chapter} {title}/"
                )
            else:
                path_loc = f"/mnt/NAS/Manga/{m_title}/{volume}/{chapter.chapter}/"
            # if "'" in path_loc or '"' in path_loc:
            #     path_loc = f"/mnt/NAS/Manga/{manga.title['en']}/{chapter.chapter}"
            if not overwrite and os.path.exists(path_loc):
                pass
            else:
                os.system(f"""mkdir -p \"{path_loc}\"""")
                with contextlib.redirect_stdout(None):
                    try:
                        downloader.threaded_dl_chapter(chapter, path_loc, False)
                        new_chapters += 1
                        already_done.append(str(chapter.chapter))
                    except MangaDexPy.APIError as e:
                        if e.status == 400:
                            print(
                                "Bad Request: There was an issue with the API request."
                            )
                            # Additional error handling or actions can be taken here
                        else:
                            print("An API error occurred with status code:", e.status)
                            # Additional error handling or actions can be taken here
            bar()
    print(
        colored(255, 165, 0, "New Chapters Downloaded:"),
        colored(0, 255, 0, new_chapters),
    )
    return new_chapters, name_manga


def get_manga_title(result):
    languages = ["en", "ja-ro", "es", "fr", "ko", "ja"]
    for lang in languages:
        try:
            result_title = result.title[lang]
            return result_title
        except KeyError:
            pass
    return None


class Hirschy_MangaDex:
    def __init__(self, manga_id: str = "", title="", start: float = 0, end: float = -1):
        self.cli = MangaDexPy.MangaDex()
        self.manga_id = manga_id
        self.title = title

    def download_manga_en(self):
        start = datetime.now()
        # Asking the API about that manga with uuid 'manga_id'
        try:
            manga = self.cli.get_manga(self.manga_id)
        except MangaDexPy.NoContentError:
            # API returned a 404 Not Found, therefore the wrapper will return a NoContentError
            print("This manga doesn't exist.")
            exit(1)
        except MangaDexPy.APIError as e:
            # API returned something that wasn't expected, the wrapper will return an APIError
            print("Status code is: " + str(e.status))
            exit(1)
        try:
            manga_title = manga.title["en"]
        except KeyError as e:
            manga_title = manga.title["ja-ro"]
        print(
            f"Manga is: {colored(87,8,97,manga_title)} written by {colored(255,0,0,manga.author[0].name)}"
        )
        cover = f"{manga.cover.url}"
        os.system(f"wget --quiet -O ~/.cache/mdex.jpg {cover}")
        # # Getting chapters for that manga
        chapters = manga.get_chapters()
        sorted_chapters = sort_chapters(chapters)
        new_chapters, name_manga = download_chapters(sorted_chapters, manga)
        end = datetime.now()
        taken = str(end - start)
        message = "Time taken: "
        print(f"{colored(0,0,255, message)}{colored(0,255,0,taken[:10])}")
        notify_send(name_manga, new_chapters, cover)

    def search(self):
        results = self.cli.search("manga", {"title": self.title}, limit=20)
        reses = []
        count = 1
        for result in results:
            # author = self.cli.search("author", {"id": result.author[0]})
            result_title = get_manga_title(result)
            if result_title is None:
                raise Exception(f"Language not matched. {result.title}")
            try:
                print(
                    f"{colored(0,0,255, f'{count}.')} {colored(255,255,0,result_title)}- {result.desc['en'][:40]}...\n"
                    f"URL to Manga: {colored(0,255,0,f'https://mangadex.org/title/{result.id}')}"
                )
            except TypeError:
                print(
                    colored(
                        255,
                        0,
                        0,
                        "This result threw a TypeError. Showing again without desc.",
                    )
                )
                print(
                    f"{colored(0,0,255,f'{count}.')}{colored(255,255,0, result_title)}...\n"
                    f"URL to Manga: {colored(0,255,0,f'https://mangadex.org/title/{result.id}')}"
                )
            except KeyError:
                print(
                    f"{colored(0,0,255, f'{count}.')} {colored(255,0,0, 'No known Title it seems')}"
                )
                print(
                    f"{colored(255,255,0,result.title)}\n"
                    f"Download this manga using the UUID: {colored(0,255,0,result.id)}"
                )
            count += 1
        download_this = int(
            input("Enter the number of the result you'd like to download: ")
        )
        return results[download_this - 1].id
        print(f"Now Downloading:")
        search_dl(manga_id=results[download_this - 1].id)

    def chapter_dl(self):
        self.manga_id = self.search()
        start_chapter = float(input("Choose starting chapter: "))
        end_chapter = float(input("Choose ending chapter: "))
        start_time = datetime.now()
        # Asking the API about that manga with uuid 'manga_id'
        try:
            manga = self.cli.get_manga(self.manga_id)
        except MangaDexPy.NoContentError:
            # API returned a 404 Not Found, therefore the wrapper will return a NoContentError
            print("This manga doesn't exist.")
            exit(1)
        except MangaDexPy.APIError as e:
            # API returned something that wasn't expected, the wrapper will return an APIError
            print("Status code is: " + str(e.status))
            exit(1)
        try:
            manga_title = manga.title["en"]
        except KeyError as e:
            manga_title = manga.title["ja-ro"]
        print(
            f"Manga is: {colored(87,8,97,manga_title)} written by {colored(255,0,0,manga.author[0].name)}"
        )
        # # Getting chapters for that manga
        chapters = manga.get_chapters()
        sorted_chapters = sort_chapters(chapters)
        new_chapters = [
            x
            for x in sorted_chapters
            if float(x.chapter) <= end_chapter and float(x.chapter) >= start_chapter
        ]
        download_chapters(new_chapters, manga)
        end_time = datetime.now()
        taken = str(end_time - start_time)
        message = "Time taken: "
        print(f"{colored(0,0,255, message)}{colored(0,255,0,taken[:10])}")

    def search_dl(self):
        self.manga_id = self.search()
        self.download_manga_en()


def is_valid_uuid(value):
    try:
        uuid.UUID(str(value))
        return True
    except ValueError:
        return False


def main():
    if len(sys.argv) <= 1:
        print("You need to pass the script an argument")
    else:
        argument = sys.argv[1]
        if is_valid_uuid(argument):
            mdex = Hirschy_MangaDex(manga_id=argument)
            mdex.download_manga_en()
        elif argument == "chapter":
            try:
                titl = sys.argv[2]
            except:
                print("Enter a title, please.")
                exit(1)
            mdex = Hirschy_MangaDex(title=titl)
            mdex.chapter_dl()
        elif argument == "updates":
            print("Finding and deleting empty chapters and images....")
            clean_up_parents("/mnt/NAS/Manga/")
            os.system("""find /mnt/NAS/Manga -empty -delete -print""")
            md_list = get_mdlist()
            d = DiscordWebHook("Spam Incoming!")
            d.send_message("Starting mass updates...", Ping=True)
            for manga in md_list:
                mdex = Hirschy_MangaDex(manga_id=manga)
                mdex.download_manga_en()
            d.send_message("Spam complete!", Ping=False)
        else:
            mdex = Hirschy_MangaDex(title=argument)
            mdex.search_dl()


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        sys.exit(1)
