import json

import bs4
from scrapegraphai import graphs
from scrapegraphai import docloaders


graph_config = {
    "llm": {
        "model": "ollama/mistral",
        "temperature": 0,
        "format": "json",  # Ollama needs the format to be specified explicitly
        "base_url": "http://host.docker.internal:11434",  # set Ollama URL
    },
    "embeddings": {
        "model": "ollama/nomic-embed-text",
        "base_url": "http://host.docker.internal:11434",  # set Ollama URL
    },
    "verbose": True,
}


urls = ["https://www.amazon.com/Curse-Strahd-Dungeons-Sourcebook-Supplement/dp/0786965983?th=1"]
loader = docloaders.ChromiumLoader(urls)
document = loader.load()

soup = bs4.BeautifulSoup(document[0].page_content.strip(), 'html.parser')
x = soup.find('div', {'id': 'centerCol'})

smart_scraper_graph = graphs.SmartScraperGraph(
    prompt="Describe the productTitle, the product price, the list price and the discount. The product price  and list price should be a simple decimal number. The discount should be a percentage expressed as a string.",
    source=f"<body>{str(x)}</body>",
    config=graph_config
)

result = smart_scraper_graph.run()
print(json.dumps(result, sort_keys=True, indent=4))
