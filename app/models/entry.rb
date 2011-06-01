# == Schema Information
# Schema version: 20110601133856
#
# Table name: entries
#
#  id            :integer         not null, primary key
#  description   :string(255)
#  date_on       :date
#  exercise_id   :integer
#  details_count :integer         default(0)
#
# Indexes
#
#  index_entries_on_exercise_id  (exercise_id)
#

class Entry < ActiveRecord::Base
  belongs_to :exercise, :counter_cache => true

  has_many :details do
    def balance
      map(&:balance).sum
    end

    def balanced?
      balance.zero?
    end

    def credit
      map(&:credit).compact.sum
    end

    def debit
      map(&:debit).compact.sum
    end
  end

  accepts_nested_attributes_for :details, :reject_if => :all_blank, :allow_destroy => true

  validates_presence_of :exercise, :date_on, :description
  validate :check_balance, :check_many_entries, :date_between_exercise_date

  before_destroy :destroy_forbiden

  default_scope order('exercise_id DESC, date_on DESC')

  def self.setup
    new do |entry|
      entry.date_on = Date.today
      2.times{entry.details.build}
    end
  end

  protected

  def destroy_forbiden
    raise "No es posible borrar asientos ya generados!"
  end

  def date_between_exercise_date
    errors.add(:base, 'La fecha debe estar incluida en el periodo del ejercicio') unless date_on.between?(*exercise.period)
  end

  def check_balance
    errors.add(:base, 'El Asiento debe estar balanceado') unless details.balanced?
  end

  def check_many_entries
    errors.add(:base, 'El Asiento debe tener al menos dos(2) items') unless details.many?
  end
end
