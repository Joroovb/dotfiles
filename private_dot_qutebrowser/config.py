

config.load_autoconfig()

# editor
c.editor.command = ["iTerm", "nvim", "{}"]

# searchengine
c.url.searchengines = {
        'DEFAULT':  'https://google.com/search?hl=en&q={}',
        '!gh':      'https://github.com/search?o=desc&q={}&s=stars',
        '!w':       'https://en.wikipedia.org/wiki/{}',
        '!yt':      'https://www.youtube.com/results?search_query={}',
        '!gs':      'https://scholar.google.com/scholar?hl=en&q={}'
    }

base_url = "https://google.com/"
c.url.default_page = base_url
c.url.start_pages = [base_url]




config.source('theme.py')
