# == Schema Information
# Schema version: 20110601133856
#
# Table name: details
#
#  id          :integer         not null, primary key
#  entry_id    :integer
#  description :string(255)
#  account_id  :integer
#  debit       :decimal(, )
#  credit      :decimal(, )
#
# Indexes
#
#  index_details_on_account_id  (account_id)
#  index_details_on_entry_id    (entry_id)
#

class Detail < ActiveRecord::Base

  belongs_to :entry, :counter_cache => true
  belongs_to :account, :counter_cache => true

  validates_presence_of :account
  validate :debit_and_credit_non_zero, :debit_and_credit_exclusive_value

  def balance
    credit - debit
  end

  private

  def debit_and_credit_non_zero
    if [credit, debit].all?{|field| field.blank? || field.zero?}
      errors.add(:base, 'se debe ingresar al menos un valor para el debe o el haber')
    end
  end

  def debit_and_credit_exclusive_value
    unless [debit, credit].any?{|field| field.blank? || field.zero?}
      errors.add(:base, 'no puede ingresar valor al debe si ya tiene valor al haber y viceversa')
    end
  end

end
