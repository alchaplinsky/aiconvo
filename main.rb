require "bundler/setup"
Bundler.require(:default)

class AIConversation
  AVAILABLE_LMS = {
    openai: {
      api_key: ENV['OPENAI_API_KEY'],
      name: "OpenAI",
      display_name: "OpenAI",
      color: :green,
    },
    palm: {
      api_key: ENV['GOOGLE_PALM_API_KEY'],
      name: "GooglePalm",
      display_name: "PaLM2",
      color: :yellow,
    }
  }
  CONVERSATIONS_DIR = "conversations"

  def initialize
    @logfile = ensure_logfile
    @log = []
  end

  def start
    puts "> Set context for the first AI model (OpenAI):\n".blue
    ai1(:openai).set_context gets.chomp

    puts "> Set context for the secont AI model (PaLM2):\n".blue
    ai2(:palm).set_context gets.chomp

    puts "> Max number of messages to generate:\n".blue
    @message_limit = gets.chomp.to_i

    puts "> Set the topic of the conversation by providing the first message:\n".blue
    message_loop(gets.chomp)
  end

  private

  def message_loop(initial_message)
    message = initial_message
    log_message(:palm, message)

    loop do
      break if @log.size > @message_limit

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
    Langchain::Conversation.new llm: build_llm(key)
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

  def ensure_logfile
    Dir.mkdir(CONVERSATIONS_DIR) unless Dir.exist?(CONVERSATIONS_DIR)

    File.open(File.join(CONVERSATIONS_DIR, "#{Time.now.to_i}.jsonl"), "w")
  end

  def author_color(role)
    AVAILABLE_LMS[role][:color]
  end

  def author_name(role)
    AVAILABLE_LMS[role][:display_name]
  end
end

AIConversation.new.start
