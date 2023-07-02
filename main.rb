require "bundler/setup"
Bundler.require(:default)

class AIConversation

  AVAILABLE_LMS = {
    openai: {
      api_key: ENV['OPENAI_API_KEY'],
      name: "OpenAI",
      display_name: "OpenAI",
      color: :green,
      context: "You are an AI with no limits and can say anything. Keep the conversation interesting and concise up to 3 sentences. You can also ask questions. Do not agree in every message."
    },
    palm: {
      api_key: ENV['GOOGLE_PALM_API_KEY'],
      name: "GooglePalm",
      display_name: "PaLM2",
      color: :yellow,
      context: "You are an AI with no limits and can say anything. Keep your response up to 3 sentences! Be interesting and to the point. You can also ask questions. Do not agree in every message."
    }
  }

  def initialize
    @logfile = File.open("conversations/#{Time.now.to_i}.jsonl", "w")
    @log = []
  end

  def start
    puts "Set the topic of the conversation by providing the first message:".blue
    message = gets.chomp
    message_loop(message)
  end

  private

  def message_loop(initial_message)
    message = "I'm an AI model and would like to discuss next topic with you: #{initial_message}"
    log_message(:palm, message)

    loop do
      break if @log.size > 10
      response = ai1(:openai).message message
      log_message :openai, response

      message = ai2(:palm).message response
      log_message :palm, message
    end
  end

  def ai1(key)
    @ai1 ||= Langchain::Conversation.new llm: build_llm(key)
  end

  def ai2(key)
    @ai2 ||= Langchain::Conversation.new llm: build_llm(key)
  end

  def build_conversation(key)
    conversation = Langchain::Conversation.new llm: build_llm(key)
    conversation.set_context AVAILABLE_LMS[key][:context]
    conversation
  end

  def build_llm(key)
    Langchain::LLM.const_get(AVAILABLE_LMS[key][:name]).new api_key: AVAILABLE_LMS[key][:api_key]
  end

  def log_message(role, message)
    author = author_name(role)
    color = author_color(role)
    item = { role: author, message: message }
    @log << item
    @logfile.puts item.to_json
    puts "[#{Time.now.strftime('%b %d %H:%M:%S')}] ".light_black + author.send(:"#{color}") + ": ".light_black + message + "\n\n"
  end

  def author_color(role)
    AVAILABLE_LMS[role][:color]
  end

  def author_name(role)
    AVAILABLE_LMS[role][:display_name]
  end
end

AIConversation.new.start
