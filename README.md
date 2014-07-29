## Web Scraper
This finds all 404's in a site... can also be used to find broken images, css, etc.

The tool uses Anemone and watir-webdriver.  Using Anemone it collects all linked url's off a main domain.  Then it stores them in an array that Watir loops over and pulls each page into a browser to check it. Failures are storied in a folder called web_scraper.

