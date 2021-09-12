# frozen_string_literal: true
module StandupsHelper
  def make_presentable(events)
    events.map { |e| { label: [e.title, e.date.to_s].join(' : ') } }
  end
end
