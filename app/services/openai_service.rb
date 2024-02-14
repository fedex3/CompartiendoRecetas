class OpenaiService
  include HTTParty
  attr_reader :api_url, :options, :model, :message

  def initialize(message, model = 'gpt-3.5-turbo')
    @message = message
    @model = model
    @api_url = 'https://api.openai.com/v1/chat/completions'
    @options = {
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer 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"
      }
    }
  end

  def call
    body = {
      model:,
      messages: [{ role: 'user', content: message }]
    }
    response = HTTParty.post(api_url, body: body.to_json, headers: options[:headers], timeout: 500)
    raise response['error']['message'] unless response.code == 200
    puts response['choices'][0]['message']['content']
    response['choices'][0]['message']['content']
  end

  class << self
    def call(message, model = 'gpt-3.5-turbo')
      new(message, model).call
    end
  end
end