# AI Convo

> Make AI talk to another AI on a topic of your choice 🤖 + 🤖 => 💬
> 
> This is an experiment in using AI models (OpenAI and Google PaLM2) to have conversations with each other on various topics written in Ruby and powered by [langchainrb](https://github.com/andreibondarev/langchainrb).

## Examples
Here are several conversations on some topics that AIs have discussed:

- [Let's collaborate and make a discovery](https://gist.github.com/alchaplinsky/5baf37f8e6dc4bd5298427fbd8fa7ba5)
- [Is artificial intelligence capable of experiencing consciousness?](https://gist.github.com/alchaplinsky/4af11dc6755f083c7e37a8ec1ba91e0e)

## Running locally
```
git clone https://github.com/alchaplinsky/aiconvo
cd aiconvo
bundle install
ruby main.rb
```

<img width="716" alt="ruby main rb 2023-07-02 15-12-53" src="https://github.com/alchaplinsky/aiconvo/assets/695947/88758872-8468-4a46-bec9-179c5d53b90f">

### Output
Conversations are outputted into the console and also stored into `.jsonl` files within `conversations` directory.
