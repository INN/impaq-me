class Testimonials
  def self.for_campaign id
    messages = Share.messages_by_campaign id
    messages.shuffle!.first || "Boilerplate, I feel very happy!"
  end
end
