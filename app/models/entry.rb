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
  paginates_per 30

  default_scope order('exercise_id DESC, date_on DESC')

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

  before_validation :link_exercise_from_date_on#, :if => :date_on_changed?

  before_destroy :destroy_forbiden

  def self.setup
    new do |entry|
      entry.date_on = Date.today
      2.times{entry.details.build}
    end
  end

  protected

  def _exercise_id
    target = _read_attribute(:exercise_id)
    target ||= Exercise.from_date_or_default(read_attribute(:date_on)).try(:id)

    errors.add(:base, 'Debe crear al menos un ejercicio para poder consumir el sitema.') if target.nil?

    return target
  end

  def link_exercise_from_date_on
    # FIXME: on migration don't work
    exercise_id = Exercise.from_date(date_on).try(:id) if ENV['COMPANY_ID'].nil?
  end

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
