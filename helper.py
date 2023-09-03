import requests, os, shutil
from datetime import datetime


def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{}\033[38;2;255;255;255m".format(r, g, b, text)


def clean_up_parents(directory):
    for root, dirs, files in os.walk(directory, topdown=False):
        for file in files:
            file_path = os.path.join(root, file)
            # Check if the file is empty
            try:
                if os.path.getsize(file_path) == 0:
                    # Delete the parent folder
                    parent_dir = os.path.dirname(file_path)
                    if not any(
                        os.path.isdir(os.path.join(parent_dir, d))
                        for d in os.listdir(parent_dir)
                    ):
                        shutil.rmtree(parent_dir)
                        print(f"Deleting: {colored(255,0,0,parent_dir)}")
            except:
                pass


class DiscordWebHook:
    def __init__(self, bot_name="Webhook Bot"):
        self.bot_name = bot_name
        self.webhook_url = "https://discord.com/api/webhooks/1085380232908902420/67yS35DSklhRDQyf9r-9om4ragu6rpXykkQeXoXoRpa5ACcCeNftme_QxMnbzdUDhatO"

    def send_message(self, content, image_url=None, Ping=False):
        to_ping = "215327353423921159"
        if Ping == True:
            data = {"content": f"<@{to_ping}> {content}", "username": self.bot_name}
        else:
            data = {"content": content, "username": self.bot_name}

        files = None
        if image_url:
            image_data = requests.get(image_url)
            if image_data.status_code == 200:
                files = {"file": ("image.jpg", image_data.content)}

        response = requests.post(self.webhook_url, data=data, files=files)

        if 200 <= response.status_code < 300:
            # print("Webhook message sent successfully!")
            pass
        else:
            print("Failed to send webhook message.")
            print("Response:", response.status_code, response.text)


if __name__ == "__main__":
    webhook = DiscordWebHook("My Bot")
    webhook.send_message(
        "Hello, world!",
        image_url="https://mangadex.org/covers/b5b21ca1-bba5-4b9a-8cd1-6248f731650b/e0fc139a-014e-423d-b9ec-67e3a0937c34.jpg",
    )


def get_mdlist():
    base_url = "https://api.mangadex.org"
    creds = {
        "username": "hirschy",
        "password": "password",
    }
    r = requests.post(f"{base_url}/auth/login", json=creds)
    r_json = r.json()

    session_token = r_json["token"]["session"]
    expires = datetime.now().timestamp() + 15 * 60000
    # refresh_token = r_json["token"]["refresh"]

    base_url = "https://api.mangadex.org"
    list_id = "fcf0cb49-964b-4aec-8f23-40c6e3524b7c"
    r = requests.get(
        f"{base_url}/list/{list_id}",
        headers={"Authorization": f"Bearer {session_token}"},
    )

    manga_ids = [
        relationship["id"]
        for relationship in r.json()["data"]["relationships"]
        if relationship["type"] == "manga"
    ]
    return manga_ids
