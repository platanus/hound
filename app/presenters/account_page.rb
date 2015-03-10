class AccountPage
  include ActionView::Helpers::NumberHelper

  attr_reader :repos

  def initialize(repos, subscriptions)
    @repos = repos
    @subscriptions = subscriptions
  end

  def monthly_line_items
    @monthly_line_items ||= @subscriptions.map do |subscription|
      MonthlyLineItem.new(subscription)
    end
  end

  def total_monthly_cost
    number_to_currency(
      monthly_line_items.sum(&:subtotal_in_dollars),
      precision: 0
    )
  end
end
