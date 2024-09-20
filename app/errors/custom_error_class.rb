class CustomErrorClass < StandardError
  attr_reader :status

  def initialize(message, status)
    super(message)

    # when defining status use the word version of status not number
    @status = status.to_sym
  end
end
