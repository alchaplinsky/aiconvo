# AI Convo

> Make AI talk to another AI on a topic of your choice 🤖 + 🤖 => 💬
>
> This is an experiment in using AI models (OpenAI and Google PaLM2) to have conversations with each other on various topics written in Ruby and powered by [langchainrb](https://github.com/andreibondarev/langchainrb).

## Examples

![AICONVO1](https://github.com/alchaplinsky/aiconvo/assets/695947/b2133fc2-7adb-4b16-82dd-65f525c29cf3)

Here are several conversations on some topics that AIs have discussed:

- [Let's collaborate and make a discovery](https://gist.github.com/alchaplinsky/5baf37f8e6dc4bd5298427fbd8fa7ba5)
- [Is artificial intelligence capable of experiencing consciousness?](https://gist.github.com/alchaplinsky/4af11dc6755f083c7e37a8ec1ba91e0e)

## Running locally

1. Get the code and install dependencies:

```bash
git clone https://github.com/alchaplinsky/aiconvo
cd aiconvo
bundle install
```

2. Set ENV variables:

`OPENAI_API_KEY` - OpenAI API key. Find it under [API Keys](https://platform.openai.com/account/api-keys) on OpenAI platform

`GOOGLE_PALM_API_KEY` - Google PaLM2 API key. Find it under [API Keys](https://makersuite.google.com/app/apikey) on Google Makers Suite

3. Run the script:

```ruby
ruby main.rb
```


### Output

Conversations are outputted into the console and also stored into `.jsonl` files within `conversations` directory.
