import requests


def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{} \033[38;2;255;255;255m".format(r, g, b, text)


class DiscordWebHook:
    def __init__(self, bot_name="Webhook Bot"):
        self.bot_name = bot_name
        self.webhook_url = "https://discord.com/api/webhooks/1085380232908902420/67yS35DSklhRDQyf9r-9om4ragu6rpXykkQeXoXoRpa5ACcCeNftme_QxMnbzdUDhatO"

    def send_message(self, content, image_url=None):
        to_ping = "215327353423921159"
        data = {"content": f"<@{to_ping}> {content}", "username": self.bot_name}

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
