# Introduction
Uses locally hosted LLM & Scrapegraphai to scrape the web with natural language.

## Example

Given the prompt:

```
"List me all the projects with their descriptions at https://perinim.github.io/projects"
```

The systems generates this output:

```
--- Executing Fetch Node ---
--- Executing Parse Node ---
--- Executing RAG Node ---
--- (updated chunks metadata) ---
--- (tokens compressed and vector stored) ---
--- Executing GenerateAnswer Node ---
Processing chunks: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00, 7928.74it/s]
{
    "projects": [
        {
            "description": "Open Source project aimed at controlling a real life rotary pendulum using RL algorithms",
            "title": "Rotary Pendulum RL"
        },
        {
            "description": "Developed a Deep Q-Network algorithm to train a simple and double pendulum",
            "title": "DQN Implementation from scratch"
        },
        {
            "description": "University project which focuses on simulating a multi-agent system to perform environment mapping. Agents, equipped with sensors, explore and record their surroundings, considering uncertainties in their readings.",
            "title": "Multi Agents HAED"
        },
        {
            "description": "Modular drone architecture proposal and proof of concept. The project received maximum grade.",
            "title": "Wireless ESC for Modular Drones"
        }
    ]
}
```

# Setup

## Setup ollama
```bash
brew install ollama
ollama serve
ollama pull mistral
ollama pull nomic-embed-text
```

On a cold start wait for 10 seconds-ish, the model needs time to load.

## Container build

```bash
podman build -t scrapegraphai .
```

## Run the scraper
```bash
podman run -v $(pwd)/src:/home/app/src --network=host -it scrapegraphai python src/main.py
```

# Development

## Local dev
```bash
podman run -v $(pwd)/src:/home/app/src -it scrapegraphai /bin/bash
```

## Installing new Python dependencies
```bash
podman run --user root -v $(pwd):/home/app -it scrapegraphai pipenv install requests
```
