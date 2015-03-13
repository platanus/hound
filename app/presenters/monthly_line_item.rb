class MonthlyLineItem
  include ActionView::Helpers::NumberHelper

  vattr_initialize :subscription

  def title
    case @subscription.plan.name
    when "Personal"
      "Private Personal Repos"
    when "Private"
      "Private Repos"
    when "Organization"
      "Private Org Repos"
    else
      @subscription.plan.name
    end
  end

  def base_price
    "#{number_to_currency(amount_in_dollars, precision: 0)}/mo."
  end

  def quantity
    "x#{@subscription.quantity}"
  end

  def subtotal
    number_to_currency(subtotal_in_dollars, precision: 0)
  end

  def subtotal_in_dollars
    @subscription.quantity * amount_in_dollars
  end

  private

  def amount_in_dollars
    @subscription.plan.amount / 100
  end
end
